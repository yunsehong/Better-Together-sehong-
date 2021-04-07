package community.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import challenge.model.vo.Challenge;
import common.model.vo.PageInfo;
import community.model.dao.BoardDao;
import community.model.dao.ReviewDao;
import community.model.vo.Review;

public class ReviewService {
	// loginUser가 참여했던 챌린지 조회
		public ArrayList<Challenge> selectJoinedList(String userId) {
			Connection conn = getConnection();
			ReviewDao rd = new ReviewDao();
			
			ArrayList<Challenge> cList = rd.selectJoinedList(conn,userId);
			
			close(conn);
			
			return cList;
		}

	
	// 댓글 추가 + 새로 갱신 된 댓글 리스트 조회
	public ArrayList<Review> insertReview(Review r, PageInfo pi) {
		Connection conn = getConnection();
		ReviewDao rd = new ReviewDao();
		int result = rd.insertReview(conn, r);
		
		ArrayList<Review> rList = null;
		
		if(result > 0) {
			commit(conn);
			rList = rd.selectTotalReviewList(conn,pi);
		} else {
			rollback(conn);
		}
		System.out.println("서비스 rList : " + rList);
		return rList;
	}

	// 리뷰 전체 리스트 조회, 별점순, 최신순 포함
	public ArrayList<Review> selectReviewList(PageInfo pi) {
		Connection conn = getConnection();
		ReviewDao rd = new ReviewDao();
		ArrayList<Review> rList = null;
		
		rList = rd.selectTotalReviewList(conn, pi);
		
		close(conn);
		
		//System.out.println("service rList : " + rList);
		
		return rList;
	}

	// 게시글 총 갯수 구하기
	public int getListCount() {
		Connection conn = getConnection();

		int listCount = new ReviewDao().getListCount(conn);

		close(conn);

		return listCount;
		
	}

	
	// 페이징 처리 된 내가 쓴 후기 리스트
	public ArrayList<Review> selectMyReviewList(PageInfo pi, String userId) {
		Connection conn = getConnection();
		ReviewDao rd = new ReviewDao();
		ArrayList<Review> rList = null;
		
		rList = rd.selectMyReviewList(conn, pi, userId);
		
		close(conn);
		
		System.out.println("service MyReviewList : " + rList);
		
		return rList;
	}


	// 후기 삭제
	public int deleteReview(int rId) {
		Connection conn = getConnection();

		int result = new ReviewDao().deleteBoard(conn, rId);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}

		close(conn);

		return result;
		
	}

	// 수정할 후기 불러 오기
	public Review selectMyOneReview(int rId) {
		Connection conn = getConnection();
		
		Review r = new ReviewDao().selectMyOneReview(conn, rId);
		
		close(conn);
		
		return r;
	}


	// 후기 수정
	public int updateReview(Review r) {
		Connection conn = getConnection();
		
		int result = new ReviewDao().updateReview(conn, r);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}

		close(conn);

		System.out.println("수정됐나 service : " + result);
		
		return result;
		
	}


	public ArrayList<Review> selectSortByGradeList(PageInfo pi) {
		Connection conn = getConnection();
		ReviewDao rd = new ReviewDao();
		ArrayList<Review> rList = null;
		
		rList = rd.selectSortByGradeList(conn, pi);
		
		close(conn);
		
		System.out.println("service rList : " + rList);
		
		return rList;
		
	}


	public ArrayList<Review> selectSortByDateList(PageInfo pi) {
		Connection conn = getConnection();
		ReviewDao rd = new ReviewDao();
		ArrayList<Review> rList = null;
		
		rList = rd.selectSortByDateList(conn, pi);
		
		close(conn);
		
		//System.out.println("service rList : " + rList);
		
		return rList;
		
	}

	
}
