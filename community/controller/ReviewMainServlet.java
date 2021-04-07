package community.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import challenge.model.vo.Challenge;
import common.model.vo.PageInfo;
import community.model.service.ReviewService;
import community.model.vo.Review;
import member.model.vo.Member;

/**
 * Servlet implementation class ReviewMainServlet
 */
@WebServlet("/review/main")
public class ReviewMainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewMainServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 로그인 유저의 참여했던 챌린지 조회해야 함(셀렉-옵션 칸 안에 넣음)
		String userId = "";
		Challenge chall = new Challenge();
		ReviewService rs = new ReviewService();
		
		if((Member)request.getSession().getAttribute("loginUser") != null) {
		 userId = ((Member)request.getSession().getAttribute("loginUser")).getUserId();
		 chall.setUserId(userId);
		 ArrayList<Challenge> cList = rs.selectJoinedList(userId);
		 request.setAttribute("cList", cList);
		} 
		
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
		
		// pi넘겨서 페이징 처리하기
		ArrayList<Review> rList = rs.selectReviewList(pi);
		
		request.setAttribute("pi", pi);
		request.setAttribute("rList", rList);
		
		
		RequestDispatcher view= request.getRequestDispatcher("/views/community/reviewMain.jsp");
		view.forward(request, response);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
