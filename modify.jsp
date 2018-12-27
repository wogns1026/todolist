<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<script src="https://www.gstatic.com/firebasejs/5.6.0/firebase.js"></script>
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
            width: 60px;
            height: 40px;
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

	<script>
		function mod(){
			<% 
				String cmp = request.getParameter("mod_id");
				session.setAttribute("mod_id", cmp);
				String uid = request.getParameter("uid");
				session.setAttribute("uid", uid);
			%>
			var cmp = '<%=cmp%>';
			var uid = "<%=uid%>";
			
			var user_todolist = firebase.database().ref("user_todolist/" + uid).orderByChild('due');
			
			var due = document.getElementById("duedate").value;
			var ti = document.getElementById("title").value;
			var con = document.getElementById("content").value;
			
			user_todolist.once('value', function(snapshot){
				var idx = 1;
				snapshot.forEach(function(childSnapshot){
					if(idx == cmp){
						childSnapshot.ref.update({
							due: due,
							ti: ti,
							con: con
						});
						location.href = 'TodoList.jsp';
					}
					idx++;
				});
			});
			alert("수정되었습니다");
		}
		
	</script>

</head>
<body style="background-image: url('please.jpg'); border: 0; padding: 0; min-height: 100%; background-position: center; background-size: cover">
	
	<p style='font-size: 50px; text-align: center; font-weight: 700; line-height: 0.1'>Modify Task</p>
	<hr>
    <div style="text-align: center">
    	<h3 style="line-height: 0.1;">마감기한</h3>
    	<input type="date" id="duedate" style="width: 150px; height: 25px">
    	<h3 style="line-height: 0.1">제 목</h3>
    	<input type="text" id="title" style="width: 300px; height: 25px">
    	<h3 style="line-height: 0.1">내 용</h3>
    	<input type="text" id="content" style="width: 700px; height: 25px">
    	<br><br>
    	<input type="button" value="수정" onclick="mod()" class="btn">&nbsp;&nbsp;&nbsp;
    </div>
</body>
</html>