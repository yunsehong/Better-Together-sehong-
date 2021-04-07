package community.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import challenge.model.vo.Challenge;
import common.model.vo.PageInfo;
import community.model.service.CommuService;
import member.model.vo.Member;

/**
 * Servlet implementation class CommuMainServlet
 */
@WebServlet("/commu/main")
public class CommuMainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommuMainServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int currentPage = 1;

		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}

		CommuService cs = new CommuService();

		// 게시글 총 갯수 구하기(18개)
		int listCount = cs.getRankListCount();
		//System.out.println("서블릿 - 인기챌린지 갯수 :" + listCount);

		int pageLimit = 1; // 한 페이지 하단에 보여질 페이지 수
		int boardLimit = 18; // 한 페이지에 보여질 게시글 최대 수
		int maxPage; // 전체 페이지에서 가장 마지막 페이지
		int startPage; // 한 페이지 하단에 보여질 시작 페이지
		int endPage; // 한 페이지 하단에 보여질 끝 페이지

		maxPage = (int) Math.ceil((double) listCount / boardLimit);
		startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		// * endPage : 현재 페이지에서 보여지는 페이징 바의 마지막 숫자
		endPage = startPage + pageLimit - 1; // 딱 떨어지는 단위 10, 20, 30..

		if (maxPage < endPage) {
			endPage = maxPage;
		}
		
		// 페이징 처리와 관련 된 변수를 클래스 형식으로 만들어 담기
		  PageInfo pi = new PageInfo(currentPage, listCount, pageLimit, boardLimit, maxPage, startPage, endPage);
		  
	      ArrayList<Challenge> list = cs.selectRankList(pi);
	      
	     // System.out.println("서블릿 - 인기챌린지 리스트 :" + list);
	      
	      ArrayList<Member> mlist = cs.selectChallengerLankList();
	      
	     // System.out.println("servlet 챌린저 탑텐 : " + mlist);
	      
	      request.setAttribute("pi", pi);
	      request.setAttribute("list", list);
	      request.setAttribute("mlist", mlist);
		
	      // 찜횟수 가져오기
	    // int cNo = Integer.parseInt(request.getParameter("cNo"));
	    // int hitsCount = cs.getHitsCount(cNo);
	      
	     //request.setAttribute("hitsCount", hitsCount);
	      
		RequestDispatcher view= request.getRequestDispatcher("/views/common/secondMain.jsp");
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
