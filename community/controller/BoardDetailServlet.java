package community.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import community.model.service.BoardService;
import community.model.vo.Attachment;
import community.model.vo.Board;

/**
 * Servlet implementation class BoardDetailServlet
 */
@WebServlet("/board/detail")
public class BoardDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bId = Integer.parseInt(request.getParameter("bId"));
		
		// bList라는 이름의 쿠키가 있는지 확인하는 변수
				boolean flagbList = false;
				// 해당 bId가 bList 쿠키 value 안에 있는지 확인하는 변수
				boolean flagbId = false;
				
				// 요청으로부터 cookie 정보들을 얻어옴
				Cookie[] cookies = request.getCookies();
				
				// 쿠키가 잘 넘어왔다면
				if(cookies != null) {
					// 넘어온 쿠키 값 배열을 처음부터 끝까지 반복하며 탐색
					for(Cookie c : cookies) {
						// 읽은 게시물 정보를 저장 해 두는 쿠키의 이름 bList가 있는지 확인
						if(c.getName().equals("bList")) {   // 1,3,10,20
							flagbList = true;
							
							// 기존 쿠키 value를 가져와서 decode함(, 등의 특수문자를 인코딩해서 넘기므로)
							String bList = URLDecoder.decode(c.getValue(), "UTF-8");
							// , 구분자 기준으로 나누기
							String[] list = bList.split(",");
							for(String st : list) {
								// 해당 게시글을 읽었다는 정보가 포함되어 있으므로 읽었음을 표시
								if(st.equals(String.valueOf(bId)))
									flagbId = true;
							}
							// 해당 게시글을 읽지 않았다면 쿠키에 해당 게시글 번호를 붙여 다시 인코딩해서 value 세팅
							if(!flagbId) {
								c.setValue(URLEncoder.encode(bList + "," + bId, "UTF-8"));
								response.addCookie(c); // 응답에 담아 보냄
							}
						}
					}
				}
				
				BoardService bs = new BoardService();
				Board b = null;
				
				// bList라는 이름의 쿠키가 없다면 
				if(!flagbList) {
					Cookie c = new Cookie("bList", String.valueOf(bId));
					c.setMaxAge(1 * 24 * 60 * 60);
					response.addCookie(c);
					// 조회수 증가 후 게시글 조회
					b = bs.selectBoard(bId);
				} else if(!flagbId) {
					// bList는 있지만 bId는 없으므로 조회수 증가 후 게시글 조회
					b = bs.selectBoard(bId);
				} else {
					// 조회수 증가 없이 게시글 조회
					b = bs.selectBoardNoCnt(bId);
				}
				
				ArrayList<Attachment> fileList = bs.selectBoardPhoto(bId);
				
				if(b != null) {
					request.setAttribute("board", b);
					request.setAttribute("fileList", fileList);
					request.getRequestDispatcher("/views/community/boardDetail.jsp").forward(request, response);
				} else {
					request.setAttribute("msg", "게시글 상세 조회에 실패하였습니다.");
					request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
				}
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
