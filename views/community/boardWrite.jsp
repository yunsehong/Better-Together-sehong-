<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

/* 하단 버튼 */
.submitBtn {
	font-family: "Nanum Gothic";
	border-radius: 10px;
	border: solid 1px #9e9e9e5b;
	padding: 5px 15px 5px 15px;
	background-color: #e6e4e4b6;
	font-weight: bolder;
	margin-left: 70%;
	font-size: 10px;
	margin-top:20px;
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
			<h1 class="h1_title">글쓰기</h1>
		</div>
		<div class="line"></div>

		<form action="<%=request.getContextPath()%>/board/write" method="post"
			enctype="multipart/form-data">
			<div class="board_div">
				<!-- 제목 입력 -->
				<div class="form-group">
					<div class="col-sm-10">
						<input type="text" class="form-control" id="write_title"
							name="title" placeholder="Title">
					</div>
				</div>
				<!-- 내용 입력 -->
				<div class="form-group">
					<div class="col-sm-10">
						<textarea id="summernote" name="content"></textarea>
					</div>
				</div>

				<!-- 버튼 -->
				<button type="button" class="btn" id="back"
					onclick="javascript:history.back();">뒤로가기</button>
				<button class="submitBtn" id="submit" type="submit">등록</button>


			</div>
		</form>

		<script>
			$(document).ready(function() {

				$('#summernote').summernote({
					placeholder : 'Write contents',
					height : 400,
					minHeight : null, // set minimum height of editor
					maxHeight : null, // set maximum height of editor
					callbacks: {	//여기 부분이 이미지를 첨부하는 부분
						onImageUpload : function(files) {
							uploadSummernoteImageFile(files[0],this);
						}
					}
				});
				
			});
		
			
			function uploadSummernoteImageFile(file, editor) {
				data = new FormData();
				data.append("file", file);
				$.ajax({
					data : data,
					type : "POST",
					url : "/uploadSummernoteImageFile",
					contentType : false,
					processData : false,
					success : function(data) {
		            	//항상 업로드된 파일의 url이 있어야 한다.
						$(editor).summernote('insertImage', data.url);
					}
				});
			}
		</script>

	</section>

	<%@ include file="../common/footer.jsp" %>
   
    
    

</body>
</html>