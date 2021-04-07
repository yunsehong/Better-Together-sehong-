<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="community.model.vo.Review"%>
<%
	Review r = (Review)request.getAttribute("r");
%>
<!DOCTYPE html>
<html>
<head>
 <script src="https://code.jquery.com/jquery-3.5.1.min.js"
		integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
		crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Better Together</title>
<%
	if(request.getAttribute("result") != null){
		if(request.getAttribute("result").equals("success")) {
%>
<script>
	alert("후기가 수정 되었습니다.");
	window.close();
</script>
<%      } else { %>
<script>
	alert("후기 수정에 실패하였습니다.");
</script>
<%		}
	}%>

<style>

#contentArea{width:840px; height:90px;
border:1px solid lightgray;
margin-left:20px;}

#h2_title {
	text-align:center;
	color: #757575;
	font-size: 20px;
	font-family: "Nanum Gothic";
}
#reviewTb {
	float:left;
}
#star a {
	text-decoration: none;
	color: rgb(172, 172, 172);
	font-size: 25px;
	margin-top: 3px;
}

#star a.on {
	color: #937cf790;
}

#starArea {
	margin-left: 10px;
	color: rgba(255, 96, 100, 0.7);
}
#reviewTb td:nth-child(1){
	margin-left:20px;
}
.btnArea{
	margin-top:22px;
}
.btn{
	font-family: "Nanum Gothic";
        	border-radius: 10px;
           border: solid 1px #9e9e9e5b;
           padding:5px 15px 5px 15px;
           background-color: #e6e4e4b6;
            font-size: 10px;
            margin-left:10px;
}
#star {
	margin-left:10px;
	margin-right:400px;
}
#challName {
margin-left:20px;
font-size: 14px;
color: #757575;
}
</style>
</head>
<body>
	<section id="btSection">
	<h2 id="h2_title">댓글 수정</h2>
	<br>
	
		 <table id="reviewTb">
					<tr>
						<%-- <td id="nickname"><%= r.getNickName() %></td> --%>
						<td><p id="challName"><%= r.getChallTitle() %></p></td>
						<td id="starArea">
							<p id="star">
								<a href="#" value=1>★</a> 
								<a href="#" value=2>★</a> 
								<a href="#" value=3>★</a> 
								<a href="#" value=4>★</a>
								<a href="#" value=5>★</a>
							<p>
						</td>
						<%-- <td id="createDate" name="content"><%= r.getCreateDate() %></td> --%>
					</tr>
					<tr>
						<textarea id="contentArea" style="resize:none;" name="content"><%= r.getrContent() %></textarea>
					</tr>
		</table>
		
		<div class="btnArea">
			<button type="submit" class="btn"id="submit">수정하기</button>
			<button type="button" class="btn"onclick='window.close()'>취소</button>
		</div>	
		
	<script>
    	// 별 색 채워짐 이벤트
        $('#star a').click(function(){ 
            $(this).parent().children("a").removeClass("on"); 
            $(this).addClass("on").prevAll("a").addClass("on"); 
            console.log($(this).attr("value")); 
            star = $(this).attr("value");
        });
 	</script>
 	
 	<script>
 	
 	$(function(){
 		$("#submit").click(function(){
 			var rId = <%= r.getrId() %>;
 			var content = $("#contentArea").val();
 			
 			$.ajax({
 	 			url : "<%= request.getContextPath() %>/review/update",
 	 			type : "post",
 	 			dataType : "json",
 	 			data : {rId : rId, content : content, star : star},
 	 			success : function(data){
 	 				window.opener.document.location.reload();
 	 				window.close();
 	 			},
 	 			error : function(e){
 	 				console.log(e);
 	 			}
 	 		});
 		});
 	});
 	</script>
 	
 	</section>
 	
 	
 		
</body>
</html>