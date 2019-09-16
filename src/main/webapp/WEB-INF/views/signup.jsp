<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- JSTL의 출력과 포맷을 적용할 수 있는 태그 라이브러리 --> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 

<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>create account</title>

 <!-- Custom fonts for this template -->
 <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
 <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

 <!-- Custom styles for this template -->
 <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
 <link href="/resources/css/style.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

  <div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
      <div class="card-body p-0">
        <!-- Nested Row within Card Body -->
        <div class="row">
          <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
          <div class="col-lg-7">
            <div class="p-5">
              <div class="text-center">
                <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
              </div>
              <form role="form" class="user" method="post" action="/signup">
                  <div class="form-group">
                    <input type="text" class="form-control form-control-user" id="userid" name="userid" placeholder="ID">
                  </div>
                  <div class="form-group">
                    <input type="text" class="form-control form-control-user" id="username" name="username" placeholder="User Name">
                  </div>
                
                  <div class="form-group">
                    <input type="password" class="form-control form-control-user" id="userpw" name="userpw"placeholder="Password">
                  </div>
                  <div class="form-group">
                    <input type="password" class="form-control form-control-user" id="repeatuserpw" name="repeatuserpw" placeholder="Repeat Password">
                  </div>
                <!-- 
                <div >
                  <input type="email" class="form-control form-control-user" id="exampleInputEmail" placeholder="Email Address">
                </div>
                 -->
                
                <button type="submit" class="btn btn-primary btn-user btn-block">
                  Register Account
                </button>
                
                <!-- SNS를 이용한 회원가입  
                <hr>
                <a href="index.html" class="btn btn-google btn-user btn-block">
                  <i class="fab fa-google fa-fw"></i> Register with Google
                </a>
                <a href="index.html" class="btn btn-facebook btn-user btn-block">
                  <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook
                </a>
                 -->
                 
                 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
              </form>
              <hr>
              
              <div class="text-center">
                <a class="small" href="customLogin">Already have an account? Login!</a>
              </div>
              
              <!-- 비밀번호 찾기  
              <div class="text-center">
                <a class="small" href="forgot-password.html">Forgot Password?</a>
              </div>
               -->
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="/resources/vendor/jquery/jquery.min.js"></script>
  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/resources/js/sb-admin-2.min.js"></script>

  <script>
  	
	$(".btn-user").on("click", function(e){
  		
  		e.preventDefault();

  		$("form").submit();
  		var userid = document.getElementById("userid");
  		var username = document.getElementById("username");
		var userpw = document.getElementById("userpw");
		var repeatuserpw = document.getElementById("repeatuserpw");
		
  		if(userid.value == ""){
  			
  			alert("아이디를 입력하세요.");
  			userid.focus();
  			console.log("아이디를 입력하세요");
  			return false;
  		}
  		
		if(username.value == ""){
  			
  			alert("이름 입력하세요.");
  			username.focus();
  			console.log("아이디를 입력하세요");
  			return false;
  		}
  		
  		if(userpw.value==""){
  			alert("비밀번호 입력하세요.");
  			userpw.focus();
  			console.log("패스워드를 입력하세요");
  			return false;
  		}
  		
  		/* 
  		if(userpw != repeatuserpw){
  			alert("비밀번호 같지 않습니다.");
  			repeatuserpw.focus();
  			console.log("비밀번호 같지 않습니다");
  			return false;
  		} */
  		
  	});
	
	$("#inputPassword").keydown(function(key){

		if (key.keyCode == 13) { // 13 = 엔테키

  			$("form").submit();

		}
			
	});

	
  </script>  
</body>

</html>
