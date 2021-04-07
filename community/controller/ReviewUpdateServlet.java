package community.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import community.model.service.ReviewService;
import community.model.vo.Review;

/**
 * Servlet implementation class ReviewUpdateServlet
 */
@WebServlet("/review/update")
public class ReviewUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int rId = Integer.parseInt(request.getParameter("rId"));
		String star = request.getParameter("star");
		String content = request.getParameter("content");
		
		Review r = new Review();
		r.setrId(rId);
		r.setrContent(request.getParameter("content"));
		r.setrGrade(Integer.parseInt(star));
		
		
		// System.out.println("잘 넘어오나 r : " + r);
		
		ReviewService rs = new ReviewService();
		
		int result = rs.updateReview(r);
		
		System.out.println("수정됐나 servlet : " + result);
		
		if(result > 0) {
			request.setAttribute("result", "success");
			request.setAttribute("r", r);
		} else {
			request.setAttribute("result", "fail");
		}
		
		response.setContentType("application/json; charset=utf-8");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(r, response.getWriter());
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
