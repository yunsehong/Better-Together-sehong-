<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, common.model.vo.PageInfo, challenge.model.vo.*"%>
<%
 	ArrayList<Challenge> list = (ArrayList<Challenge>)request.getAttribute("list");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	ArrayList<Member> mlist =  (ArrayList<Member>)request.getAttribute("mlist");
	
	//카테고리 확인
	Member member = (Member)session.getAttribute("loginUser");
	String[] checkedInterest = new String[8];
	if(member!=null){
		
		int cate_id = member.getUser_cate();
		System.out.println(cate_id);
		
		if(cate_id!=0){

			switch(cate_id){
			case 10 : checkedInterest[0] = "checked"; break;
			case 20 : checkedInterest[1] = "checked"; break;
			case 30 : checkedInterest[2] = "checked"; break;
			case 40 : checkedInterest[3] = "checked"; break;
			case 50 : checkedInterest[4] = "checked"; break;
			case 60 : checkedInterest[5] = "checked"; break;
			case 70 : checkedInterest[6] = "checked"; break;
			case 80 : checkedInterest[7] = "checked"; break;
			
			}
		}
		System.out.println(checkedInterest[1]);
	}
	System.out.println("cate_id : "+checkedInterest[1]);
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Better Together</title>
 <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"
   integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
   crossorigin="anonymous"></script>
    <!-- 글씨체  -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">   
    <!-- font-family: 'Nanum Gothic', sans-serif; -->
    <!-- bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <!-- w3schools 사이드바-->
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    
    <!-- 스타일  -->
	<link rel="stylesheet" href='<%=request.getContextPath()%>/resources/css/menu_style.css'>
<style>
#btSection {
	padding-bottom: 60px;
	height: 1500px;
}

/* 배너 */
#bannerWrap {
	margin: auto;
	margin-top: 0;
}

.mainBanner {
	width: 100%;
}

/* 슬라이드 영역 */
.slide ul, .slide li {
	list-style:none;
}

.slide{
width:100%;
	height:500px;
	overflow:hidden;
	margin:auto;
}

.slide ul{
	width:calc(100% * 3);
	display:flex;
	animation:slide2 13s infinite;
}

/* slide 무한 반복 */
.slide li{
	width:calc(100% / 3);
	height:500px;
	padding-left:200px;
}

@keyframes slide2 {
0%{margin-left:0;}
15%{margin-left:0;}
33%{margin-left:-100%;}
45%{margin-left:-100%;}
66%{margin-left:-200%;}
85%{margin-left:-200%;}
100%{margin-left:0%;}
} 

.inner {
	float:left;
}



/* chall_box로 시작하는 모든 클래스 */
div[class^=chall_box] {
	width: 480px;
	height: 150px;
	border: 1px solid rgba(240, 240, 240, 0.466);
	margin-bottom: 10px;
}

div[class^=chall_box]:hover {
	cursor: pointer;
}

.chall_img {
	width: 150px;
	height: 90px;
	margin-top: 30px;
	margin-left: 10px;
	float: left;
}

.cTitle {
	width: 300px;
	height: 22px;
	margin-left: 170px;
	margin-top: 30px;
	font-size: 18px;
	color: #757575;
	font-weight: bold;
}

.cDate {
	font-size: 14px;
	color: #757575;
	margin-left: 170px;
	margin-top: 0;
}

.cFrequency {
	width: 60px;
	height: 20px;
	line-height: 20px;
	text-align: center;
	font-size: 14px;
	color: white;
	background-color: #bdbdbd;
	border-radius: 25px;
}

.cPeriod {
	width: 40px;
	height: 20px;
	line-height: 20px;
	text-align: center;
	font-size: 14px;
	color: white;
	background-color: #bdbdbd;
	border-radius: 25px;
	margin-right: 100px;
}

.pCountArea {
	border: 1px solid black;
	width: 80px;
	height: 20px;
	color: #937CF7;
	border-radius: 25px;
	border: 0px;
	display: inline-block;
}

.personIcon {
	width: 22px;
	float: left;
	padding-left: 5px;
}

.cpCount {
	line-height: 20px;
	font-size: 16px;
}

