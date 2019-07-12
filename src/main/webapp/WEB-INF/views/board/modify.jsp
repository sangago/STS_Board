<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!-- JSTL의 출력과 포맷을 적용할 수 있는 태그 라이브러리 --> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>		
<%@include file="../includes/topbar.jsp" %>		


        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
<!--           <h1 class="h3 mb-2 text-gray-800">Board Register</h1>
          <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below. For more information about DataTables, please visit the <a target="_blank" href="https://datatables.net">official DataTables documentation</a>.</p>
 -->
          <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3 col-lg-12">
              <h6 class="m-0 font-weight-bold text-primary">Board Read Page</h6>
            </div>
            
            <!-- modify 부분 -->
            <form role="form" action="/board/modify" method="post">
          	
	          	<div class="panel-body">
	          		<div class="form-group">
	          			<label>BNO</label>
	          			<input class="form-control" name='bno' value='<c:out value="${ board.bno }"/>' readonly="readonly">
	          		</div>
	          		
	          		<div class="form-group">
	          			<label>Title</label>
	          			<input class="form-control" name='title' value='<c:out value="${ board.title }"/>'>
	          		</div>
	          		
	          		<div class="form-group">
	          			<label>Text area</label>
	          			<textarea class="form-control" row="3" name='content'> <c:out value="${ board.content }"/> </textarea>
	          		</div>
	          		<div class="form-group">
	          			<label>Writer</label>
	          			<input class="form-control" name='writer' value='<c:out value="${ board.writer }"/>' readonly="readonly">
	          		</div>
	          		
	          		<!-- <div class="form-group">
	          			<label>RegDate</label> -->
	          			<input type="hidden" class="form-control" name='regDate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${ board.regdate }" />' readonly="readonly">
	          		<!-- </div> -->
	          		<!-- <div class="form-group">
	          			<label>Update Date</label> -->
	          			<input type="hidden" class="form-control" name='updateDate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${ board.updateDate }" />' readonly="readonly">
	          		<!-- </div> -->
	          		
	          		
	          		<!-- button -->
	          		<!-- data-* : '전용 데이터 속성'이라는 속성 클래스 형성. 스크립트를 통해 HTML과 DOM사이에 정보 교환 할 수 있도록 함. HTMLElement.dataset 속성을 통해 데이터 접근 
	          			location.href : 새로운 페이지로 이동된다(히스토리에 기록된다)
	          		-->
	          		<div class="form-group">
	          			<button data-oper='modify' class="btn btn-warning button-right-m5"  onclick="location.href='/board/modify?bno=<c:out value="${ board.bno }"/>'">Modify</button>
	          			<button type="submit" data-oper="remove" class="btn btn-danger button-right-m5">Remove</button>
	          			<button data-oper='list' class="btn btn-info button-right-m5"  onclick="location.href='/board/list'">List</button>
	    			</div>
	          		
	          	</div><!-- panel-body END -->
          	
          	</form>
          	
          </div>
          
          

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->


<script type="text/javascript">
	$(document).ready(function(){
		var formObj = $("form");
		
		$('button').on("click", function(e){
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			console.log(operation);
			
			if(operation === 'remove'){
				formObj.attr("action", "/board/remove");
			}else if(operation ==='list'){
				// list로 이동
				self.location="/board/list";
				return;
			}
			formObj.submit();
		});
	});
</script>
      
<%@include file="../includes/footer.jsp" %>