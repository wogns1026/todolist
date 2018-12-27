<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<script src="https://www.gstatic.com/firebasejs/5.5.9/firebase.js"></script>
<script>
  // Initialize Firebase
  var config = {
    apiKey: "AIzaSyAOWgA1OdO6-mguExh-LwhypUGUvN3BePM",
    authDomain: "todolist-7f6e5.firebaseapp.com",
    databaseURL: "https://todolist-7f6e5.firebaseio.com",
    projectId: "todolist-7f6e5",
    storageBucket: "todolist-7f6e5.appspot.com",
    messagingSenderId: "942918346993"
  };
  firebase.initializeApp(config);
</script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

	<style>
        .btn{
            width: 50px;
            height: 30px;
            text-align: center;
            background-color: rgb(233, 190, 50);
            display: inline-block;
            border: none;
            border-radius: 5px;
        }
        .btn1{
            width: 50px;
            height: 30px;
            text-align: center;
            background-color: rgb(233, 190, 50);
            display: inline-block;
            border: none;
            border-radius: 5px;
        }
    </style>

</head>
<body style="background-image: url('please.jpg'); border: 0; padding: 0; min-height: 100%; background-position: center; background-size: cover">
	<script>
	<%
		String id = (String)session.getAttribute("id");
	%>
	var id = '<%= id%>';
	document.write("<p style='font-size: 50px; text-align: center; font-weight: 700; line-height: 0.1'>Add the New Task</p>");
	
	$(document).ready(function(){
		$("#close_btn").click(function(){
			window.close();
		});
	});

	function add(){
		var date = new Date();
		var curdate = date.getTime();
		var duedate = document.getElementById("duedate").value;
		var title = document.getElementById("title").value;
		var content = document.getElementById("content").value;
		var chk = 0;
		curdate = String(curdate);
		
		var user_todolist = firebase.database().ref("user_todolist/" + id + '/' + curdate);
		
		user_todolist.set({
			due: duedate,
			ti: title,
			con: content,
			check: chk
		});
		alert("새로운 일이 추가되었습니다");
	}
	
	</script>
	
    <hr>
    <div style="text-align: center">
    	<h3 style="line-height: 0.1;">마감기한</h3>
    	<input type="date" id="duedate" style="width: 150px; height: 25px">
    	<h3 style="line-height: 0.1">제 목</h3>
    	<input type="text" id="title" style="width: 300px; height: 25px">
    	<h3 style="line-height: 0.1">내 용</h3>
    	<input type="text" id="content" style="width: 700px; height: 25px">
    	<br><br>
    	<input type="button" value="추가" onclick="add()" class="btn">&nbsp;&nbsp;&nbsp;
        <input type="button" value="닫기" class="btn1" id="close_btn">
    </div>
</body>
</html>