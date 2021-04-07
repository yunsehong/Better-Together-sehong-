<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="community.model.vo.*, java.util.ArrayList" %>
<%
	Board b = (Board)request.getAttribute("b");
	ArrayList<Attachment> fileList = (ArrayList<Attachment>)request.getAttribute("fileList");	

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

.board_div {
	width: 100%;
	margin-left: 110px;
	margin-top: 20px;
}

#updateBtn {
	font-family: "Nanum Gothic";
	border-radius: 10px;
	border: solid 1px #9e9e9e5b;
	padding: 5px 15px 5px 15px;
	background-color: #e6e4e4b6;
	font-weight: bolder;
	margin-left: 69%;
	font-size: 10px;
	margin-top:20px;
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
	font-size: 10px;
	margin-left:13px;
	margin-top:20px;
}

</style>
</head>
<body>
	<%@ include file="../common/common_ui.jsp"%>
	
	<section id="btSection">
		<!-- 타이틀 -->
		<div id="con1_title">
			<h1 class="h1_title">글수정</h1>
		</div>
		<div class="line"></div>

		<form action="<%= request.getContextPath() %>/board/update" method="post">
			<input type="hidden" name="bId" value="<%=b.getbId()%>">
			<div class="board_div">
				<!-- 제목 입력-->
				<div class="form-group">
					<div class="col-sm-10">
						<input type="text" class="form-control" id="write_title"
							name="title" value="<%=b.getbTitle()%>" required>
					</div>
				</div>
				<!-- 내용 입력 -->
				<div class="form-group">
					<div class="col-sm-10">
						<textarea id="summernote" name="content"><%=b.getbContent()%></textarea>
					</div>
				</div>
				
				<!-- 버튼 -->
				<button type="button"  onclick="location.href='<%=request.getContextPath() %>/board/myboardView'" id="back">뒤로가기</button>
				<button id="updateBtn" type="submit">수정 완료</button>
			
			</div>
			
		</form>
		
		
		<script>
			$(document).ready(function() {

				$('#summernote').summernote({
					placeholder : 'Write contents',
					height : 400,
					minHeight : null, // set minimum height of editor
					maxHeight : null, // set maximum height of editor
				});
				
			});
		
		</script>
	</section>
	
	<%@ include file="../common/footer.jsp" %>
   
</body>
</html>