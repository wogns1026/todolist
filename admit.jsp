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

	<script>
		var user_data = firebase.database().ref('user_data');
		function info(){
			user_data.on('value', function(snapshot){
				var par = document.getElementById("tbl");
				var ch = document.getElementById("tb");
				par.removeChild(ch);
				
				var newch = document.createElement("tbody");
				newch.setAttribute("id", "tb");
				par.appendChild(newch);
				
				snapshot.forEach(function(childSnapshot){
					var tmp = childSnapshot.val();
					var id = tmp.user_id;
					addcell(id);
				});
			});
		}
		
		function addcell(id){
			var tb = document.getElementById("tb");
			var row = tb.insertRow(tb.rows.length);
			
			var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            var cell7 = row.insertCell(6);
            row.setAttribute("style", "text-align: center");
			var user_profile = firebase.database().ref('user_profile/' + id);
		
			user_profile.once('value', function(snapshot){
				var tmp = snapshot.val();
				var name = tmp.user_name;
				var birth = tmp.user_birth;
				var email = tmp.user_email;
				var major = tmp.user_major;
				var gender = tmp.user_gender;
				cell1.innerHTML = id;
				cell2.innerHTML = name;
				cell3.innerHTML = birth;
				cell4.innerHTML = email;
				cell5.innerHTML = major;
				cell6.innerHTML = gender;
				cell7.innerHTML = "<input type='button' id='"+id+"' value='삭제' onclick='del()'>";
				document.getElementById(id).onclick = del;
			});
		}
		
		function del(){
			var a = this.id;
			var user_data = firebase.database().ref('user_data/' + a);
			var user_profile = firebase.database().ref('user_profile/' + a);
			var user_todolist = firebase.database().ref('user_todolist/' + a);
			
			user_data.remove();
			user_profile.remove();
			user_todolist.remove();
			
			alert("삭제되었습니다");
			info();
		}
		
		function bef(){
			location.href = "Login.jsp";
		}
		
	</script>

</head>
<body>
	<h1>회원관리</h1>
	<br>
	<table border="1" id="tbl">
		<thead>
			<tr>
				<th style="width: 100px; height: 8px">아이디</th>
				<th style="width: 100px; height: 8px">이름</th>
				<th style="width: 100px; height: 8px">생년월일</th>
				<th style="width: 200px; height: 8px">이메일</th>
				<th style="width: 100px; height: 8px">전공</th>
				<th style="width: 70px; height: 8px">성별</th>
				<th style="width: 70px; height: 8px">삭제</th>
			</tr>
		</thead>
		<tbody id="tb">
		
		</tbody>
	</table>
	<br>
	<input type="button" value="돌아가기" onclick="bef()" style="width: 70px; height: 30px">
	<script>info();</script>
	
</body>
</html>