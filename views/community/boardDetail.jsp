<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="community.model.vo.*, java.util.ArrayList"%>
<%
	Board b = (Board)request.getAttribute("board");
	ArrayList<Attachment> fileList = (ArrayList<Attachment>)request.getAttribute("fileList");
	System.out.println("fileList : " + fileList);
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
/* 타이틀,라인 */
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
/* 게시물 부분 */
#board_div {
	width: 80%;
	margin: auto;
}
/* 사진 있을 때 */
#board_title {
	height: 50px;
	border-bottom: 1px solid #75757552;
	text-align: justify;
	margin-left:420px;
}
#board_title2 {
	height: 30px;
	border-bottom: 1px solid #75757552;
	text-align: right;
	margin-left:420px;
}
#board_con {
	margin-left:420px;
}
#board_con p {
	padding-left: 10px;
	font-size: 14px;
}
/* 사진 없을 때  */
#Board_title {
	width:100%;
	height: 50px;
	border-bottom: 1px solid #75757552;
	text-align: justify;
}
#Board_title2 {
	width:100%;
	height: 30px;
	border-bottom: 1px solid #75757552;
	text-align: right;
}
#Board_con {
	width:100%;
}
#Board_con p {
	padding-left: 10px;
	font-size: 14px;
}
#btitle {
	line-height: 70px;
	padding-left: 10px;
	color: #757575;
	font-size: 14px;
}
#bcreatedate {
	font-size: 12px;
	color: #757575;
}
#bwriter {
	font-size: 12px;
	color: #757575;
	margin-left: 15px;
}
/* 버튼 */
#btnWrap{
width:80%;
margin:auto;
margin-top:50px;
}
#back {
	width: 100px;
	font-family: "Nanum Gothic";
	border-radius: 10px;
	border: solid 1px #9e9e9e5b;
	padding: 5px 15px 5px 15px;
	background-color: #e6e4e4b6;
	font-weight: bolder;
	margin-top: 20px;
	font-size: 10px;
}
#warning_btn {
	font-family: "Nanum Gothic";
	border-radius: 10px;
	border: solid 1px #9e9e9e5b;
	padding: 5px 15px 5px 15px;
	background-color: #e6e4e4b6;
	font-weight: bolder;
	margin-left: 929px;
	margin-top: -45px;
	font-size: 10px;
}
#imgAreaOuter {
	float:left;
}
.imgAreaInner {
	display: inline-block;
	text-align: center;
}
.addImg {
	width: 400px;
	height: 300px;
	margin-top:30px;
}

#contentWrap {
	height:400px;
}
</style>
</head>
<body>
<%@ include file="../common/common_ui.jsp"%>
<!-- content -->
    <section id="btSection">

        <!-- 타이틀 -->
        <div id="con2_title">
            <h1 class="h1_title"></h1>
        </div>
        <div class="line"></div>
        
        <!-- 사진 있을 때 -->
        <% if(fileList.size() != 0){ %>
        <div id="board_div">
        <div id="imgAreaOuter">
           	<% for(int i = 0; i < fileList.size(); i++) { %>
           	<div class="imgAreaInner">
           	<img class="addImg"
					src="<%= request.getContextPath() %><%= fileList.get(i).getFilePath() %><%= fileList.get(i).getChangeName() %>">
           	</div>
           	<% } %>
           </div>
           
           <div id="contentWrap">
           <div id="board_title">
	           <span id="btitle"><%=b.getbTitle()%></span>
           </div>
           <div id="board_title2">
           		<span id="bcreatedate"><%=b.getCreateDate() %></span>
	           <span id="bwriter">글쓴이 : <%= b.getNickName() %></span>
           </div>
           <div id="board_con"><p><%= (b.getbContent()).replace("\n", "<br>") %></p></div>
           </div>
        </div>
        
            <!-- 버튼 -->
            <div id="btnWrap">
	        <button type="button" class="btn" id="back" onclick="location.href='<%=request.getContextPath() %>/board/main'" id="back">뒤로가기</button>
	        <button class="btn" id="warning_btn">신고</button>
        	</div>
       
        <!-- 사진 없을 때 -->
        <% } else {%>
          <div id="board_div">
           <div id="Board_title">
	           <span id="btitle"><%=b.getbTitle()%></span>
           </div>
           <div id="Board_title2">
           		<span id="bcreatedate"><%=b.getCreateDate() %></span>
	           <span id="bwriter">글쓴이 : <%= b.getNickName() %></span>
           </div>
           <div id="Board_con"><p><%= (b.getbContent()).replace("\n", "<br>") %></p></div>
        </div>
        
        <!-- 버튼 -->
        <div id="btnWrap">
        <button type="button" class="btn" id="back" onclick="location.href='<%=request.getContextPath() %>/board/main'" id="back">뒤로가기</button>
		<button class="btn" id="warning_btn">신고</button>
		</div>
        <% } %>

		<!-- 신고 버튼 누르면 bId, 신고대상, "자유게시판" 넘기기 -->
		<form id="warningForm" method="post">
		<input type="hidden" name="no" value="<%= b.getbId() %>">
		<input type="hidden" name="reported_id" value="<%= b.getUserId() %>"> 
		<input type="hidden" name="category" value="자유게시판">  
		</form>
		
		
        <script>
        const warning_btn = document.getElementById('warning_btn');
    	warning_btn.addEventListener('click',function(){
    		$("#warningForm").attr("action", "<%= request.getContextPath()%>/report/insertForm");
    		$("#warningForm").submit();
    	});
        </script>
        
        </section>
        <%@ include file="../common/footer.jsp" %>
   
</body>
</html>