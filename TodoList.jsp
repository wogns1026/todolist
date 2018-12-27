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
        .nav{
            width: 230px;
            float: left;
        }
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
            width: 70px;
            height: 30px;
            text-align: center;
            background-color: rgb(233, 190, 50);
            display: inline-block;
            border: none;
            border-radius: 5px;
        }
    </style>
    
    <script>
	<%
		String id = (String)session.getAttribute("id");
	%>
	var id = '<%= id%>';
	document.write("<p style='text-align: right; line-height: 0.01px'><input type='button' class='btn1' value='로그아웃' id='logout'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>");
	document.write("<p style='font-size: 50px; text-align: center; font-weight: 700; line-height: 0.01px'>" + id + "&apos;s To do List</p>");
	$(document).ready(function(){
		$("#logout").click(function(){
			alert("로그아웃 되었습니다");
			location.href = "Login.jsp";
		});
	});
	
	function add(){
		window.open("add.jsp", '_blank', 'width= 750px, height= 400px');
	}
	
	function display(){
		var user_todolist = firebase.database().ref("user_todolist/" + id).orderByChild('due');
		var today = new Date();
		var curyear = parseInt(today.getFullYear());
		var curmonth = parseInt(today.getMonth());
		curmonth = curmonth + 1;
		var curdate = parseInt(today.getDate());
		
		user_todolist.on('value', function(snapshot){
			var par = document.getElementById("tbl");
			var ch = document.getElementById("tb");
			par.removeChild(ch);
			
			var newch = document.createElement("tbody");
			newch.setAttribute("id", "tb");
			par.appendChild(newch);
			
			var idx = 1;
			snapshot.forEach(function(childSnapshot){
				var tmp = childSnapshot.val();
				
				var prio = idx;
				var due = tmp.due;
				var ti = tmp.ti;
				var con = tmp.con;
				var chk = tmp.check;
				
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
	            if(chk == 1){
	            	cell1.setAttribute("bgcolor", "gray");
	            	cell2.setAttribute("bgcolor", "gray");
	            	cell3.setAttribute("bgcolor", "gray");
	            	cell4.setAttribute("bgcolor", "gray");
	            }
	            // 2018-12-03
	            var thisyear = due[0] + due[1] + due[2] + due[3];
	            var thismonth = due[5] + due[6];
	            var thisdate = due[8] + due[9];
	            
	            thisyear = parseInt(thisyear);
	            thismonth = parseInt(thismonth);
	            thisdate = parseInt(thisdate);
	            
	            if(chk == 0){
	            	if(thisyear < curyear){
		            	cell1.setAttribute("bgcolor", "red");
		            	cell2.setAttribute("bgcolor", "red");
		            	cell3.setAttribute("bgcolor", "red");
		            	cell4.setAttribute("bgcolor", "red");
		            }
		            else{ // thisyear >= curyear
		            	if(thismonth < curmonth){
		            		cell1.setAttribute("bgcolor", "red");
			            	cell2.setAttribute("bgcolor", "red");
			            	cell3.setAttribute("bgcolor", "red");
			            	cell4.setAttribute("bgcolor", "red");
		            	}
		            	else{ // thismonth >= curmonth
		            		if(thisdate < curdate){
		            			cell1.setAttribute("bgcolor", "red");
		    	            	cell2.setAttribute("bgcolor", "red");
		    	            	cell3.setAttribute("bgcolor", "red");
		    	            	cell4.setAttribute("bgcolor", "red");
		            		}
		            		else{ // thisdate >= curdate
		            			if(thisdate - curdate <= 1){
		            				cell1.setAttribute("bgcolor", "pink");
			    	            	cell2.setAttribute("bgcolor", "pink");
			    	            	cell3.setAttribute("bgcolor", "pink");
			    	            	cell4.setAttribute("bgcolor", "pink");
		            			}
		            		}
		            	}
		            }
	            }
	             	        
	            cell1.innerHTML = prio;
	            cell2.innerHTML = due;
	            cell3.innerHTML = ti;
	            cell4.innerHTML = con;
	            cell5.innerHTML = "<input type='button' id='f"+prio+"' value='완료' class='btn' onclick='fin()'>";
	            cell6.innerHTML = "<input type='button' id='m"+prio+"' value='수정' class='btn' onclick='mod()'>";
	            cell7.innerHTML = "<input type='button' id='d"+prio+"' value='삭제' class='btn' onclick='del()'>";
				document.getElementById('f'+prio).onclick = fin;
				document.getElementById('m'+prio).onclick = mod;
				document.getElementById('d'+prio).onclick = del;
				
				idx++;
			});
		});
	}
	
	function fin(){
		var user_todolist = firebase.database().ref("user_todolist/" + id).orderByChild('due');
		var chk = 1;
		var nonchk = 0;
		var a = this.id;
		var cmp = parseInt(a[1]);
		
		user_todolist.once('value', function(snapshot){
			var idx = 1;
			snapshot.forEach(function(childSnapshot){
				var tmp = childSnapshot.val();
				if(idx == cmp){
					if(tmp.check == 0){
						childSnapshot.ref.update({check: chk});
						alert("완료되었습니다");
					}
					else{
						childSnapshot.ref.update({check: nonchk});
						alert("완료가 취소되었습니다");
					}
				}
				idx++;
			});
		});
		display();
	}
	
	function mod(){
		var a = this.id;
		var cmp = parseInt(a[1]);
		document.write("<form action='modify.jsp' method='POST' id='mfo'><input type='hidden' value="+cmp+" name='mod_id'><input type='hidden' value="+id+" name='uid'></form>");
		var fo = document.getElementById("mfo");
		fo.submit();
	}
	
	function del(){
		var user_todolist = firebase.database().ref("user_todolist/" + id).orderByChild('due');
		var a = this.id;
		var cmp = parseInt(a[1]);
		user_todolist.once('value', function(snapshot){
			var idx = 1;
			snapshot.forEach(function(childSnapshot){
				if(idx == cmp){
					childSnapshot.ref.remove();
				}
				idx++;
			});
		});
		alert("삭제되었습니다");
		display();
	}
	
	</script>

