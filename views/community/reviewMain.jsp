<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="community.model.vo.*, java.util.ArrayList, challenge.model.vo.Challenge, common.model.vo.*"%>
<%
	ArrayList<Review> rList = (ArrayList<Review>) request.getAttribute("rList");
	ArrayList<Review> sortByGradeList = (ArrayList<Review>) request.getAttribute("sortByGradeList");
	ArrayList<Review> sortByDateList = (ArrayList<Review>) request.getAttribute("sortByDateList");
	ArrayList<Challenge> cList = (ArrayList<Challenge>)request.getAttribute("cList");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	
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
.reviewWrap{
	margin-top: 10px;
}

.reviewdiv{
	width: 80%;
	height: 100px;
	background: #fff;
	margin: auto;
	margin-top: 15px;
}

.reviewTb {
	width: 100%;
	height: 100px;
}

.reviewTb tr:nth-child(1)
{
	height: 20%;
	margin-top: 5px;
}

.nickname, .starArea, .createDate, .challName{
	display: inline-block;
	margin-left: 10px;
}

.starArea, .starArea2 {
	margin-left: 10px;
	color: #937cf790;
}

.contentArea, .contentArea2 {
	display: inline-block;
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 10px;
	background-color:
}

.contentArea textarea, .contentArea2 textarea {
	resize: none;
    border: none;
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

/* 후기 쓰기 */
.h2_title {
	margin-left: 133px;
	margin-right: 10px;
	color: #757575;
	float: left;
}

#reviewwrite {
	margin: auto;
	width: 80%;
	height: 70px;
	margin-bottom:40px;
}

#reviewWriteArea {
	width: 100%;
	height: 70px;
	resize: none;
	background: none;
	border: 1px solid #75757552;
	margin:auto;
}

/* 버튼 */
.btn a {
	color: white;
	font-size: 16px;
}

#submit {
	font-family: "Nanum Gothic";
        	border-radius: 10px;
           border: solid 1px #9e9e9e5b;
           padding:5px 15px 5px 15px;
           background-color: #e6e4e4b6;
           font-weight: bolder;  
           margin-left:845px;
}

#submit a {
	 font-size: 10px;
     text-decoration: none;
}

#myReview {
	width: 110px;
	font-family: "Nanum Gothic";
	border-radius: 10px;
	border: solid 1px #9e9e9e5b;
	padding: 5px 15px 5px 15px;
	background-color: #e6e4e4b6;
	font-weight: bolder;
	margin-left: 10%;
}

#myReview a {
	font-size: 10px;
	text-decoration: none;
}

/* 별점 */
#star a {
	text-decoration: none;
	color: rgb(172, 172, 172);
	font-size: 25px;
	margin-top: 3px;
}

#star a.on {
	color: #937cf790;
}

#challSelect {
	width: 200px;
	height: 30px;
	border: 1px solid rgba(219, 219, 219, 0.356);
	text-align: center;
	margin-top: 12px;
}

#challSelectArea, #starArea {
	display: inline-block;
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

#counter {
	color:#757575;
	font-size:12px;
	margin-left:950px;	
}


/* 별점순, 최신순 정렬 버튼 */
.sortArea{
    margin-top: 30px;
    margin-left: 10%;
}

.sortArea button{
	font-family: "Nanum Gothic";
	font-size: 12px;
	border:1px solid rgba(219, 219, 219, 0.356);
	font-size:12px;
	color:#757575;
	margin-right:5px;
}

</style>

