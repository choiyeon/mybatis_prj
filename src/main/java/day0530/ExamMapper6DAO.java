package day0530;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.co.sist.dao.MyBatisDAO;
import kr.co.sist.domain.BoardDomain;
import kr.co.sist.domain.CarDomain;
import kr.co.sist.domain.EmpDomain;
import kr.co.sist.domain.JoinDomain;

public class ExamMapper6DAO {

	private static ExamMapper6DAO em6DAO;
	
	private ExamMapper6DAO() {
		
	}
	
	public static ExamMapper6DAO getInstance() {
		if(em6DAO == null) {
			em6DAO = new ExamMapper6DAO();
		}
		return em6DAO;
	}//getInstance
	
	public List<EmpDomain> dynamicChoose(int deptno)throws PersistenceException {
		List<EmpDomain> list = null;
		
		//1. MyBatis Handler 얻기
		MyBatisDAO mbDAO = MyBatisDAO.getInstance();
		SqlSession ss = mbDAO.getMyBatisHandler(false);
		list=ss.selectList("kr.co.sist.exam6.dynamicChoose", deptno);
		//3. MyBatis Handler 닫기
		mbDAO.closeHandler(ss);
		
		return list;
	}//subquery
	
	public List<JoinDomain> join(int deptno)throws PersistenceException {
		List<JoinDomain> list = null;
		
		//1. MyBatis Handler 얻기
		MyBatisDAO mbDAO = MyBatisDAO.getInstance();
		SqlSession ss = mbDAO.getMyBatisHandler(false);
		//2. 쿼리문 실행 
		list=ss.selectList("kr.co.sist.exam5.join", deptno);//mapper에서 namespace.select의 id
		//3. MyBatis Handler 닫기
		mbDAO.closeHandler(ss);
		
		return list;
	}//join
	
	public List<CarDomain> join_subquery(String country)throws PersistenceException {
		List<CarDomain> list = null;
		
		//1. MyBatis Handler 얻기
		MyBatisDAO mbDAO = MyBatisDAO.getInstance();
		SqlSession ss = mbDAO.getMyBatisHandler(false);
		//2. 쿼리문 실행 
		list=ss.selectList("kr.co.sist.exam5.join_subquery", country);
		//3. MyBatis Handler 닫기
		mbDAO.closeHandler(ss);
		
		return list;
	}//join_subquery
	
	public List<EmpDomain> dynamicTable(String tName)throws PersistenceException {
		List<EmpDomain> list = null;
		
		//1. MyBatis Handler 얻기
		MyBatisDAO mbDAO = MyBatisDAO.getInstance();
		SqlSession ss = mbDAO.getMyBatisHandler(false);
		//2. 쿼리문 실행 
		list=ss.selectList("kr.co.sist.exam5.dynamicTable", tName);
		//3. MyBatis Handler 닫기
		mbDAO.closeHandler(ss);
		
		return list;
	}//dynamic_table
	
	public List<EmpDomain> dynamicIf(int deptno)throws PersistenceException {
		List<EmpDomain> list = null;
		
		//1. MyBatis Handler 얻기
		MyBatisDAO mbDAO = MyBatisDAO.getInstance();
		SqlSession ss = mbDAO.getMyBatisHandler(false);
		//2. 쿼리문 실행 
		list=ss.selectList("kr.co.sist.exam5.dynamicIf", deptno);
		//3. MyBatis Handler 닫기
		mbDAO.closeHandler(ss);
		
		return list;
	}//dynamicIf
	
	public List<EmpDomain> dynamicIf2(String job)throws PersistenceException {
		List<EmpDomain> list = null;
		
		//1. MyBatis Handler 얻기
		MyBatisDAO mbDAO = MyBatisDAO.getInstance();
		SqlSession ss = mbDAO.getMyBatisHandler(false);
		//2. 쿼리문 실행 
		list=ss.selectList("kr.co.sist.exam5.dynamicIf2", job);
		//3. MyBatis Handler 닫기
		mbDAO.closeHandler(ss);
		
		return list;
	}//dynamicIf2
	
	public static void main(String[] args) {
		ExamMapper6DAO.getInstance().dynamicChoose(11);
	}
	
}//class
