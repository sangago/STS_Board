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
                    <h1 class="h4 text-gray-900 mb-4">로그아웃 하시겠어요?</h1>
                  </div>
                  
                  <form class="user" role="form" method="post" action="/customLogout">
                  	<fieldset>   
	                    
	                    <a href="index.html" class="btn btn-success btn-primary btn-user btn-block">
	                      Logout
	                    </a>
                    
                    </fieldset>
                  
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
	 		
	 	});
	 		
	</script>
	<c:if test="${ param.logout != null }">
		<script>
			$(document).ready(function(){
				alert("로그아웃을하였습니다.");
			});
		</script>
	</c:if>
</body>
</html>