.aaa {
	float: left;
	margin-left: 10px;
	margin-top: 0;
}

button:hover {
	cursor: pointer;
}

#con1_title {
	width: 100%;
	height: 80px;
	float: left;
}

/* 타이틀 & 라인 */
#con1_title {
	height: 70px;
	border-bottom: 1px solid #937CF7;
	width: 100%;
	color: #757575;
	margin-top:20px;
	margin-bottom:10px;
	padding-bottom:10px;
}

#con1_title h1 {
	width: 200px;
	line-height: 70px;
	text-align: center;
	float: left;
	margin-left: 40%;
	font-size: 24px;
}

#con1_title a {
	line-height: 70px;
	text-decoration: none;
	color: #757575;
	cursor: pointer;
	float: right;
	padding-right:20px;
}

#con1_title a:hover {
	color: #937CF7;
}


/* 챌린저 랭킹 TOP 5 */
.topten_ul ul, .topten_ul li {
	list-style: none;
	margin-left: 70%;
}

.rankwrap {
	width: 600px;
	height: 30px;
	overflow: hidden;
	margin-left: 600px;
	text-align: right;
	margin-bottom: 10px;
}

.rankwrap ul {
	height: calc(100% * 10);
	animation: slide 15s infinite;
}

.rankwrap li {
	height: calc(100%/ 10);
}

.topten_ul li:nth-child(1) {
	color: #694DE2;
	font-weight: bold;
}

.topten_ul li:nth-child(2) {
	color: #7070FC;
	font-weight: bold;
}

.topten_ul li:nth-child(3) {
	color: #937CF7;
	font-weight: bold;
}

@keyframes slide { 
0% {margin-top: 0;}
5%{margin-top:0;}
10%{margin-top:-30px;}
15%{margin-top:-30px;}
20%{margin-top:-60px;}
25%{margin-top:-60px;}
30%{margin-top:-90px;}
35%{margin-top:-90px;}
40%{margin-top:-120px;}
45%{margin-top:-120px;}
50%{margin-top:-150px;}
55%{margin-top:-150px;}
60%{margin-top:-180px;}
65%{margin-top:-180px;}
70%{margin-top:-210px;}
75%{margin-top:-210px;}
80%{margin-top:-240px;}
85%{margin-top:-240px;}
90%{margin-top:-270px;}
95%{margin-top:-270px;}
100%{margin-top:0;}
}

#slidebtn_div {
	margin: auto;
	text-align: center;
}

.slidebtn {
	width: 20px;
	height: 8px;
	border-radius: 50px;
	border: 0px;
	background-color: rgba(255, 96, 100, 0.7);
}

/* 관심 카테고리 */
.choiceCategory {
	width: 100%;
	float: left;
	text-align: center;
}

.choiceCategory span {
	font-size: 14px;
}

.choiceCategory img {
	width: 150px;
}

.choiceCategory img:nth-child(9) {
	width: 70px;
}

/* 관심있는 카테고리 부분 */
#content-1 {
	/* border:solid 1px red;  */
	width: 100%;
	height: 10%;
	float: left;
}

#content-1 p {
	/* border:solid 1px red;  */
	font-size: 30px;
	text-align: center;
	margin-top: 18px;
}

#content-2 {
	/* border:solid 1px blue;  */
	width: 100%;
	height: 70%;
	float: left;
}

#content-3 {
	/* border:solid 3px lightgreen;  */
	width: 100%;
	height: 20%;
	float: left;
}

#ok {
	border: 0;
	outline: 0;
}

.category {
	width: 80%;
	height: 70%;
	margin-top: 5%;
	margin-left: 10%;
	text-align: center;
	border: 1px solid black;
	padding-top: 5%;
}

.img_size {
	width: 144px;
	height: 144px;
}

input[type=checkbox] {
	display: none;
}

#체중관리+label span {
	display: inline-block;
	cursor: pointer;
	width: 134px;
	height: 134px;
	background-size: 100%;
	background-repeat: no-repeat;
	background-position: center;
	background-image:
		url("<%=request.getContextPath()%>/resources/images/체중관리.png");
	padding-bottom: 150px;
}

