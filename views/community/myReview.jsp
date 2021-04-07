<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="community.model.vo.*, java.util.ArrayList, challenge.model.vo.Challenge, common.model.vo.*"%>
<%
	ArrayList<Review> rList = (ArrayList<Review>) request.getAttribute("rList");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	
	System.out.println("rList : " + rList);
	System.out.println("pi: " + pi);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Better Together</title>
<style>

#btSection {
	padding-bottom: 100px;
}

#con1_title h1 {
	text-align: center;
	margin-top: 25px;
}

.h1_title {
	margin-top: 50px;
	text-align: center;
	font-size: 24px;
	color: #757575;
}

.line {
	border: 0.5px solid #937cf790;
}

/* 후기 목록 */
.reviewWrap {
	margin-top:100px;
}

.reviewdiv{
	width: 80%;
	height: 100px;
	background: #fff;
	margin: auto;
	margin-top:50px;
}

#reviewTb {
	width: 100%;
	height: 100px;
}
 #reviewTb tr:nth-child(1) {height:20%; margin-top:5px;}

#nickname, #starArea, #createDate, #challName {
	display: inline-block;
	margin-left: 10px;
}

#starArea {
	margin-left: 10px;
	color: #937cf790;
}


#contentArea {
	display: inline-block;
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 10px;
}

/* 페이징 바 */
#pagenum {
	width: 200px;
	height: 30px;
	margin: auto;
	margin-top: 20px;
	text-align: center;
}

#pagenum a {
	font-size: 18px;
	padding: 5px;
	color: #757575;
}

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

.btnwrap {
text-align:right;
	margin-left: 85%;
	margin-top: 10px;
	margin-bottom : 10px;
}

.btn2 {
	width: 60px;
	font-family: "Nanum Gothic";
        	border-radius: 10px;
           border: solid 1px #9e9e9e5b;
           padding:5px 15px 5px 15px;
           background-color: #e6e4e4b6;
           font-weight: bolder;  
          /*  margin-left:70%; */
           font-size: 10px;
}

#back {
	font-family: "Nanum Gothic";
        	border-radius: 10px;
           border: solid 1px #9e9e9e5b;
           padding:5px 15px 5px 15px;
           background-color: #e6e4e4b6;
           font-weight: bolder;  
           margin-left:85%;
           font-size: 10px;
           margin-top:55px;
}

#back a {
	
	color: #ff60657e;
}
</style>
</head>
<body>
<%if(session.getAttribute("msg") != null){ %>
<script>
   alert('<%=session.getAttribute("msg") %>');
   
</script>
<%
   session.removeAttribute("msg");
    }
%>
	<%@ include file="../common/common_ui.jsp"%>
	<!-- content -->
	<section id="btSection">
		<!-- 타이틀 -->
		<div id="con1_title">
			<h1 class="h1_title">내가 쓴 후기</h1>
		</div>

		<div class="line"></div>

		
		<div class="reviewWrap">
		<% if(rList != null) { %>
		<% for(Review r : rList)  {%>
		
		<div class="reviewdiv">
			<table id="reviewTb">
				<tr>
					<input type="hidden" id="rId" name="rId" value="<%=r.getrId()%>">
					<td id="nickname"><%= r.getNickName() %></td>
					<td id="challName"><%= r.getChallTitle() %></td>
					<td id="starArea"><%if(r.getrGrade() == 5) { %> ★★★★★ 
									  <% } else if(r.getrGrade() == 4) { %>★★★★
									  <% } else if(r.getrGrade() == 3) { %>★★★
									  <% } else if(r.getrGrade() == 2) { %>★★
									  <% } else { %>★<% } %>
					</td>
					<td id="createDate"><%= r.getCreateDate() %></td>
				</tr>
				<tr>
					<td id="contentArea"><%= r.getrContent() %></td>
				</tr>
			</table>
				<div class="btnwrap">
				<button class="btn2" id="updateBtn" onclick="window.open('<%= request.getContextPath() %>/review/updateForm?rId=<%=r.getrId()%>', '댓글 수정 창', 'width=900, height=300')">수정</button>
		
				<button class="btn2" onclick="location.href='<%= request.getContextPath() %>/review/delete?rId=<%=r.getrId()%>'">
				삭제
				</button>
				</div>
		</div>
		
		<% } %>
		<% } %>
		
		</div>
		
		
		<!-- 페이징 바 -->
		<div class="pagingArea">
			<!-- 맨 처음으로 (<<) -->
			<button onclick="location.href='<%= request.getContextPath() %>/review/myReview?currentPage=1'"> &lt;&lt; </button>
			
			<!-- 이전 페이지로 (<) -->
			<% if(pi.getCurrentPage() == 1){ %>
				<button disabled> &lt; </button>
			<%} else { %>
				<button onclick="location.href='<%= request.getContextPath() %>/review/myReview?currentPage=<%= pi.getCurrentPage() - 1 %>'"> &lt; </button>
			<%} %>	
			
			<!-- 10개의 페이지 목록 -->
			<% for(int p = pi.getStartPage(); p <= pi.getEndPage(); p++){ %>
				<% if(p == pi.getCurrentPage()){ %>
					<button style="background:lightgray;" disabled> <%= p %> </button>
				<%}else{ %>
					<button onclick="location.href='<%= request.getContextPath() %>/review/myReview?currentPage=<%= p %>'"> <%= p %> </button>
				<% } %>
			<%} %>
			
			<!-- 다음 페이지로(>) -->
			<%if(pi.getCurrentPage() == pi.getMaxPage()){ %>
				<button disabled> &gt; </button>
			<%} else {%>
				<button onclick="location.href='<%= request.getContextPath() %>/review/myReview?currentPage=<%= pi.getCurrentPage() + 1 %>'"> &gt; </button>
			<% } %>
			
			<!-- 맨 끝으로(>>) -->
			<button onclick="location.href='<%= request.getContextPath() %>/review/myReview?currentPage=<%= pi.getMaxPage() %>'"> &gt;&gt; </button>
		</div>
		
		<!-- 뒤로가기 버튼 -->
		<button class="btn" type="button" onclick="location.href='<%= request.getContextPath() %>/review/main'" id="back">뒤로가기</button>
	</section>

<%@ include file="../common/footer.jsp" %>
</body>
</html>