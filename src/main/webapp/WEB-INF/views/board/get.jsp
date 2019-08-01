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
            
            <!-- 조회 내용 부분 -->
          	<div class="panel-body">
          		<div class="form-group">
          			<label>BNO</label>
          			<input class="form-control" name='bno' value='<c:out value="${board.bno}"/>' readonly="readonly">
          		</div>
          		<div class="form-group">
          			<label>Title</label>
          			<input class="form-control" name='title' value='<c:out value="${board.title}"/>' readonly="readonly">
          		</div>
          		<div class="form-group">
          			<label>Text area</label>
          			<textarea class="form-control" row="3" name='content' readonly="readonly"> <c:out value="${board.content}"/> </textarea>
          		</div>
          		<div class="form-group">
          			<label>Writer</label>
          			<input class="form-control" name='writer' value='<c:out value="${board.writer}"/>' readonly="readonly">
          		</div>
          		
          		<!-- button -->
          		<!-- data-* : '전용 데이터 속성'이라는 속성 클래스 형성. 스크립트를 통해 HTML과 DOM사이에 정보 교환 할 수 있도록 함. HTMLElement.dataset 속성을 통해 데이터 접근 
          			location.href : 새로운 페이지로 이동된다(히스토리에 기록된다)
          		-->
          		<div class="form-group">
          			<button data-oper='modify' class="btn btn-warning button-right-m5">Modify</button>
          			<button data-oper='list' class="btn btn-info button-right-m5">List</button>
    			</div>
    			
    			<!-- <button>에서 onclick 속성으로 링크를 직접처리하는 방식에서 <form>태그 이용으로 수정 -->
    			<form id='operForm' action="/board/modify" method="get">
    				<input type='hidden' id='bno' name='bno' value='<c:out value="${ board.bno }" />'>
    				<input type='hidden' name='pageNum' value='<c:out value="${ cri.pageNum }" />'>
    				<input type='hidden' name='amount' value='<c:out value="${ cri.amount }" />'>
    				<input type="hidden" name="type" value='${ cri.type }' />
  					<input type="hidden" name="keyword" value='${ cri.keyword }' />
    			</form>
          		
          	</div><!-- panel-body END -->
          
          </div>
         
          
          <!-- 댓글구역 -->
          <div class="card shadow mb-4 testdiv">
          	<div class="card-header py-3 col-lg-12">
              <strong class="m-0 font-weight-bold text-primary"><i class="fa fa-comments fa-fw"></i> Reply</strong>
              <button id='addReplyBtn' class="btn btn-dark right right">New Reply</button>
            </div>
          	
          	<div class="panel-body">
          		<ul class="chat">
          			<li class="left clearfix" data-rno='12'>
          				<div>
          					<div class="header">
          						<strong class="primary-front">user00</strong>
          						<small class="pull-right text-muted right">2018-01-01 13:13</small>
          					</div>
          					<p>Good job!</p>
          				</div>
          			</li>
          		</ul>
          	</div>
          </div>
         
          
		  <!-- 댓글쓰기창 -->
          <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">REPLY MODAL</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        <div class="form-group">
	         					<label>Reply</label>
	         					<input class="form-control" name='reply' value='New Reply!!!!'>
	         				</div>
	         				<div class="form-group">
	         					<label>Replyer</label>
	         					<input class="form-control" name='replyer' value='replyer'>
	         				</div>
	         				<div class="form-group">
	         					<label>Reply Date</label>
	         					<input class="form-control" name='replyDate' value=''>
	         				</div>
	         			</div><!-- END modal-body  -->
			      <div class="modal-footer">
			      	<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
	         		<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
	         		<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
			        <button id='modalCloseBtn' type="button" class="btn btn-secondary button-right-m5" data-dismiss="modal">Close</button><!-- data-dismiss : 모달창을 닫히도록한 -->
			      </div>
			    </div>
			  </div>
		  </div>
         
          
          <!-- reply.js 자바스크립트 추가 -->
          <script type="text/javascript" src="/resources/js/reply.js"></script>
          
          <script type="text/javascript">
          	$(document).ready(function(){
          		
          		console.log("=========================");
          		console.log("JS TEST");
          		
          		var bnoValue = '<c:out value="${board.bno}" />';
          		var replyUL = $(".chat");
          		
          		showList(1);
          		
          		function showList(page){
          			
          			replyService.getList({bno:bnoValue, page:page||1}, function(list){
          				
          				var str="";
          				if(list == null || list.length == 0){
          					replyUL.html("");
          					
          					return;
          				}
          				for(var i=0, len =list.length || 0; i<len; i++){
          					str += "<li class='left clearfix' data-rno='" +list[i].rno + "'>";
          					str += "	<div><div class='header'><strong class='primary-font'>" + list[i].replyer + "</strong>";
          					str += "		<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>";
          					str += "		<p>" + list[i].reply + "</p></div></li>";		
          				}
          				
          				replyUL.html(str);
          			})
          		}
          		
          		// 댓글등록 버튼 눌렀을시 
    			var modal = $(".modal");
          		var modalInputReply = modal.find("input[name='reply']");
          		var modalInputReplyer = modal.find("input[name='replyer']");
          		var modalInputReplyDate = modal.find("input[name='replyDate']");
          		
          		var modalModBtn = $("#modalModBtn");
          		var modalRemoveBtn = $("#modalRemoveBtn");
          		var modalRegisterBtn = $("#modalRegisterBtn");
          		
          		$("#addReplyBtn").on("click", function(e){
          			
          			modal.find("input").val("");
          			modalInputReplyDate.closest("div").hide();
          			modal.find("button[id != 'modalCloseBtn']").hide();
          			
          			modalRegisterBtn.show();
          			
          			modal.modal("show");
          			
          		});
          		
          		
          		// Register버튼 눌렀을때 
          		modalRegisterBtn.on("click", function(e){
          			
          			var reply = {
          					reply: modalInputReply.val(),
          					replyer: modalInputReplyer.val(),
          					bno:bnoValue
          			};
          			
          			replyService.add(reply, function(result){
          				
          				alert(result);
          				
          				modal.find("input").val("");
          				
          				// 모달창이랑 모달배경 없앰 modal.modal("hide");
          				/* modal.removeClass("modal","fade"); */
          				modal.modal("hide");
          				
          				
          				showList(1);	// 댓글 등록 후 리스트 업데이트 
          			});
          		});
          		
          		
          		// 특정 댓글 클릭시 
          		$(".chat").on("click", "li", function(e){
          			
          			var rno = $(this).data("rno");
          			
          			console.log(rno);
          		});
          		 
          		
          		
          		
          		// 댓글등록 테스트 
				/* replyService.add(
					{reply:"JS Test", replyer:"tester", bno:bnoValue}
					, 
					function(result){
						alert("RESULT: " + result);
					}
				);   */        		
          		
          		// reply list test
          		replyService.getList({bno:bnoValue, page:1}, function(list){
          			
          			for(var i=0, len=list.length||0; i<len; i++){
          				console.log(list[i]);
          			}
          		});
          		
          		// 댓글 삭제 테스트
          		/* replyService.remove(25, function(count){
          			
          			console.log(count);
          			
          			if(count == "success"){
          				alert("REMOVE");
          			}
          		}, function(err){
          			alert('ERROR...');
          		}); */
          					
          		// 댓글 수정
          		/* replyService.update({
          			rno : 54,
          			bno : bnoValue,
          			reply : "수정 Reply...."
          		}, function(result){
          			alert("수정 완료....");
          		}); */
          		
          		// 댓글 조회 
          		replyService.get(10, function(data){
          			console.log(data);
          		});
          		
          		
          		
          		var operForm = $("#operForm");
          		
          		$("button[data-oper='modify']").on("click", function(e){
          			
          			operForm.attr("action","/board/modify").submit();
          			
          		});
          		
				$("button[data-oper='list']").on("click", function(e){
          			
					operForm.find("#bno").remove();
          			operForm.attr("action","/board/list")
          			operForm.submit();
          			
          		});
          		
          	});
          </script>

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->
      
      
<%@include file="../includes/footer.jsp" %>