#운동+label span {
	display: inline-block;
	cursor: pointer;
	width: 134px;
	height: 134px;
	background-size: 100%;
	background-repeat: no-repeat;
	background-position: center;
	background-image:
		url("<%=request.getContextPath()%>/resources/images/운동.png");
	padding-bottom: 150px;
}

#자격증+label span {
	display: inline-block;
	cursor: pointer;
	width: 134px;
	height: 134px;
	background-size: 100%;
	background-repeat: no-repeat;
	background-position: center;
	background-image:
		url("<%=request.getContextPath()%>/resources/images/자격증.png");
	padding-bottom: 150px;
}

#돈관리+label span {
	display: inline-block;
	cursor: pointer;
	width: 134px;
	height: 134px;
	background-size: 100%;
	background-repeat: no-repeat;
	background-position: center;
	background-image:
		url("<%=request.getContextPath()%>/resources/images/돈관리.png");
	padding-bottom: 150px;
}

#생활습관+label span {
	display: inline-block;
	cursor: pointer;
	width: 134px;
	height: 134px;
	background-size: 100%;
	background-repeat: no-repeat;
	background-position: center;
	background-image:
		url("<%=request.getContextPath()%>/resources/images/생활습관.png");
	padding-bottom: 150px;
}

#공부+label span {
	display: inline-block;
	cursor: pointer;
	width: 134px;
	height: 134px;
	background-size: 100%;
	background-repeat: no-repeat;
	background-position: center;
	background-image:
		url("<%=request.getContextPath()%>/resources/images/공부.png");
	padding-bottom: 150px;
}

#업무스킬+label span {
	display: inline-block;
	cursor: pointer;
	width: 134px;
	height: 134px;
	background-size: 100%;
	background-repeat: no-repeat;
	background-position: center;
	background-image:
		url("<%=request.getContextPath()%>/resources/images/업무스킬.png");
	padding-bottom: 150px;
}

#외국어+label span {
	display: inline-block;
	cursor: pointer;
	width: 134px;
	height: 134px;
	background-size: 100%;
	background-repeat: no-repeat;
	background-position: center;
	background-image:
		url("<%=request.getContextPath()%>/resources/images/외국어.png");
	padding-bottom: 150px;
}

#체중관리:checked+label span {
	opacity: 0.8;
	background-image:
		url("<%=request.getContextPath()%>/resources/images/check1.png"),
		url("<%=request.getContextPath()%>/resources/images/체중관리.png");
}

#운동:checked+label span {
	opacity: 0.8;
	background-image:
		url("<%=request.getContextPath()%>/resources/images/check1.png"),
		url("<%=request.getContextPath()%>/resources/images/운동.png");
}

#자격증:checked+label span {
	opacity: 0.8;
	background-image:
		url("<%=request.getContextPath()%>/resources/images/check1.png"),
		url("<%=request.getContextPath()%>/resources/images/자격증.png");
}

#돈관리:checked+label span {
	opacity: 0.8;
	background-image:
		url("<%=request.getContextPath()%>/resources/images/check1.png"),
		url("<%=request.getContextPath()%>/resources/images/돈관리.png");
}

#생활습관:checked+label span {
	opacity: 0.8;
	background-image:
		url("<%=request.getContextPath()%>/resources/images/check1.png"),
		url("<%=request.getContextPath()%>/resources/images/생활습관.png");
}

#공부:checked+label span {
	opacity: 0.8;
	background-image:
		url("<%=request.getContextPath()%>/resources/images/check1.png"),
		url("<%=request.getContextPath()%>/resources/images/공부.png");
}

#업무스킬:checked+label span {
	opacity: 0.8;
	background-image:
		url("<%=request.getContextPath()%>/resources/images/check1.png"),
		url("<%=request.getContextPath()%>/resources/images/업무스킬.png");
}

