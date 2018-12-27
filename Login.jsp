<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<title>Page Title</title>

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
        form{
            margin: auto;
        }
        table{
            width: 400px;
            height: 60px;
            margin: auto;
        }
        .button{
            width: 95px;
            height: 30px;
            text-align: center;
            background-color: rgb(233, 190, 50);
            display: inline-block;
            border: none;
            border-radius: 5px;
        }
    </style>
    
    <script>
        function login(){
        	var id = document.getElementById("id").value;
            var pw = document.getElementById("pw").value;
            
            var user_data = firebase.database().ref('user_data');
			
          	if(id == 'admit'){
          		if(pw == 'admit'){
          			alert("관리자버전으로 입장합니다");
          			location.href = "admit.jsp";
          		}
          		else{
          			alert("잘못된 비밀번호입니다");
          		}
          	}
          	else{
          		var mycheck = 0;
                user_data.once('value', function(snapshot) {
                  snapshot.forEach(function(childSnapshot) {
                    var tmp = childSnapshot.val();
                    if(tmp.user_id==id){
                      if(tmp.user_pw==pw){
                        alert(id + "님 환영합니다");
                        var fo = document.getElementById("login_form");
                        fo.setAttribute("action", "./login");
                        fo.submit();
                        mycheck = 1;
                      } 
                      else {
                        alert("잘못된 비밀번호입니다");
                        mycheck = 1;
                      }
                    }
                  });
                  if(mycheck==0){
                    alert("존재하지 않는 아이디입니다");
                  }
                });
          	}
        }
        function signup(){
        	location.href = "Signup.jsp";
        }
        function find_id(){
        	window.open("find_id.jsp", '_blank', 'width= 500px, height= 300px');
        }
        function find_pw(){
        	window.open("find_pw.jsp", '_blank', 'width= 600px, height= 450px');
        }
    </script>
</head>
<body style="background-image: url('background.jpg'); border: 0; padding: 0; min-height: 100%; background-position: center; background-size: cover">
    <br>
    <p style="text-align: center; color: rgba(0, 0, 0, 0.700); font-size: 100px; line-height: 0.01">Welcome&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="text-align: center; color: rgba(0, 0, 0, 0.700); font-size: 80px; line-height: 0.1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To do List</p>
    <p style="text-align: center; color: black; font-size: 25px">You can manage your <strong>To do List</strong> on this site.</p>
    <br><br>
    <form id="login_form" method="POST">
        <table>
            <tr style="height: 20px">
                <td style="font-size: 30px; line-height: 0.01">아이디</td>
                <td><input type="text" name="id" id="id" style="width: 250px; height: 40px; font-size: 20px"></td>
            </tr>
            <tr style="height: 20px">
                <td style="font-size: 30px; line-height: 0.01">비밀번호</td>
                <td><input type="password" name="pw" id="pw" style="width: 250px; height: 40px; font-size: 20px"></td>
            </tr>
        </table>
        <br>
        <div style="text-align: center">
            <input type="button" value="로그인" id="login_btn" onclick="login()" class="button">
            <input type="button" value="회원가입" id="signup_btn" onclick="signup()" class="button">
            <input type="button" value="아이디찾기" id="find_id_btn" onclick="find_id()" class="button">
            <input type="button" value="비밀번호찾기" id="find_pw_btn" onclick="find_pw()" class="button">
        </div>
        
    </form>
</body>
</html>