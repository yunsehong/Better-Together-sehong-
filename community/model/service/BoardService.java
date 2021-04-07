package community.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import challenge.model.dao.ChallDao;
import common.model.vo.PageInfo;
import common.model.vo.Search;
import community.model.dao.BoardDao;
import community.model.vo.Attachment;
import community.model.vo.Board;

public class BoardService {

	// 게시글 페이징을 위해 총 게시글 갯수 구하기
	public int getListCount() {
		Connection conn = getConnection();

		int listCount = new BoardDao().getListCount(conn);

		close(conn);

		return listCount;
	}

	// 페이징 처리가 된 게시글 목록 조회
	public ArrayList<Board> selectList(PageInfo pi) {
		Connection conn = getConnection();

		ArrayList<Board> list = new BoardDao().selectList(conn, pi);

		close(conn);

		return list;
	}

	// 검색용 리스트 카운트
	public int getSearchListCount(Search s) {
		Connection conn = getConnection();

		int listCount = new BoardDao().getSearchListCount(conn, s);

		close(conn);

		return listCount;
	}

	// 검색용 리스트 조회
	public ArrayList<Board> selectSearchList(PageInfo pi, Search s) {
		Connection conn = getConnection();

		ArrayList<Board> list = new BoardDao().selectSearchList(conn, pi, s);

		close(conn);

		return list;
	}

	// 글쓰기 & 파일 첨부
	public int insertBoard(Board b, ArrayList<Attachment> fileList) {
		Connection conn = getConnection();

		int result = new BoardDao().insertBoard(conn, b);
		int result2 = new BoardDao().insertPhoto(conn, fileList);

		if (result > 0 && result2 == fileList.size()) {
			commit(conn);
		} else {
			rollback(conn);
		}

		close(conn);

		System.out.println(result);
		System.out.println(result2);
		return result;
	}

	// 게시글 상세보기 (조회수 증가)
	public Board selectBoard(int bId) {
		Connection conn = getConnection();

		BoardDao bd = new BoardDao();
		// 조회수 증가
		int result = bd.increaseCount(conn, bId);

		Board b = null;

		if (result > 0) {
			commit(conn);
			b = bd.selectBoard(conn, bId);
		} else {
			rollback(conn);
		}

		close(conn);

		return b;
	}

	// 게시글 상세보기 (조회수 증가 없이)
	public Board selectBoardNoCnt(int bId) {
		Connection conn = getConnection();
		Board b = new BoardDao().selectBoard(conn, bId);
		close(conn);
		return b;
	}

	
	// 내가 쓴 글 리스트 조회 
	public ArrayList<Board> selectMyBoardList(PageInfo pi, String userId) {
		Connection conn = getConnection();

		ArrayList<Board> list = new BoardDao().selectMyBoardList(conn, pi, userId);

		close(conn);

		return list;
	}

	// 내가 쓴 글 리스트 갯수(페이징 처리를 위해)
	public int getMyListCount(String userId) {
		Connection conn = getConnection();

		int listCount = new BoardDao().getMyListCount(conn, userId);

		close(conn);

		return listCount;
		
	}

	// 게시글 수정
	public int updateBoard(Board b) {
		Connection conn = getConnection();
		
		int result = new BoardDao().updateBoard(conn, b);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}

		close(conn);

		return result;
	}

	// 게시글 삭제 
	public int deleteBoard(int bId) {
		Connection conn = getConnection();

		int result = new BoardDao().deleteBoard(conn, bId);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}

		close(conn);

		return result;
		
	}

	// 게시글 사진 조회
	public ArrayList<Attachment> selectBoardPhoto(int bId) {
		Connection conn = getConnection();
		
		ArrayList<Attachment> list = new BoardDao().selectBoardPhoto(conn, bId);
		
		close(conn);
		
		return list;
		
	}

	//신고받은 게시물 비활성화 시키기
	public int disabledPost(int cer_id) {
		Connection conn = getConnection();

		int result = new BoardDao().disabledPost(conn, cer_id);
		
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		
		return result;
	}

	public int totalCount() {
		Connection conn = getConnection();

		int totalCount = new BoardDao().totalCount(conn);
		
		close(conn);
		
		return totalCount;
	}

	public ArrayList<Board> boardNew() {
		Connection conn = getConnection();

		ArrayList<Board> list = new BoardDao().boardNew(conn);

		close(conn);

		return list;
	}

}