#외국어:checked+label span {
	opacity: 0.8;
	background-image:
		url("<%=request.getContextPath()%>/resources/images/check1.png"),
		url("<%=request.getContextPath()%>/resources/images/외국어.png");
}

 
</style>
</head>
<body>
	<%@ include file="../common/common_ui.jsp" %>
    
    <section id="btSection"> 
    <!-- 랭킹 -->
             <div class="rankwrap">
        		<ul class="topten_ul"> 	
		        <% for(Member m : mlist){ %>
		            <li><%= mlist.indexOf(m) +1 %>위 <%= m.getUserId() %></li>
		        <% } %>
       		 	</ul>
         	</div>
         	
         	
    <!-- 배너 -->
    <div id="bannerWrap">
    	<img class="mainBanner" src="<%=request.getContextPath() %>/resources/images/mainBanner.png">
    </div>
    
    
     <!-- 관심 카테고리 선택 -->
     <form action="<%=request.getContextPath() %>/member/cateinput" method="POST">
		<div class="choiceCategory">
		<%-- 	<img src="<%=request.getContextPath()%>/resources/images/외국어.png">
			<img src="<%=request.getContextPath()%>/resources/images/공부.png">
			<img src="<%=request.getContextPath()%>/resources/images/체중관리.png">
			<img src="<%=request.getContextPath()%>/resources/images/자격증.png">
			<img src="<%=request.getContextPath()%>/resources/images/돈관리.png">
			<img src="<%=request.getContextPath()%>/resources/images/업무스킬.png">
			<img src="<%=request.getContextPath()%>/resources/images/운동.png">
			<img src="<%=request.getContextPath()%>/resources/images/생활습관.png">
			<img src="<%=request.getContextPath()%>/resources/images/확인.png"> --%>
			 <input type="checkbox" id="체중관리" value="10" name="cate" class="check_box" onclick="oneCheckbox(this)" <%=checkedInterest[0] %>><label for="체중관리"><span>체중관리</span></label>
	         <input type="checkbox" id="운동" value="20" name="cate"class="check_box"onclick="oneCheckbox(this)" <%=checkedInterest[1] %>><label for="운동"><span>운동</span></label>
	         <input type="checkbox" id="자격증" value="30"name="cate"class="check_box"onclick="oneCheckbox(this)"<%=checkedInterest[2] %>><label for="자격증"><span>자격증</span></label>
	         <input type="checkbox" id="돈관리" value="40"name="cate"class="check_box"onclick="oneCheckbox(this)"<%=checkedInterest[3] %>><label for="돈관리"><span>돈관리</span></label>
	         
	         <input type="checkbox" id="생활습관" value="50"name="cate"class="check_box"onclick="oneCheckbox(this)"<%=checkedInterest[4] %>><label for="생활습관"><span>생활습관</span></label>
	         <input type="checkbox" id="공부" value="60"name="cate"lass="check_box"onclick="oneCheckbox(this)"<%=checkedInterest[5] %>><label for="공부"><span>공부</span></label>
	         <input type="checkbox" id="업무스킬" value="70"name="cate"class="check_box"onclick="oneCheckbox(this)"<%=checkedInterest[6] %>><label for="업무스킬"><span>업무스킬</span></label>
	         <input type="checkbox" id="외국어" value="80"name="cate"class="check_box"onclick="oneCheckbox(this)"<%=checkedInterest[7] %>><label for="외국어"><span>외국어</span></label>
	         <button type="submit"id="ok"><img src="<%=request.getContextPath()%>/resources/images/확인.png"style="width: 70px; background-color:none; padding-top:130px; "></button>
		</div>  
	</form>
	
	
    	<!-- 인기 챌린지 -->
		<div id="con1_title">
			<h1 class="h1_title">인기 챌린지</h1>
			<a href="<%= request.getContextPath() %>/chall/list">더보기</a>
		</div>
		
		<div class="slide">
			<ul>
			<!-- 첫번째 슬라이드 -->
				<li>
					 <div class="inner">
                  <%for (int i = 0; i < 3; i++) {	%>
               <%for (Challenge c : list) {%>
               <%if (list.indexOf(c) == i) {%>
                   <div class="chall_box<%= i %>">
                   <img src="<%= request.getContextPath()%>/resources/uploadFiles/<%=c.getChallFile()%>" class="chall_img">
                      <p name="cTitle" class="cTitle"><%=c.getChallTitle()%></p>
                      <p name="cDate" class="cDate"><%=c.getChallStart()%> 시작</p>
                      <p name="cFrequency" class="cFrequency aaa">주 <%= c.getChallFrequency() %> 회</p>
                      <p name="cPeriod" class="cPeriod aaa"><%= c.getChallPeriod() %> 주</p>
                      <div class="pCountArea">
                          <img src="<%= request.getContextPath() %>/views/community/images/heart.png" class="personIcon">
                          <p name="cpCount" class="cpCount aaa"><%= c.getHitsCount() %></p>
                      </div>
                      </div>
                      <script>
                          $(function(){
                              $(".chall_box<%= i %>").click(function(){
                                  location.href="<%=request.getContextPath()%>/chall/join?challNo=<%= c.getChallNo()%>";
                              });
                          });
                      </script>
                      <% } %>
                      <% } %>
                      <% } %>
               </div>
               <div class="inner">
               <% for(int i = 3; i < 6; i++){ %>
               <% for(Challenge c : list){ %>
               <% if(list.indexOf(c) == i){ %>
                   <div class="chall_box<%= i %>">
                   <img src="<%= request.getContextPath()%>/resources/uploadFiles/<%= c.getChallFile() %>" class="chall_img">
                      <p name="cTitle" class="cTitle"><%= c.getChallTitle() %></p>
                      <p name="cDate" class="cDate"><%= c.getChallStart() %> 시작</p>
                      <p name="cFrequency" class="cFrequency aaa">주 <%= c.getChallFrequency() %> 회</p>
                      <p name="cPeriod" class="cPeriod aaa"><%= c.getChallPeriod() %> 주</p>
                      <div class="pCountArea">
                          <img src="<%= request.getContextPath() %>/views/community/images/heart.png" class="personIcon">
                          <p name="cpCount" class="cpCount aaa"> <%= c.getHitsCount() %></p>
                      </div>
                      </div>
                      <script>
                          $(function(){
                              $(".chall_box<%= i %>").click(function(){
                                  location.href="<%=request.getContextPath()%>/chall/join?challNo=<%= c.getChallNo()%>";
                              });
                          });
                      </script>
                      <% } %>
                      <% } %>
                      <% } %>
               </div> 
				</li>
				
				
			<!-- 두번째 슬라이드 -->	
				<li>
					 <div class="inner">
                  <% for(int i = 6; i < 9; i++){ %>
               <% for(Challenge c : list){ %>
               <% if(list.indexOf(c) == i){ %>
                   <div class="chall_box<%= i %>">
                   <img src="<%= request.getContextPath()%>/resources/uploadFiles/<%= c.getChallFile() %>" class="chall_img">
                      <p name="cTitle" class="cTitle"><%= c.getChallTitle() %></p>
                      <p name="cDate" class="cDate"><%= c.getChallStart() %> 시작</p>
                      <p name="cFrequency" class="cFrequency aaa">주 <%= c.getChallFrequency() %> 회</p>
                      <p name="cPeriod" class="cPeriod aaa"><%= c.getChallPeriod() %> 주</p>
                      <div class="pCountArea">
                          <img src="<%= request.getContextPath() %>/views/community/images/heart.png" class="personIcon">
                          <p name="cpCount" class="cpCount aaa"><%= c.getHitsCount() %></p>
                      </div>
                      </div>
                      <script>
                          $(function(){
                              $(".chall_box<%= i %>").click(function(){
                                  location.href="<%=request.getContextPath()%>/chall/join?challNo=<%= c.getChallNo()%>";
                              });
                          });
                      </script>
                      <% } %>
                      <% } %>
                      <% } %>
               </div>
               <div class="inner">
               <% for(int i = 9; i < 12; i++){ %>
               <% for(Challenge c : list){ %>
               <% if(list.indexOf(c) == i){ %>
                   <div class="chall_box<%= i %>">
                   <img src="<%= request.getContextPath()%>/resources/uploadFiles/<%= c.getChallFile() %>" class="chall_img">
                      <p name="cTitle" class="cTitle"><%= c.getChallTitle() %></p>
                      <p name="cDate" class="cDate"><%= c.getChallStart() %> 시작</p>
                      <p name="cFrequency" class="cFrequency aaa">주 <%= c.getChallFrequency() %> 회</p>
                      <p name="cPeriod" class="cPeriod aaa"><%= c.getChallPeriod() %> 주</p>
                      <div class="pCountArea">
                          <img src="<%= request.getContextPath() %>/views/community/images/heart.png" class="personIcon">
                          <p name="cpCount" class="cpCount aaa"><%= c.getHitsCount() %></p>
                      </div>
                      </div>
                      <script>
                          $(function(){
                              $(".chall_box<%= i %>").click(function(){
                                  location.href="<%=request.getContextPath()%>/chall/join?challNo=<%= c.getChallNo()%>";
                              });
                          });
                      </script>
                      <% } %>
                      <% } %>
                      <% } %>
               </div> 
				</li>
				
				
			<!-- 세번째 슬라이드 -->	
				<li>
					<div class="inner">
                  <% for(int i = 12; i < 15; i++){ %>
               <% for(Challenge c : list){ %>
               <% if(list.indexOf(c) == i){ %>
                   <div class="chall_box<%= i %>">
                   <img src="<%= request.getContextPath()%>/resources/uploadFiles/<%= c.getChallFile() %>" class="chall_img">
                      <p name="cTitle" class="cTitle"><%= c.getChallTitle() %></p>
                      <p name="cDate" class="cDate"><%= c.getChallStart() %> 시작</p>
                      <p name="cFrequency" class="cFrequency aaa">주 <%= c.getChallFrequency() %> 회</p>
                      <p name="cPeriod" class="cPeriod aaa"><%= c.getChallPeriod() %> 주</p>
                      <div class="pCountArea">
                          <img src="<%= request.getContextPath() %>/views/community/images/heart.png" class="personIcon">
                          <p name="cpCount" class="cpCount aaa"><%= c.getHitsCount() %></p>
                      </div>
                      </div>
                      <script>
                          $(function(){
                              $(".chall_box<%= i %>").click(function(){
                                  location.href="<%=request.getContextPath()%>/chall/join?challNo=<%= c.getChallNo()%>";
                              });
                          });
                      </script>
                      <% } %>
                      <% } %>
                      <% } %>
               </div>
               <div class="inner">
               <% for(int i = 15; i < 18; i++){ %>
               <% for(Challenge c : list){ %>
               <% if(list.indexOf(c) == i){ %>
                   <div class="chall_box<%= i %>">
                   <img src="<%= request.getContextPath()%>/resources/uploadFiles/<%= c.getChallFile() %>" class="chall_img">
                      <p name="cTitle" class="cTitle"><%= c.getChallTitle() %></p>
                      <p name="cDate" class="cDate"><%= c.getChallStart() %> 시작</p>
                      <p name="cFrequency" class="cFrequency aaa">주 <%= c.getChallFrequency() %> 회</p>
                      <p name="cPeriod" class="cPeriod aaa"><%= c.getChallPeriod() %> 주</p>
                      <div class="pCountArea">
                          <img src="<%= request.getContextPath() %>/views/community/images/heart.png" class="personIcon">
                          <p name="cpCount" class="cpCount aaa"><%= c.getHitsCount() %></p>
                      </div>
                      </div>
                      <script>
                          $(function(){
                              $(".chall_box<%= i %>").click(function(){
                                  location.href="<%=request.getContextPath()%>/chall/join?challNo=<%= c.getChallNo()%>";
                              });
                          });
                      </script>
                      <% } %>
                      <% } %>
                      <% } %>
               </div> 
				</li>
			</ul>
		</div>
		
		
       
       
	<script type="text/javascript">
        function oneCheckbox(a){
            var obj = document.getElementsByName("cate");
            for(var i=0; i<obj.length; i++){
                if(obj[i] != a){
                    obj[i].checked = false;
                }
            }
        }
    </script>
	
    </section>
	 <!-- 환급 방법 배너 -->
    <div id="bannerWrap">
    	<img class="mainBanner" src="<%=request.getContextPath() %>/resources/images/howToPayBack.png">
    </div>

    
 <%@ include file="../common/footer.jsp" %>
	
	
</body>
</html>