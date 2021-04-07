package community.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import common.model.vo.PageInfo;
import community.model.service.ReviewService;
import community.model.vo.Review;
import member.model.vo.Member;

/**
 * Servlet implementation class ReviewInsertServlet
 */
@WebServlet("/review/insert")
public class ReviewInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = ((Member)request.getSession().getAttribute("loginUser")).getUserId();
		String nickname = ((Member)request.getSession().getAttribute("loginUser")).getNickName();
		String content = request.getParameter("content");
		String star = request.getParameter("star");
		int challNo = Integer.parseInt(request.getParameter("challNo"));
		ReviewService rs = new ReviewService();
		
		// 페이징 영역
				// 게시글 총 갯수 구하기
				int currentPage = 1;
				if(request.getParameter("currentPage") != null) {
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				}
				
				int listCount = rs.getListCount();
				
				int pageLimit = 10;
				int boardLimit = 10;
				int maxPage;
				int startPage;
				int endPage;
				
				maxPage = (int)Math.ceil((double)listCount / boardLimit);
				startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
				endPage = startPage + pageLimit - 1;
				
				// 마지막 페이지 수가 총 페이지 수보다 클 경우는 있을 수 없으므로
				if(maxPage < endPage) {
					endPage = maxPage;
				}
				
				PageInfo pi = new PageInfo(currentPage, listCount, pageLimit, boardLimit,
						maxPage, startPage, endPage);
				
		
		Review r = new Review();
		r.setUserId(userId);
		r.setNickName(nickname);
		r.setrContent(content);
		r.setrGrade(Integer.parseInt(star));
		r.setChallNo(challNo);
		
		System.out.println("r : " + r);
		ArrayList<Review> rList = new ReviewService().insertReview(r,pi);
		// System.out.println("서블릿 rList : " + rList);
		// JSON 또는 GSON 라이브러리 추가 후 rList 응답
		// GSON 사용 시 날짜 값은 Date 포맷에 대한 컨트롤이 필요함(GsonBuilder 객체가 가진 기능)
		// Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		response.setContentType("application/json; charset=utf-8"); 
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(rList, response.getWriter());
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
