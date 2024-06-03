package kr.co.sist.user.board;


import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.co.sist.dao.MyBatisDAO;

public class BoardDAO {
	
	private static BoardDAO bDAO;
	
	private String[] columnNames;
	
	private BoardDAO() {
		columnNames=new String[]{"title","content","id"};
	}
	
	public static BoardDAO getInstance() {
		if(bDAO == null) {
			bDAO=new BoardDAO();
		}//end if
		return bDAO;
	}//getInstance

	/**
	 * 총 레코드의 수
	 * @param sVO
	 * @return
	 * @throws SQLException
	 */
	public int selectTotoalCount(SearchVO sVO)throws PersistenceException{
		int totalCnt=0;
		
		//1. mybatis handler 얻기
		MyBatisDAO mbDAO = MyBatisDAO.getInstance();
		SqlSession ss = mbDAO.getMyBatisHandler(false);
		//2. 쿼리문 실행
		totalCnt = ss.selectOne("kr.co.sist.board.selectTotalCount", sVO);
		//3. mybatis handler 닫기
		mbDAO.closeHandler(ss);
		
		return totalCnt;
	}//totalCount
	
	public List<BoardDomain> selectBoard( SearchVO sVO)throws PersistenceException{
		List<BoardDomain> list = null;
		
		//1.mybatis handler 얻기
		MyBatisDAO mbDAO = MyBatisDAO.getInstance();
		SqlSession ss = mbDAO.getMyBatisHandler(false);
		//2.쿼리문 실행
		list = ss.selectList("kr.co.sist.board.selectBoardList", sVO);
		//3. mybatis harndler 닫기
		mbDAO.closeHandler(ss);
		
		return list;
	}//selectBoard

	
	public void insertBoard( BoardVO bVO )throws PersistenceException{
		
		//1. mybatis 얻기
		MyBatisDAO mbDAO = MyBatisDAO.getInstance();
		SqlSession ss = mbDAO.getMyBatisHandler(true);//true => auto commit
		//2. 쿼리문 실행
		ss.insert("kr.co.sist.board.insertBoard", bVO);
		
		//3. mybatis 닫기
		mbDAO.closeHandler(ss);
	}//insertBoard
	
	
	public BoardDomain selectDetailBoard( int seq )throws PersistenceException{//로그인한 사람만 읽게 int seq, String id
		BoardDomain bd = null;
		
		// 1. mybatis 얻기
		MyBatisDAO mbDAO = MyBatisDAO.getInstance();
		SqlSession ss = mbDAO.getMyBatisHandler(false);
		// 2. 쿼리문 실행
		bd = ss.selectOne("kr.co.sist.board.selectDetailBoard",seq);
		ss.update("kr.co.sist.board.updateCnt",seq);
		// 3. mybatis 닫기
		mbDAO.closeHandler(ss);
			
		return bd;
	}//selectDetailBoard
	
	/**
	 * 조회수 올리기
	 * @param num
	 * @return
	 * @throws SQLException
	 */
	public int updateCnt( int seq )throws PersistenceException{
		int cnt=0;
		
		// 1. mybatis 얻기
		MyBatisDAO mbDAO = MyBatisDAO.getInstance();
		SqlSession ss = mbDAO.getMyBatisHandler(true);//true => auto commit
		// 2. 쿼리문 실행
		cnt = ss.update("kr.co.sist.board.updateCnt", seq);
		// 3. mybatis 닫기
		mbDAO.closeHandler(ss);
		
		return cnt;
	}//updateCnt

	public int updateBoard( BoardVO bVO )throws PersistenceException{
		int cnt=0;
		
		// 1. mybatis 얻기
		MyBatisDAO mbDAO = MyBatisDAO.getInstance();
		SqlSession ss = mbDAO.getMyBatisHandler(true);//true => auto commit
		// 2. 쿼리문 실행
		cnt = ss.update("kr.co.sist.board.updateBoard", bVO);
		// 3. mybatis 닫기
		mbDAO.closeHandler(ss);
		
		return cnt;
	}//updateBoard
	
	public int deleteBoard( BoardVO bVO )throws SQLException{
		int cnt=0;
		
		// 1. mybatis 얻기
		MyBatisDAO mbDAO = MyBatisDAO.getInstance();
		SqlSession ss = mbDAO.getMyBatisHandler(true);// true => auto commit
		// 2. 쿼리문 실행
		cnt = ss.delete("kr.co.sist.board.deleteBoard", bVO);
		// 3. mybatis 닫기
		mbDAO.closeHandler(ss);
		
		return cnt;
	}//deleteBoard
	
	public static void main(String[] args) {
//		SearchVO sVO = new SearchVO();
//		sVO.setField("0");
//		sVO.setKeyword("ㄴ");
//		sVO.setStartNum(1);
//		sVO.setEndNum(20);
//		BoardDAO.getInstance().selectBoard(sVO);
		
//		BoardVO bVO = new BoardVO(0, 530, "mybatis로 추가", "영~차!", "kim", null);
//		BoardDAO.getInstance().selectDetailBoard(103);
//		BoardDAO.getInstance().updateCnt(103);
	}
	
}//class











