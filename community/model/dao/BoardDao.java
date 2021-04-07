package community.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import common.model.vo.PageInfo;
import common.model.vo.Search;
import community.model.vo.Attachment;
import community.model.vo.Board;

public class BoardDao {
	private Properties prop = new Properties();

	public BoardDao() {
		String fileName = BoardDao.class.getResource("/sql/community/board-query.xml").getPath();
		try {
			prop.loadFromXML(new FileInputStream(fileName));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 게시글 총 개수 조회
	public int getListCount(Connection conn) {
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getListCount");

		try {
			stmt = conn.createStatement();

			rset = stmt.executeQuery(sql);

			if (rset.next()) {
				listCount = rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		return listCount;

	}

	// 게시물 조회
	public ArrayList<Board> selectList(Connection conn, PageInfo pi) {
		ArrayList<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectList");

		try {
			pstmt = conn.prepareStatement(sql);

			int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
			int endRow = startRow + pi.getBoardLimit() - 1;

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rset = pstmt.executeQuery();

			while (rset.next()) {
				list.add(new Board(rset.getInt(2), 
								   rset.getString(3), 
								   rset.getString(4), 
								   rset.getDate(5),
								   rset.getDate(6), 
								   rset.getInt(7), 
								   rset.getString(8), 
								   rset.getString(9), 
								   rset.getString(10),
								   rset.getString(11)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return list;
	}

	// 검색 리스트 카운트
	public int getSearchListCount(Connection conn, Search s) {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = "";

		if (s.getSearchCondition().equals("writer")) {
			sql = prop.getProperty("getSearchWriterListCount");
		} else if (s.getSearchCondition().equals("title")) {
			sql = prop.getProperty("getSearchTitleListCount");
		} else {
			sql = prop.getProperty("getSearchContentListCount");
		}

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, s.getSearch());

			rset = pstmt.executeQuery();

			if (rset.next()) {
				listCount = rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return listCount;

	}

	// 검색 리스트 조회
	public ArrayList<Board> selectSearchList(Connection conn, PageInfo pi, Search s) {
		ArrayList<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = "";

		if (s.getSearchCondition().equals("writer")) {
			sql = prop.getProperty("selectSearchWriterList");
		} else if (s.getSearchCondition().equals("title")) {
			sql = prop.getProperty("selectSearchTitleList");
		} else {
			sql = prop.getProperty("selectSearchContentList");
		}

		try {
			pstmt = conn.prepareStatement(sql);

			int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
			int endRow = startRow + pi.getBoardLimit() - 1;

			pstmt.setString(1, s.getSearch());
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);

			rset = pstmt.executeQuery();

			while (rset.next()) {
				list.add(new Board(rset.getInt(2), rset.getString(3), rset.getString(4), rset.getDate(5),
						rset.getDate(6), rset.getInt(7), rset.getString(8), rset.getString(9), rset.getString(10),
						rset.getString(11)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;

	}

	// 글쓰기
	public int insertBoard(Connection conn, Board b) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertBoard");

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, b.getbTitle());
			pstmt.setString(2, b.getbContent());
			pstmt.setString(3, b.getUserId());
			pstmt.setString(4, b.getNickName());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
		
	}

	// 조회수 증가
	public int increaseCount(Connection conn, int bId) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("increaseCount");

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, bId);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	// 게시글 조회
	public Board selectBoard(Connection conn, int bId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Board b = null;
		String sql = prop.getProperty("selectBoard");

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, bId);

			rset = pstmt.executeQuery();

			if (rset.next()) {
				b = new Board(rset.getInt(1),
							  rset.getString(2),
							  rset.getString(3),
							  rset.getDate(4),
							  rset.getDate(5),
							  rset.getInt(6),
							  rset.getString(7),
							  rset.getString(8),
							  rset.getString(9),
							  rset.getString(10));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return b;
	}

	// 내가 쓴 글 리스트 조회 
	public ArrayList<Board> selectMyBoardList(Connection conn, PageInfo pi, String userId) {
		ArrayList<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectMyBoardList");
		
		try {
			pstmt = conn.prepareStatement(sql);

			int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
			int endRow = startRow + pi.getBoardLimit() - 1;

			pstmt.setString(1, userId);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);

			rset = pstmt.executeQuery();

			while (rset.next()) {
				list.add(new Board(rset.getInt(2), 
									rset.getString(3),
									rset.getString(4), 
									rset.getDate(5),
									rset.getDate(6), 
									rset.getInt(7), 
									rset.getString(8), 
									rset.getString(9), 
									rset.getString(10),
									rset.getString(11)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return list;
		
	}

	// 내가 쓴 글 총 갯수 구하기 
	public int getMyListCount(Connection conn, String userId) {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getMyListCount");

		try {
			pstmt =  conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);

			rset = pstmt.executeQuery();

			if (rset.next()) {
				listCount = rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return listCount;
	}

	// 게시글 수정 
	public int updateBoard(Connection conn, Board b) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateBoard");

		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, b.getbTitle());
			pstmt.setString(2, b.getbContent());
			pstmt.setInt(3, b.getbId());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
		
	}

	// 게시글 삭제 
	public int deleteBoard(Connection conn, int bId) {
		PreparedStatement pstmt = null;
		int result = 0;

		String sql = prop.getProperty("deleteBoard");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bId);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
		
	}

	// 게시글 파일 첨부
	public int insertPhoto(Connection conn, ArrayList<Attachment> fileList) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertPhoto");
		
		try {
			for(int i = 0; i < fileList.size(); i++) {
				
			pstmt = conn.prepareStatement(sql);
			
			Attachment at = fileList.get(i);
			pstmt.setString(1, at.getOriginName());
			pstmt.setString(2, at.getChangeName());
			pstmt.setString(3, at.getFilePath());
			
			result += pstmt.executeUpdate();

			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		
		return result;
	}

	// 게시글 사진 조회
	public ArrayList<Attachment> selectBoardPhoto(Connection conn, int bId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Attachment> list = new ArrayList<>();
		String sql = prop.getProperty("selectBoardPhoto");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bId);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				list.add(new Attachment(rset.getInt(1),
										rset.getInt(2),
										rset.getString(3),
										rset.getString(4),
										rset.getString(5),
										rset.getString(6)));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		System.out.println("dao - 파일첨부 리스트 : " + list);
		return list;
	}

	
	// 신고 게시물 비활성화 시키기
	public int disabledPost(Connection conn, int cer_id) {
		int result = 0;
		PreparedStatement pstmt = null;

		String sql = prop.getProperty("disabledPost");

		try {

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cer_id);

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			close(pstmt);
		}

		return result;
	}

	public int totalCount(Connection conn) {
		int totalCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("totalCount");
		
		try {
			stmt = conn.createStatement();
			
			rset = stmt.executeQuery(sql);
			
			if(rset.next()) {
				totalCount = rset.getInt(1);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		return totalCount;
	}

	public ArrayList<Board> boardNew(Connection conn) {
		ArrayList<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("boardNew");

		try {
			pstmt = conn.prepareStatement(sql);

			rset = pstmt.executeQuery();

			while (rset.next()) {
				list.add(new Board(rset.getInt(1), 
								   rset.getString(2), 
								   rset.getString(3), 
								   rset.getDate(4),
								   rset.getDate(5), 
								   rset.getInt(6), 
								   rset.getString(7), 
								   rset.getString(8), 
								   rset.getString(9),
								   rset.getString(10)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return list;
	}

}








