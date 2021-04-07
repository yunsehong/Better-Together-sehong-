<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.ArrayList, community.model.vo.*, common.model.vo.PageInfo"%>
<%
	
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Better Together</title>
</head>
<style>
#btSection {
	padding-bottom: 100px;
}

#con1_title h1 {
	position: absolute;
	width: 1000px;
	text-align: center;
	margin-top: 25px;
}

.h1_title {
	margin-top: 50px;
	text-align: center;
	font-family: "Do Hyeon";
	font-size: 24px;
	color: #757575;
}

.line {
	border: 0.5px solid #937cf790;
}

/* 게시판 */
#board_tb {
	width: 100%;
	/* height: 400px; */
	border-collapse: collapse;
	margin-top:30px;
}

#board_div {
	width: 80%;
	margin: auto;
}

#board_tb tr {
	height: 30px;
}

#board_tb th, #board_tb td {
	border-bottom: 1px solid #75757552;
	padding: 2px;
}

#board_tb th {
	background: #fff;
}

#board_tb td {
	height: 30px;
}

#tb_no {
	width: 5%;
}

#tb_title {
	width: 60%;
	 text-align:center;
}

#tb_date {
	width: 15%;
	 text-align:center;
}

#tb_views {
	width: 5%;
	 text-align:center;
}

#tb_updatebtn {
	width: 25%;
}

#th_title {
	background: rgba(240, 240, 240, 0.7);
	height: 30px;
	font-family: "Do Hyeon";
	font-size: 14px;
	color: #757575;
}

.btn2 {
	font-family: "Nanum Gothic";
	border-radius: 10px;
	border: solid 1px #9e9e9e5b;
	padding: 5px 15px 5px 15px;
	background-color: #e6e4e4b6;
	font-size: 10px;
	height: 25px;
	margin-left:15px;
}
/* 하단 버튼 */
#write {
	font-family: "Nanum Gothic";
	border-radius: 10px;
	border: solid 1px #9e9e9e5b;
	padding: 5px 15px 5px 15px;
	background-color: #e6e4e4b6;
	font-weight: bolder;
	margin-left: 68%;
	font-size: 10px;
}


#back {
	width: 80px;
	font-family: "Nanum Gothic";
	border-radius: 10px;
	border: solid 1px #9e9e9e5b;
	padding: 5px 15px 5px 15px;
	background-color: #e6e4e4b6;
	font-weight: bolder;
	margin-left: 10%;
	font-size: 10px;
}


/* 페이징바 영역 */
.pagingArea {
	text-align: center;
}

.pagingArea button {
	width: 25px;
	margin-top: 20px;
	border: 0px;
	color: #757575;
	font-family: "Nanum Gothic";
	font-size: 12px;
}

.pagingArea button:hover {
	cursor: pointer;
}
</style>
<body>
	<%@ include file="../common/common_ui.jsp"%>
	
	<!-- content -->
	<section id="btSection">
		

		<!-- 타이틀 -->
		<div id="con2_title">
			<h1 class="h1_title">내가 쓴 글</h1>
		</div>
		<div class="line"></div>

		<!-- 내가 쓴 글 목록 -->
		<div id="board_div">
			<table id="board_tb">
				<tr id="th_title">
					<th id="tb_no"></th>
					<th id="tb_title">제목</th>
					<th id="tb_date">작성일</th>
					<th id="tb_views">조회수</th>
					<th id="tb_updatebtn"></th>
				</tr>
				 <% if(list.isEmpty()) { %>
                <tr>
                	<td colspan="5">조회 된 게시글이 없습니다.</td>
                </tr>
                <% } else { %>
					
	                	<% for(Board bd : list) { %>
	                		<tr>
	                		<td style=text-align:center;><%= bd.getbId() %></td>
	                		<td><%= bd.getbTitle() %></td>
	                		<td style=text-align:center;><%= bd.getCreateDate() %></td>
	                		<td style=text-align:center><%= bd.getbCount() %></td>
	                		<td>
	                		<button class="btn2" id="updateBtn" >수정</button>
							<button class="btn2" id="deleteBtn">삭제</button>
							</td>
	                		</tr>
	                	<% } %>
                <% } %>
			</table>
		</div>
		
		 <script>
			$(function(){
				$("#board_tb #updateBtn").mouseenter(function(){
					$(this).parent().parent().css("background","#937cf755");
				}).mouseout(function(){
					$(this).parent().parent().css("background", "none");
				}).click(function(){
					var bId = $(this).parent().parent().children().eq(0).text();
					console.log(bId);
					// 로그인 한 사람만 내가 쓴 글 수정 가능하도록
					<% if(loginUser != null) { %>
						location.href='<%= request.getContextPath() %>/board/updateForm?bId=' + bId;
					<% } else { %>
						alert('로그인 해야만 게시글 보기가 가능합니다.');
					<% } %>
				});
			})
			$(function(){
				$("#board_tb #deleteBtn").mouseenter(function(){
					$(this).parent().parent().css("background","#937cf755");
				}).mouseout(function(){
					$(this).parent().parent().css("background", "none");
				}).click(function(){
					var bId = $(this).parent().parent().children().eq(0).text();
					console.log(bId);
					// 로그인 한 사람만 내가 쓴 글 삭제 가능하도록
					<% if(loginUser != null) { %>
						location.href='<%= request.getContextPath() %>/board/delete?bId=' + bId;
					<% } else { %>
						alert('로그인 해야만 게시글 보기가 가능합니다.');
					<% } %>
				});
			})
		</script>
			

		
		<!-- 페이징 바 -->
		<div class="pagingArea">
			<!-- 맨 처음으로 (<<) -->
			<button onclick="location.href='<%= request.getContextPath() %>/board/myboardView?currentPage=1'"> &lt;&lt; </button>
			
			<!-- 이전 페이지로 (<) -->
			<% if(pi.getCurrentPage() == 1){ %>
				<button disabled> &lt; </button>
			<%} else { %>
				<button onclick="location.href='<%= request.getContextPath() %>/board/myboardView?currentPage=<%= pi.getCurrentPage() - 1 %>'"> &lt; </button>
			<%} %>	
			
			<!-- 10개의 페이지 목록 -->
			<% for(int p = pi.getStartPage(); p <= pi.getEndPage(); p++){ %>
				<% if(p == pi.getCurrentPage()){ %>
					<button style="background:lightgray;" disabled> <%= p %> </button>
				<%}else{ %>
					<button onclick="location.href='<%= request.getContextPath() %>/board/myboardView?currentPage=<%= p %>'"> <%= p %> </button>
				<% } %>
			<%} %>
			
			<!-- 다음 페이지로(>) -->
			<%if(pi.getCurrentPage() == pi.getMaxPage()){ %>
				<button disabled> &gt; </button>
			<%} else {%>
				<button onclick="location.href='<%= request.getContextPath() %>/board/myboardView?currentPage=<%= pi.getCurrentPage() + 1 %>'"> &gt; </button>
			<% } %>
			
			<!-- 맨 끝으로(>>) -->
			<button onclick="location.href='<%= request.getContextPath() %>/board/myboardView?currentPage=<%= pi.getMaxPage() %>'"> &gt;&gt; </button>
		</div>
		

		<!-- 버튼 -->
		<button class="btn" id="back" onclick='location.href="<%= request.getContextPath()%>/board/main"'>
			뒤로가기
		</button>
		<button class="btn" id="write" onclick='location.href="<%= request.getContextPath()%>/views/community/boardWrite.jsp"'>
			글쓰기
		</button>
	</section>
	
	<%@ include file="../common/footer.jsp" %>
</body>
</html>