</head>
<body>
	<!-- 페이지를 이동해도 menubar는 계속 상단에 노출되게끔 -->
	<%@ include file="../common/common_ui.jsp"%>
	<!-- content -->
	<!-- 후기 -->
	<section id="btSection">

		<!-- 타이틀 -->
		<div id="con1_title">
			<h1 class="h1_title">후기</h1>
		</div>

		<div class="line"></div>
		
		<div class="sortArea">
			<button id="sortByGrade" onclick="location.href='<%=request.getContextPath()%>/review/gradeSort'">별점순▼</button>
			<button id="sortByDate" onclick="location.href='<%=request.getContextPath()%>/review/main'">최신순▼</button>
		</div>
		
		<!-- 별점순, 최신순 클릭시 버튼색 바뀌게 해서 현재 무슨 정렬인지 티나게 -->
		<script>
			$(function(){
				$("#sortByGrade").click(function(){
					$(this).css({"background":"#937cf790", "color":"#fff"});
				});
				$("#sortByDate").click(function(){
					$(this).css({"background":"#937cf790", "color":"#fff"});
				});
			});
		</script>
		<!-- 후기 목록 -->
		<div class="reviewWrap">
		<% if(rList != null) { %>
		<% for(Review r : rList) { %>
		<div class="reviewdiv">
			<table class="reviewTb">
				<tr class="firstTr">
					<td class="nickname"><%= r.getNickName() %></td>
					<td class="challName"><%= r.getChallTitle() %></td>
					<td class="starArea"><%if(r.getrGrade() == 5) { %> ★★★★★ 
									  <% } else if(r.getrGrade() == 4) { %>★★★★
									  <% } else if(r.getrGrade() == 3) { %>★★★
									  <% } else if(r.getrGrade() == 2) { %>★★
									  <% } else { %>★<% } %>
					</td>
					<td class="createDate"><%= r.getCreateDate() %></td>
				</tr>
				<tr class="secondTr">
					<td class="contentArea"><textarea readonly cols="110"><%= r.getrContent() %></textarea></td>
				</tr>
			</table>
		</div>
		<% } %>
		<% } %>
		</div>
	
		<!-- 후기 목록 -->
		<div class="reviewWrap">
		<% if(sortByGradeList != null) { %>
		<% for(Review r : sortByGradeList) { %>
		<div class="reviewdiv">
			<table class="reviewTb">
				<tr class="firstTr">
					<td class="nickname"><%= r.getNickName() %></td>
					<td class="challName"><%= r.getChallTitle() %></td>
					<td class="starArea"><%if(r.getrGrade() == 5) { %> ★★★★★ 
									  <% } else if(r.getrGrade() == 4) { %>★★★★
									  <% } else if(r.getrGrade() == 3) { %>★★★
									  <% } else if(r.getrGrade() == 2) { %>★★
									  <% } else { %>★<% } %>
					</td>
					<td class="createDate"><%= r.getCreateDate() %></td>
				</tr>
				<tr class="secondTr">
					<td class="contentArea"><textarea readonly cols="100"><%= r.getrContent() %></textarea></td>
				</tr>
			</table>
		</div>
		<% } %>
		<% } %>
		</div>
		
		
		<!-- 전체 리스트(최신순) 페이징 바 -->
		<%if(rList != null) { %>
		<div class="pagingArea">
			<!-- 맨 처음으로 (<<) -->
			<button onclick="location.href='<%= request.getContextPath() %>/review/main?currentPage=1'"> &lt;&lt; </button>
			
			<!-- 이전 페이지로 (<) -->
			<% if(pi.getCurrentPage() == 1){ %>
				<button disabled> &lt; </button>
			<%} else { %>
				<button onclick="location.href='<%= request.getContextPath() %>/review/main?currentPage=<%= pi.getCurrentPage() - 1 %>'"> &lt; </button>
			<%} %>	
			
			<!-- 10개의 페이지 목록 -->
			<% for(int p = pi.getStartPage(); p <= pi.getEndPage(); p++){ %>
				<% if(p == pi.getCurrentPage()){ %>
					<button style="background:lightgray;" disabled> <%= p %> </button>
				<%}else{ %>
					<button onclick="location.href='<%= request.getContextPath() %>/review/main?currentPage=<%= p %>'"> <%= p %> </button>
				<% } %>
			<%} %>
			
			<!-- 다음 페이지로(>) -->
			<%if(pi.getCurrentPage() == pi.getMaxPage()){ %>
				<button disabled> &gt; </button>
			<%} else {%>
				<button onclick="location.href='<%= request.getContextPath() %>/review/main?currentPage=<%= pi.getCurrentPage() + 1 %>'"> &gt; </button>
			<% } %>
			
			<!-- 맨 끝으로(>>) -->
			<button onclick="location.href='<%= request.getContextPath() %>/review/main?currentPage=<%= pi.getMaxPage() %>'"> &gt;&gt; </button>
		</div>
			<%} %>
			
			
		<!-- 별점순 리스트 페이징 바 -->
		<%if(sortByGradeList != null) { %>
		<div class="pagingArea">
			<!-- 맨 처음으로 (<<) -->
			<button onclick="location.href='<%= request.getContextPath() %>/review/gradeSort?currentPage=1'"> &lt;&lt; </button>
			
			<!-- 이전 페이지로 (<) -->
			<% if(pi.getCurrentPage() == 1){ %>
				<button disabled> &lt; </button>
			<%} else { %>
				<button onclick="location.href='<%= request.getContextPath() %>/review/gradeSort?currentPage=<%= pi.getCurrentPage() - 1 %>'"> &lt; </button>
			<%} %>	
			
			<!-- 10개의 페이지 목록 -->
			<% for(int p = pi.getStartPage(); p <= pi.getEndPage(); p++){ %>
				<% if(p == pi.getCurrentPage()){ %>
					<button style="background:lightgray;" disabled> <%= p %> </button>
				<%}else{ %>
					<button onclick="location.href='<%= request.getContextPath() %>/review/gradeSort?currentPage=<%= p %>'"> <%= p %> </button>
				<% } %>
			<%} %>
			
			<!-- 다음 페이지로(>) -->
			<%if(pi.getCurrentPage() == pi.getMaxPage()){ %>
				<button disabled> &gt; </button>
			<%} else {%>
				<button onclick="location.href='<%= request.getContextPath() %>/review/gradeSort?currentPage=<%= pi.getCurrentPage() + 1 %>'"> &gt; </button>
			<% } %>
			
			<!-- 맨 끝으로(>>) -->
			<button onclick="location.href='<%= request.getContextPath() %>/review/gradeSort?currentPage=<%= pi.getMaxPage() %>'"> &gt;&gt; </button>
		</div>
			<%} %>
		
		
		<!-- 후기 쓰기 -->
		
		<h2 class="h2_title">후기 쓰기</h2>
		<div id="challSelectArea">
			<select id="challSelect">
			<% if(cList != null) { %>
				<% for(Challenge c : cList) {%>
				<option value=<%= c.getChallNo() %>><%= c.getChallTitle() %></option>
				<% } %>
			<% } %>
			</select>
		</div>
		<div id="starArea">
		<p id="star">
			<a href="javascript:void(0)" value=1>★</a> 
			<a href="javascript:void(0)" value=2>★</a> 
			<a href="javascript:void(0)" value=3>★</a> 
			<a href="javascript:void(0)" value=4>★</a>
			<a href="javascript:void(0)" value=5>★</a>
		<p>
		</div>

		<div id="reviewwrite">
			<textarea id="reviewWriteArea" placeholder="최대 300자까지 입력 가능합니다."></textarea>
			<span id="counter">0 / 300</span>
		</div>

		<!--  글자수 실시간 카운팅 -->
		<script>
		$('#reviewWriteArea').keyup(function (e){
		    var content = $(this).val();
		    $('#counter').html("("+content.length+" / 300)");   
		    
		    if(content.length > 300){
		    	alert('최대 300자까지 입력 가능합니다.');
		    	$(this).val(content.substring(0, 300));
		    	$('#counter').html("(300 / 300)");
		    	
		    }
		 });
		    
		</script>
	
		<button class="btn" id="myReview">
			<a>내가 쓴 후기 보기</a>
		</button>
		<button class="btn" id="submit">
			<a>등록</a>
		</button>
		
		<script>
		// [내가 쓴 글 보기] 버튼 이벤트
		$(function(){
			$("#myReview").click(function(){
				<%if(loginUser != null) {%>
				location.href='<%=request.getContextPath()%>/review/myReview';
				<% } else {%>
				alert('로그인을 해주세요.');
				<% } %>
			})
		})
		</script>
		
		<script>
    	 // 별 색 채워짐 이벤트
        $('#star a').click(function(){ 
            $(this).parent().children("a").removeClass("on"); 
            $(this).addClass("on").prevAll("a").addClass("on"); 
            console.log($(this).attr("value")); 
            star = $(this).attr("value");
        });
 		</script>
 		
 		<!-- 후기 등록 이벤트 ajax -->
 		<script>
    	// [등록] 버튼 클릭 이벤트 - ajax로 입력 한 값 넘기기
        $(function(){
        	$("#submit").click(function(){
        		<%if(loginUser != null) {%>
        		var content = $("#reviewWriteArea").val();
        		var challNo = $("#challSelect").val();
        		
        	 $.ajax({
        			url : "<%= request.getContextPath() %>/review/insert",
        			type : "post",
        			dataType : "json",
        			data : {content : content, challNo : challNo, star : star},
        			success : function(data){
        				
        				// 갱신 된 rList를 후기 div에 적용
        				reviewWrap = $(".reviewWrap");
        				reviewWrap.html("");	// 기존 리뷰 정보 초기화
        				
        				// 새로 받아온 갱신된 댓글 리스트들을 for문을 통해 다시 table에 추가
        				for(var key in data){
        					
        					var reviewdiv = $("<div class='reviewdiv'></div>");
        					var reviewTb = $("<table class='reviewTb'></table>");
        					var firstTr = $("<tr class='firstTr'></tr>");
        					var secondTr = $("<tr class='secondTr'></tr>");
        					var writerTd = $("<td class='nickname'></td>").text(data[key].nickName);
        					var challTitleTd = $("<td class='challName'></td>").text(data[key].challTitle);
        					var gradeTd;
        					if(data[key].rGrade == 5){
        						gradeTd = $("<td class='starArea'></td>").text("★★★★★");
        					}else if(data[key].rGrade == 4){
        						gradeTd = $("<td class='starArea'></td>").text("★★★★");
        					}else if(data[key].rGrade == 3){
        						gradeTd = $("<td class='starArea'></td>").text("★★★");
        					}else if(data[key].rGrade == 2){
        						gradeTd = $("<td class='starArea'></td>").text("★★");
        					}else {
        						gradeTd = $("<td class='starArea'></td>").text("★");
        					}
        					var createDateTd = $("<td class='createDate'></td>").text(data[key].createDate);
        					var contentTd = $("<td class='contentArea'><textarea readonly cols='116'></textarea></td>").text(data[key].rContent);
        					
        					firstTr.append(writerTd, challTitleTd, gradeTd, createDateTd);
        					secondTr.append(contentTd);
        					reviewTb.append(firstTr, secondTr);
        					reviewdiv.append(reviewTb);
        					reviewWrap.append(reviewdiv);
        				}
        				
    					// 댓글 작성 textarea 부분 리셋
    					$("#reviewWriteArea").val("");
        			},
        			error : function(e){
        				console.log(e);
        				console.log("error@@@@");
        			}
        		});
        		
        		<% } else { %>
        		alert('로그인을 해주세요.');
        		<% } %>
        	}) 
        });
        </script>

		
	</section>
	<%@ include file="../common/footer.jsp" %>
	
</body>
</html>