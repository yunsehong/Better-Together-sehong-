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

import challenge.model.vo.Challenge;
import common.model.vo.PageInfo;
import community.model.vo.Board;
import community.model.vo.Review;

public class ReviewDao {
	private Properties prop = new Properties();
	
	public ReviewDao() {
		String fileName = BoardDao.class.getResource("/sql/community/review-query.xml").getPath();
		try {
			prop.loadFromXML(new FileInputStream(fileName));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 리뷰 등록
	public int insertReview(Connection conn, Review r) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertReview");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, r.getrContent());
			pstmt.setInt(2, r.getrGrade());
			pstmt.setInt(3, r.getChallNo());
			pstmt.setString(4, r.getUserId());
			pstmt.setString(5, r.getNickName());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("result : " + result);
		
		return result;
		
	}

	// 리뷰 조회
	public ArrayList<Review> selectReviewList(Connection conn, int rId) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		return null;
	}

	// 참여했던 챌린지 조회
	public ArrayList<Challenge> selectJoinedList(Connection conn, String userId) {
		ArrayList<Challenge> cList = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectJoinedList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
	            cList.add(new Challenge(rset.getString(1),
		                              rset.getInt(2),
		                              rset.getString(3),
		                              rset.getDate(4),
		                              rset.getString(5),
		                              rset.getString(6),
		                              rset.getString(7),
		                              rset.getDate(8))
		                             );
	         }
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return cList;
	}

	// 메인에 보일 후기 전체 목록 조회(회원 상관없이)
	public ArrayList<Review> selectTotalReviewList(Connection conn, PageInfo pi) {
		ArrayList<Review> rList = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectTotalReviewList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
			int endRow = startRow + pi.getBoardLimit() - 1;

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				rList.add(new Review(rset.getInt(2),
									 rset.getString(3),
									 rset.getDate(4),
									 rset.getDate(5),
									 rset.getInt(6),
									 rset.getString(7),
									 rset.getInt(8),
									 rset.getString(9),
									 rset.getString(10),
									 rset.getString(11)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		//System.out.println("dao rList : " + rList);
		
		return rList;
	}

	// 리뷰 총 갯수 구하기
	public int getListCount(Connection conn) {
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getListCount");
		
		try {
			stmt = conn.createStatement();
			
			rset = stmt.executeQuery(sql);
			
			if(rset.next()) {
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

	// 페이징 처리 된 내가 쓴 후기 리스트
	public ArrayList<Review> selectMyReviewList(Connection conn, PageInfo pi, String userId) {
		ArrayList<Review> rList = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectMyReviewList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
			int endRow = startRow + pi.getBoardLimit() - 1;

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			pstmt.setString(3, userId);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				rList.add(new Review(rset.getInt(2),
									 rset.getString(3),
									 rset.getDate(4),
									 rset.getDate(5),
									 rset.getInt(6),
									 rset.getString(7),
									 rset.getInt(8),
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
		
		//System.out.println("dao myReviewList : " + rList);
		
		return rList;
	}

	// 리뷰 삭제
	public int deleteBoard(Connection conn, int rId) {
		PreparedStatement pstmt = null;
		int result = 0;

		String sql = prop.getProperty("deleteReview");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rId);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	// 수정 할 후기 한 개 불러 오기
	public Review selectMyOneReview(Connection conn, int rId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectMyOneReview");
		Review r = new Review();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rId);
			
			rset = pstmt.executeQuery();
			while(rset.next()) {
				r = new Review(rset.getInt(2),
								 rset.getString(3),
								 rset.getDate(4),
								 rset.getDate(5),
								 rset.getInt(6),
								 rset.getString(7),
								 rset.getInt(8),
								 rset.getString(9),
								 rset.getString(10),
								 rset.getString(11));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return r;
	}

	// 후기 수정
	public int updateReview(Connection conn, Review r) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateReview");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, r.getrGrade());
			pstmt.setString(2, r.getrContent());
			pstmt.setInt(3, r.getrId());
			
			

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		System.out.println("dao : " + result);
		return result;
	}

	// 별점순 리스트 조회용
	public ArrayList<Review> selectSortByGradeList(Connection conn, PageInfo pi) {
		ArrayList<Review> rList = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectSortByGradeList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
			int endRow = startRow + pi.getBoardLimit() - 1;

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				rList.add(new Review(rset.getInt(2),
									 rset.getString(3),
									 rset.getDate(4),
									 rset.getDate(5),
									 rset.getInt(6),
									 rset.getString(7),
									 rset.getInt(8),
									 rset.getString(9),
									 rset.getString(10),
									 rset.getString(11)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		System.out.println("별점순 rList : " + rList + "\n");
		
		return rList;
		
	}

	public ArrayList<Review> selectSortByDateList(Connection conn, PageInfo pi) {
		ArrayList<Review> rList = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectSortByDateList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
			int endRow = startRow + pi.getBoardLimit() - 1;

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				rList.add(new Review(rset.getInt(2),
									 rset.getString(3),
									 rset.getDate(4),
									 rset.getDate(5),
									 rset.getInt(6),
									 rset.getString(7),
									 rset.getInt(8),
									 rset.getString(9),
									 rset.getString(10),
									 rset.getString(11)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		//System.out.println("dao rList : " + rList);
		
		return rList;
		
	}

	
	
	
	
	
}
