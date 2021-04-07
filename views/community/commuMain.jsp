<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, common.model.vo.PageInfo, challenge.model.vo.*"%>
 <%
 	ArrayList<Challenge> list = (ArrayList<Challenge>)request.getAttribute("list");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	ArrayList<Member> mlist =  (ArrayList<Member>)request.getAttribute("mlist");
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Better Together</title>
<style>
body{ background: rgba(240, 240, 240, 0.466);}
/* 연분홍 배경 */
#con1 {
	width: 1000px;
	height: 704px;
	border-radius: 20px;
	margin: auto;
	margin-top: 15px;
}

/* 슬라이드 영역 */
#slide {
	width: 100%;
	height: 78%;
	float: left;
}

.container {
	width: 300vw;
	/* 버튼 눌렀을 때 넘어가는 트랜지션 */
	transition: transform 0.5s;
	overflow: hidden;
	display: flex;
}

.outer {
	width: 300vw;
	float: left;
	height: 500px;
}



/* chall_box로 시작하는 모든 클래스 */
div[class^=chall_box] {
	width: 480px;
	height: 150px;
	border: 1px solid rgba(240, 240, 240, 0.466);
	margin-bottom: 10px;
}

div[class^=chall_box]:hover{
	cursor:pointer;
}

.chall_img {
	width: 150px;
	height: 90px;
	margin-top: 30px;
	margin-left: 10px;
	float: left;
}

.inner {
	float: left;
	margin: 10px;
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
	height: 20px;
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

/* 챌린저 랭킹 배경*/
#con2 {
	width: 100%;
	height: 800px;
	/* background: rgba(240, 240, 240, 0.466); */
	border-radius: 20px;
	margin-top: 20px;
}

#con1_title, #con2_title {
	width: 100%;
	height: 80px;
}


/* 타이틀 & 라인 */
#con1_title h1, #con2_title h1 {
	position: absolute;
	width: 1000px;
	text-align: center;
	margin-top: 25px;
}

#con1_title a {
	position: absolute;
	color: #757575;
	font-size: 16px;
	margin-top: 35px;
	margin-left: 925px;
	cursor: pointer;
}

#con1_title a:hover {
	color: #937CF7;
}

.line {
	border: 0.5px solid #937cf790;
}

.h1_title {
	margin-top: 50px;
	text-align: center;
	font-family: 'Nanum Gothic', sans-serif;
	font-size: 24px;
	color: #757575;
}

/* 챌린저 랭킹 TOP 5 */
#topten_title{
/* 	float:left; */
}
.topten_ul ul, .topten_ul li{
	list-style:none;
} 

.rankwrap {
	height: 30px;
	overflow:hidden;
}
.rankwrap ul {
	height:calc(100% * 10); animation:slide 15s infinite;
}
.rankwrap li{
	height:calc(100% / 10);
}
.topten_ul li:nth-child(1) {color:#694DE2; font-weight:bold;}
.topten_ul li:nth-child(2) {color:#7070FC; font-weight:bold;}
.topten_ul li:nth-child(3) {color:#937CF7; font-weight:bold;}


@keyframes slide{
	0% {margin-top:0;}
      5% {margin-top:0;}
      10% {margin-top:-30px;}
      15% {margin-top:-30px;}
      20% {margin-top:-60px;}
      25% {margin-top:-60px;}
      30% {margin-top:-90px;}
      35% {margin-top:-90px;}
      40% {margin-top:-120px;}
      45% {margin-top:-120px;}
      50% {margin-top:-150px;}
      55% {margin-top:-150px;}
      60% {margin-top:-180px;}
      65% {margin-top:-180px;}
      70% {margin-top:-210px;}
      75% {margin-top:-210px;}
      80% {margin-top:-240px;}
      85% {margin-top:-240px;}
      90% {margin-top:-270px;}
      95% {margin-top:-270px;}
      100% {margin-top:0;}
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
	border:1px solid black;
	width:100%;
	float:left;
}

.choiceCategory img{
	width:170px;
}
</style>
</head>
<body>
<!-- 페이지를 이동해도 menubar는 계속 상단에 노출되게끔 -->
	<%@ include file="../common/common_ui.jsp"%>
	

    <!-- content -->
    <!-- 1. 인기 챌린지 -->
    <section id="con1"> 
       
        <!-- 타이틀 -->
        <div id="con1_title">
            <h1 class="h1_title">인기 챌린지</h1>
            <p><a href="<%=request.getContextPath()%>/chall/list">더보기</a></p>            
        </div>

        <div class="line"></div>

        <!-- 슬라이드 -->
        <section id="slide">
            <div style="overflow: hidden;">
                <div class="container">
                	<!-- 첫번째 슬라이드 -->
					 <div class="outer">
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
                    </div>
                    <!-- 두번째 슬라이드 -->
                    <div class="outer">
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
                    </div>
                    <!-- 세번째 슬라이드 -->
                    <div class="outer">
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
                    </div>
                </div>
            </div>
            
            
            <!-- 페이징ㄴㄴ 슬라이드 버튼 -->
            <!-- <div id="slidebtn_div">
                <button id="slidebtn1" class="slidebtn"> </button>
                <button id="slidebtn2" class="slidebtn"> </button>
                <button id="slidebtn3" class="slidebtn"> </button>
            </div>
            
		
             <script>
                document.querySelector('#slidebtn2').addEventListener('click', function(){
                    document.querySelector('.container').style.transform = 'translate(-100vw)';
                })
                document.querySelector('#slidebtn3').addEventListener('click', function(){
                	document.querySelector('.container').style.transform = 'translate(-200vw)';
                })
                document.querySelector('#slidebtn1').addEventListener('click', function(){
                    document.querySelector('.container').style.transform = 'translate(0vw)';
                })
            </script> -->
            
            <!-- 인기챌린지 무한 슬라이드 -->
            <script>
            	setInterval(function(){
            		$(".container>.outer").delay(3500);
            		$(".container>.outer").animate({marginLeft: "-100vw"});
            		$(".container>.outer").delay(3500);
            		$(".container>.outer").animate({marginLeft: "-200vw"});
            		$(".container>.outer").delay(3500);
            		$(".container>.outer").animate({marginLeft: "0vw"});
            	});
            </script>
        </section>   
    </section>

	<!-- 관심 카테고리 선택 -->
	<div class="choiceCategory">
		<img src="<%=request.getContextPath()%>/resources/images/외국어.png">
		<img src="<%=request.getContextPath()%>/resources/images/공부.png">
		<img src="<%=request.getContextPath()%>/resources/images/체중관리.png">
		<img src="<%=request.getContextPath()%>/resources/images/자격증.png">
		<img src="<%=request.getContextPath()%>/resources/images/돈관리.png">
		<img src="<%=request.getContextPath()%>/resources/images/업무스킬.png">
		<img src="<%=request.getContextPath()%>/resources/images/운동.png">
		<img src="<%=request.getContextPath()%>/resources/images/생활습관.png">
		<img src="<%=request.getContextPath()%>/resources/images/확인.png">
		
	</div>

    <!-- 2. 챌린저 랭킹 -->
    <section id="con2">
    <!-- 타이틀 -->
       

        <!-- 랭킹 -->
        <p id="topten_title">챌린저 TOP 10<p>
        <div class="rankwrap">
        	<ul class="topten_ul"> 	
		        <% for(Member m : mlist){ %>
		            <li><%= mlist.indexOf(m) +1 %>위 <%= m.getUserId() %></li>
		        <% } %>
       		 </ul>
         </div>
    </section>
    
    <footer></footer>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
</body>
</html>