<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- JSTL의 출력과 포맷을 적용할 수 있는 태그 라이브러리 --> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 <!-- Custom fonts for this template -->
 <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
 <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

 <!-- Custom styles for this template -->
 <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
 <link href="/resources/css/style.css" rel="stylesheet">

</head>
<body class="bg-gradient-primary">

  <div class="container">

    <!-- Outer Row -->
    <div class="row justify-content-center">

      <div class="col-xl-10 col-lg-12 col-md-9">

        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
              <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
              <div class="col-lg-6">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">Welcome!</h1>
                  </div>
                  
                  <form class="user" role="form" method="post" action="/login">
                  	<fieldset>
	                    <div class="form-group">
	                      <input type="text" class="form-control form-control-user" id="inputId" aria-describedby="emailHelp" placeholder="User ID" name="username" autocomplete="username" autofocus>
	                    </div>
	                    
	                    <div class="form-group">
	                      <input type="password" class="form-control form-control-user" id="inputPassword" 
	                      			placeholder="Password" name="password" value="" autocomplete="current-password">
	                    </div>
	                    
	                    <div class="form-group">
		                    <div class="checkbox custom-control custom-checkbox small">
		                    	<input name="remember-me" type="checkbox" class="custom-control-input" id="customCheck">
		                    	<label class="custom-control-label" for="customCheck"> Remember Me</label>
		                    </div>
	                    </div>
	                    
	                    <a href="index.html" class="btn btn-success btn-primary btn-user btn-block">
	                      Login
	                    </a>
	                    
	                    <a href="javascript:goList()" class="btn btn-warning btn-primary btn-user btn-block">
	                      Back
	                    </a>
                    
                    </fieldset>
                    <!-- 
                    // 구글 & 페이스북 로그인 
                    <hr>
                    <a href="index.html" class="btn btn-google btn-user btn-block">
                      <i class="fab fa-google fa-fw"></i> Login with Google
                    </a>
                    <a href="index.html" class="btn btn-facebook btn-user btn-block">
                      <i class="fab fa-facebook-f fa-fw"></i> Login with Facebook
                    </a>
                  </form> 
                  -->
                  <!--
                  // 비밀번호 찾기 & 회원가입  
                  <hr>
                  <div class="text-center">
                    <a class="small" href="forgot-password.html">Forgot Password?</a>
                  </div>
                  <div class="text-center">
                    <a class="small" href="register.html">Create an Account!</a>
                  </div>
                   -->
                   
                  	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                  </form>
                </div>	<!-- end "p-5" -->
              </div>	<!-- end col-lg-6 -->
            </div>	<!-- end row -->
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
  	
	$(".btn-success").on("click", function(e){
  		
  		e.preventDefault();

  		$("form").submit();
  		var username = document.getElementById("inputId");
		var password = document.getElementById("inputPassword");
		
  		if(username.value == ""){
  			
  			alert("아이디를 입력하세요.");
  			username.focus();
  			console.log("아이디를 입력하세요");
  			return false;
  		}
  		
  		if(password.value==""){
  			alert("패스워드를 입력하세요.");
  			password.focus();
  			console.log("패스워드를 입력하세요");
  			return false;
  		}
  		
  		
  	});
	
	$("#inputPassword").keydown(function(key){

		if (key.keyCode == 13) { // 13 = 엔테키

  			$("form").submit();

		}
			
	});
	
	function goList(){
		location.href="board/list"
	}
	
  </script>

</body>
</html>