package day0524;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.co.sist.dao.MyBatisDAO;
import kr.co.sist.domain.CpEmpDomain;
import kr.co.sist.vo.CpEmpVO;

public class UseMyBatisHandlerDAO2 {

	public int updateCpEmp(CpEmpVO ceVO)throws PersistenceException{
		int cnt = 0;
		
		//1. MyBatis Handler 얻기
		MyBatisDAO mbDAO = MyBatisDAO.getInstance();
		SqlSession ss = mbDAO.getMyBatisHandler(true);
		//2. 쿼리실행
		cnt = ss.update("kr.co.sist.exam3.updateCpEmp", ceVO);
		//3. MyBatis Handler 닫기
		mbDAO.closeHandler(ss);
		
		return cnt;
	}
	public int deleteCpEmp(int empno)throws PersistenceException{
		int cnt = 0;
		
		//1. MyBatis Handler 얻기
		MyBatisDAO mbDAO = MyBatisDAO.getInstance();
		SqlSession ss = mbDAO.getMyBatisHandler(true);
		//2. 쿼리실행
		cnt = ss.delete("kr.co.sist.exam3.deleteCpEmp", empno);
		//3. MyBatis Handler 닫기
		mbDAO.closeHandler(ss);
		
		return cnt;
	}
	
	public CpEmpDomain selectCpEmp(int empno)throws PersistenceException{
		CpEmpDomain ced = null;
		//1.MyBatis Handler얻기
		MyBatisDAO mbDao = MyBatisDAO.getInstance();
		SqlSession ss = mbDao.getMyBatisHandler(false);
		//2. 실행
		ced = ss.selectOne("kr.co.sist.exam3.selectOneCpEmp", empno);
		//3. MyBatis handler닫기
		mbDao.closeHandler(ss);
		return ced;
	}
	
	public List<CpEmpDomain> selectDept(int deptno) throws PersistenceException{
		List<CpEmpDomain> list = null;
		//1. MyBatis handler 얻기
		MyBatisDAO mbDAO = MyBatisDAO.getInstance();
		SqlSession ss = mbDAO.getMyBatisHandler(false);
		//2. 쿼리실행
		list = ss.selectList("kr.co.sist.exam3.selectAllCpEmp",deptno);
		//3. MyBatis Handler 닫기
		mbDAO.closeHandler(ss);
		return list;
	}
	public static void main(String[] args) {
		UseMyBatisHandlerDAO2 umbhDAO = new UseMyBatisHandlerDAO2();
//		CpEmpVO ceVO = new CpEmpVO(7521, 3000, 0, 20, "테스트", "SI", null);
//		int cnt = umbhDAO.updateCpEmp(ceVO);
//		System.out.println(cnt);
//		umbhDAO.deleteCpEmp(7521);
//		CpEmpDomain ced = umbhDAO.selectCpEmp(7788);
		List<CpEmpDomain> list = umbhDAO.selectDept(20);
		System.out.println(list);
	}//main
}//class
