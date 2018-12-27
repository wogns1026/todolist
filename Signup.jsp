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
            width: 70px;
            height: 30px;
            text-align: center;
            background-color: rgb(233, 190, 50);
            display: inline-block;
            border: none;
            border-radius: 5px;
        }
        .btn1{
            width: 70px;
            height: 40px;
            text-align: center;
            background-color: rgb(233, 190, 50);
            display: inline-block;
            border: none;
            border-radius: 5px;
        }
        </style>
</head>

<body style="background-image: url('background.jpg'); border: 0; padding: 0; min-height: 100%; background-position: center; background-size: cover">
	<script>
		function login_back(){
			location.href = "Login.jsp";
		}
	
		var user_data = firebase.database().ref('user_data');
		var data = new Array();
		user_data.on('value', function(snapshot){
			data.splice(0, data.length);
			snapshot.forEach(function(childSnapshot){
				var childData = childSnapshot.val();
				data.push(childData.user_id);
			});
		});
		
		function signup(){
			
			var id = document.getElementById("id").value;
			var pw = document.getElementById("pw").value;
			var rpw = document.getElementById("rpw").value;
			var name = document.getElementById("name").value;
			var birth = document.getElementById("birth").value;
			var genderlist = document.getElementsByName("gender");
			var email = document.getElementById("email").value;
			var major = document.getElementById("major").value;
			var gender;
			for(var i = 0; i < genderlist.length; i++){
				if(genderlist[i].checked == true){
					gender = genderlist[i].value;
				}
			}
			
			var user_data = firebase.database().ref('user_data/' + id);
		    var user_profile = firebase.database().ref('user_profile/' + id);
			
			if(document.getElementById("id").disabled){
				if(pw == rpw){
					user_data.set({
						user_id: id,
						user_pw: pw
					});
					user_profile.set({
						user_name: name,
						user_birth: birth,
						user_gender: gender,
						user_email: email,
						user_major: major
					});
					alert("ȸ�������� �Ϸ�Ǿ����ϴ�");
					location.href = "Login.jsp";
				}
				else{
					alert("��Ȯ�� ��й�ȣ�� �ٸ��ϴ�");
				}
			}
			else{
				alert("���̵� �ߺ�Ȯ���� �����ּ���")
			}
			
		}
		
		function mycheck(){
			
			var id = document.getElementById("id").value;
			var checked = 0;
			
			data.forEach(function(tmp){
				if(tmp == id){
					alert("�̹� ������� ���̵��Դϴ�");
					checked = 1;
				}
			});
			if(checked == 0){
				alert("��� ������ ���̵��Դϴ�");
				document.getElementById("id").disabled = true;
			}
		}
		
		
		
	</script>

    <form id="signup_form" name="signup_form" method="GET" style="text-align: center">
        <p style="font-size: 70px; font-weight: 700; line-height: 0.1">Sign Up</p>
		<br>
        <table>
            <tr>
                <h3 style="line-height: 0.1">���̵�
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3>
            </tr>
            <tr><input type="text" id="id" name="id" style="width: 300px; height: 40px; font-size: 20px"><br></tr>
            <tr>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" id="id_chk" name="id_chk" class="btn" onclick="mycheck()" value="�ߺ�Ȯ��"></tr>
            <tr>
                <h3 style="line-height: 0.1">��й�ȣ
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3>
            </tr>
            <tr><input type="password" id="pw" name="pw" style="width: 300px; height: 40px; font-size: 20px"></tr>
            <tr>
                <h3 style="line-height: 0.1">��й�ȣ ��Ȯ��
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </h3>
            </tr>
            <tr><input type="password" id="rpw" name="rpw" style="width: 300px; height: 40px; font-size: 20px"></tr>
            <tr>
                <h3 style="line-height: 0.1">�̸�
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3>
            </tr>
            <tr><input type="text" id="name" name="name" style="width: 300px; height: 40px; font-size: 20px"></tr>
            <tr>
                <h3 style="line-height: 0.1">�������
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3>
            </tr>
            <tr><input type="date" placeholder="ex)19951026" id="birth" name="birth" style="width: 300px; height: 40px; font-size: 20px"></tr>
            <tr>
                <h3 style="line-height: 0.1">����
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3>
            </tr>
            <tr>
            	<input type="radio" id="gender_m" name="gender" value="��" style="width: 20px; height: 20px"><span style="font-size: 20px">����</span>
            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	<input type="radio" id="gender_w" name="gender" value="��" style="width: 20px; height: 20px"><span style="font-size: 20px">����</span>          	            
            </tr>
            <tr>
                <h3 style="line-height: 0.1">�̸���
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3>
            </tr>
            <tr><input type="text" id="email" name="email" style="width: 300px; height: 40px; font-size: 20px"></tr>
            <tr>
                <h3 style="line-height: 0.1">����
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3>
            </tr>
            <tr><input type="text" id="major" name="major" style="width: 300px; height: 40px; font-size: 20px"></tr>
            <tr>
            <br><br><input type="button" class="btn1" id="finish" value="�Ϸ�" onclick="signup()" style="font-size: 20px">
    		</tr>
        	
        </table>

    </form>


</body>
</html>