</head>
<body style="background-image: url('smooth.jpg'); border: 0; padding: 0; min-height: 100%; background-position: center; background-size: cover">
	
    <hr>
    <nav class="nav">
    	&nbsp;
    	<div align="right">
        <input type="button" value="추가" onclick="add()" class="btn">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
        </div>
        <br>
        <canvas id="my" width="200" height="200"></canvas>

    <script>
        function func() {
            var canvas = document.getElementById("my");
            var context = canvas.getContext('2d');
            
            context.clearRect(0, 0, 200, 200);			          
            context.beginPath();
            context.arc(100, 100, 90, 0, 2.0 * Math.PI, false);
            context.strokeStyle = 'black';
            context.lineWidth = 3;
            context.stroke();
            
            context.font = (90*0.2) + "px Arial";
            context.textBaseline = "middle";
            context.textAlign = "center";
            
            for(var i = 1; i <= 12; i++){
            	var angle=(i*Math.PI)/6;
            	context.rotate(angle);
            	context.translate( 0, -90*0.85 ); 
                context.rotate( -angle ); 
                context.fillText( i.toString(), 100, 100 ); 
                context.rotate( angle ); 
                context.translate( 0, 90*0.85 ); 
                context.rotate( -angle );
            }

            var today = new Date();
            var h = today.getHours();
            var m = today.getMinutes();
            var s = today.getSeconds();
            
            var canvas = document.getElementById("my");
            var hh = canvas.getContext('2d');
            var mm = canvas.getContext('2d');
            var ss = canvas.getContext('2d');

            hh.strokeStyle = "black";
            hh.beginPath();
            hh.moveTo(100, 100);
            hh.lineTo(100+(120/3) * Math.sin(h*Math.PI*2/12), 100-(120/3)*Math.cos(h*Math.PI*2/12));
            hh.lineWidth = 3;
            hh.stroke();
            hh.closePath();
            
            mm.strokeStyle = "black";
            mm.beginPath();
            mm.moveTo(100, 100);
            mm.lineTo(100+(140/2)*Math.sin(m*Math.PI*2/60), 100-(140/2)*Math.cos(m*Math.PI*2/60));
            mm.stroke();
            mm.closePath();

            ss.strokeStyle = "red";
            ss.beginPath();
            ss.moveTo(100, 100);
            ss.lineTo(100+(170/2)*Math.sin(s*Math.PI*2/60), 100-(170/2)*Math.cos(s*Math.PI*2/60));
            ss.stroke();
            ss.closePath();
        }
        setInterval(func, 1000);
    </script>
    
    </nav>
    
    
    <div>
    &nbsp;
        <table border="1" id="tbl">
            <thead>
                <tr>
                    <th style="width: 70px; height: 8px; text-align: center">중요도</th>
                    <th style="width: 100px; height: 8px; text-align: center">마감기한</th>
                    <th style="width: 250px; height: 8px; text-align: center">제 목</th>
                    <th style="width: 550px; height: 8px; text-align: center">내 용</th>
                    <th style="width: 50px; height: 8px; text-align: center">완료</th>
                    <th style="width: 50px; height: 8px; text-align: center">수정</th>
                    <th style="width: 50px; height: 8px; text-align: center">삭제</th>
                </tr>
            </thead>
            <tbody id="tb">
            	
            </tbody>
        </table>
    </div>
    <script>display();</script>
    
</body>
</html>