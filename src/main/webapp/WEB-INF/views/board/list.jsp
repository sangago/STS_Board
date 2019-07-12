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
          <h1 class="h3 mb-2 text-gray-800">Tables</h1>
          <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below. For more information about DataTables, please visit the <a target="_blank" href="https://datatables.net">official DataTables documentation</a>.</p>

          <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">Board List Page</h6>
              <button id='regBtn' type="button" class="btn btn-dark regBtn">Register New Board</button>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>#번호</th>
                      <th>제목</th>
                      <th>작성자</th>
                      <th>작성일</th>
                      <th>수정일</th>
                    </tr>
                  </thead>
                  
                  <!-- 게시글 -->
                  <c:forEach items="${list}" var="board">
                  	<tr>
                  		<td><c:out value="${board.bno}" /></td>
                  		<td><a class="atag" href='/board/get?bno=<c:out value="${board.bno}"/>'>
                  			<c:out value="${board.title}"/>
                  		</a></td>
                  		<td><c:out value="${board.writer}" /></td>
                  		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" /></td>			<!-- 대문자 MM를 써야 제대로 나옴 -->
                  		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}" /></td>
                  	</tr>
                  </c:forEach>
                                    
                </table>
 
  
		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        처리가 완료되었습니다
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary button-right-m5" data-dismiss="modal">Close</button> <!-- data-dismiss : 모달창을 닫히도록한 -->
		        <button type="button" class="btn btn-primary button-right-m5">Save changes</button>
		      </div>
		    </div>
		  </div>
		</div>
                
                
                
              </div>
            </div>
          </div>

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->
      
      
      
      <script type="text/javascript">
      
      	$(document).ready(function(){
      		
      		var result = '<c:out value="${result}"/>';
      		
      		/* modal처리 */
      		checkModal(result);
      		
      		/* 새글을 등록하는것 이외에 modal창을 띄울 필요가 없음 */
      		history.replaceState({}, null, null);
      		
      		function checkModal(result){
      			
      			if(result === '' || history.state){
      				return;
      			}
      			
      			if(parseInt(result) == null){
      				$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
      			}
      			
      			$("#exampleModal").modal('show');
      		}
      		
      		
      		/* Register New Board 버튼 눌렀을 */
      		$("#regBtn").on("click", function(){
      			self.location = "/board/register"	/* URL 이동 */
      		});
      		
      	});
      	
      </script>

</script>
      
<%@include file="../includes/footer.jsp" %>