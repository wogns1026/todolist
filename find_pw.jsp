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
	$(document).ready(function(){
		$("#find_pw").click(function(){
			var id = document.getElementById("id").value;
			var name = document.getElementById("name").value;
			var birth = document.getElementById("birth").value;
			var email = document.getElementById("email").value;
			
			var user_data = firebase.database().ref("user_data/"+id);
			var pw = "";
			user_data.once('value', function(snapshot){
				var tmp = snapshot.val();
				pw = tmp.user_pw;
			});
			
			
			var user_profile = firebase.database().ref("user_profile/"+id);
			var mychk = 0;
			
			user_profile.once('value', function(snapshot){
				var tmp = snapshot.val();
				if(tmp.user_name == name){
					if(tmp.user_birth == birth){
						if(tmp.user_email == email){
							mychk = 1;
							alert(id + "님의 비밀번호는 '" + pw + "'입니다");
							window.close();
						}
					}
				}
				if(mychk == 0){
					alert("존재하지 않는 회원입니다");
				}
			});
		});
	});
	
	</script>
	
</head>
<body style="background-image: url('please.jpg'); border: 0; padding: 0; min-height: 100%; background-position: center; background-size: cover">
	<p style='font-size: 40px; text-align: center; font-weight: 700; line-height: 0.1'>Find Password</p>
	<hr>
    <div style="text-align: center">
    	<h3 style="line-height: 0.1;">아이디</h3>
    	<input type="text" id="id" style="width: 200px; height: 25px">
    	<h3 style="line-height: 0.1;">이름</h3>
    	<input type="text" id="name" style="width: 200px; height: 25px">
    	<h3 style="line-height: 0.1;">생년월일</h3>
    	<input type="date" id="birth" style="width: 200px; height: 25px">
    	<h3 style="line-height: 0.1">이메일</h3>
    	<input type="text" id="email" style="width: 200px; height: 25px">
    	<br><br>
    	<input type="button" value="찾기" class="btn" id="find_pw">
    </div>
</body>
</html>