package community.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;

import common.model.vo.MyFileRenamePolicy;
import community.model.service.BoardService;
import community.model.vo.Attachment;
import community.model.vo.Board;
import member.model.vo.Member;

/**
 * Servlet implementation class BoardWriteServlet
 */
@WebServlet("/board/write")
public class BoardWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BoardWriteServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String userId = ((Member) request.getSession().getAttribute("loginUser")).getUserId();
		String nickName = ((Member) request.getSession().getAttribute("loginUser")).getNickName();

		
		// enctype이 multipart/form-data로 전송 되었는지 확인
		if (ServletFileUpload.isMultipartContent(request)) {
			// 전송파일 용량제한 : 10Mbyte로 제한
			int maxSize = 1024 * 1024 * 10;

			// 웹 서버 컨테이너 경로 추출
			String root = request.getSession().getServletContext().getRealPath("/");
			System.out.println("root : " + root);

			// 파일이 실제로 저장 될 경로
			String savePath = root + "resources/uploadFiles/";

			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8",
					new MyFileRenamePolicy());
			
			String title = multiRequest.getParameter("title");
			String content = multiRequest.getParameter("content");

			Board b = new Board(title, content, userId, nickName);
			System.out.println("서블릿b: "+b);
			// DB에 저장하기 위해 change_name과 origin_name 각각의 리스트를 만들어주는 작업
			// 다중 파일을 묶어서 업로드하기에 컬렉션을 사용

			// 전송 된 파일의 원래 이름을 저장할 리스트
			ArrayList<String> originFiles = new ArrayList<String>();
			// 전송 된 파일의 리네임 된 이름(실제 저장 된 이름)을 저장할 리스트
			ArrayList<String> changeFiles = new ArrayList<String>();

			// mutipartRequest로부터 파일에 관한 정보 추출
			// Enumeration은 Iterator의 자바 초기 버전
			// input type="file" 엘리먼트들의 name 속성값 -> getFileNames()
			Enumeration<String> files = multiRequest.getFileNames();

			while (files.hasMoreElements()) {
				String name = files.nextElement();
				System.out.println("name : " + name);

				// 파일이 null이 아닌 경우 (input 태그에 파일이 첨부되어서 넘어온 경우)
				if (multiRequest.getFilesystemName(name) != null) {
					// getFilesystemName("name속성값")
					// -> MyRenamePolicy의 rename 메소드에서 작성 한대로 rename 된 파일명
					changeFiles.add(multiRequest.getFilesystemName(name));
					// getOriginalFileName("name속성값")
					// -> 실제 사용자가 업로드 할 때의 파일명
					originFiles.add(multiRequest.getOriginalFileName(name));
				}
			}

			// Attachment 테이블에 값 삽입을 위한 작업
			ArrayList<Attachment> fileList = new ArrayList<>();
			// 전송 순서 역순으로 파일이 changeFiles, originFiles에 저장 되었기 때문에
			// 반복문을 역으로 수행하기
			for (int i = originFiles.size() - 1; i >= 0; i--) {
				Attachment at = new Attachment();
				
				at.setFilePath("/resources/uploadFiles/");
				at.setOriginName(originFiles.get(i));
				at.setChangeName(changeFiles.get(i));

				fileList.add(at);
			}
			
			System.out.println("fileList : " + fileList);
			
			int result = new BoardService().insertBoard(b,fileList);

			if (result > 0) {
				// 게시글 등록 완료 시 목록으로
				response.sendRedirect(request.getContextPath() + "/board/main");
			} else {
				// 실패 시 저장 된 사진 삭제
				for(int i = 0; i < changeFiles.size(); i++) {
					// 서버에 저장 된 이름 목록을 통해 반복문을 수행하면서
					File failedFile = new File(savePath + changeFiles.get(i));
					failedFile.delete();
				}
				
				request.setAttribute("msg", "게시글 등록에 실패하였습니다.");
				request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
			
			}


		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
