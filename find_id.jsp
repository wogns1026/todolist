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
			$("#find_id").click(function(){
				var name = document.getElementById("name").value;
				var email = document.getElementById("email").value;
				
				var user_profile = firebase.database().ref('user_profile');
				var mychk = 0;
				user_profile.once('value', function(snapshot){
					snapshot.forEach(function(childSnapshot){
						var tmp = childSnapshot.val();
						if(tmp.user_name == name){
							if(tmp.user_email == email){
								var id = childSnapshot.key;
								mychk = 1;
								alert(name + "님의 아이디는 '" + id + "'입니다");
								window.close();
							}
							else{
								alert("존재하지 않는 회원입니다");
								mychk = 1;
							}
						}
					});
					if(mychk == 0){
						alert("존재하지 않는 회원입니다");
					}
				});
			});
		});
	
	</script>

</head>
<body style="background-image: url('please.jpg'); border: 0; padding: 0; min-height: 100%; background-position: center; background-size: cover">
	<p style='font-size: 40px; text-align: center; font-weight: 700; line-height: 0.1'>Find ID</p>
	<hr>
    <div style="text-align: center">
    	<h3 style="line-height: 0.1;">이름</h3>
    	<input type="text" id="name" style="width: 200px; height: 25px">
    	<h3 style="line-height: 0.1">이메일</h3>
    	<input type="text" id="email" style="width: 200px; height: 25px">
    	<br><br>
    	<input type="button" value="찾기" class="btn" id="find_id">&nbsp;&nbsp;&nbsp;
    </div>

</body>
</html>