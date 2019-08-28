<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!-- JSTL의 출력과 포맷을 적용할 수 있는 태그 라이브러리 --> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp" %>		
<%@include file="../includes/topbar.jsp" %>		


     <!-- Begin Page Content -->
     <div class="container-fluid">

       <!-- Page Heading -->
<!--           
		<h1 class="h3 mb-2 text-gray-800">Board Register</h1>
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
       			<sec:authentication property="principal" var="pinfo"/>	<!-- sec:authentication: 사용자 정보럴 가져와 principal에 저장되어 있다 -->
       			<!-- sec:authorize : 권한이 있는지 확인하는 태그 
       			access="isAuthenticated()" : 로그인 하지 않은 Anonymous User인지 확인하며 Anonymous User일 경우 true를 return한다
       										인증받은 사용자일 경우 <sec:authorize></sec:authorize>사이의 내용이 보여진다 -->
				<sec:authorize access="isAuthenticated()">	
					<c:if test="${pinfo.username eq board.writer}">       			
	       				<button data-oper='modify' class="btn btn-warning button-right-m5">Modify</button>
	       			</c:if>
       			</sec:authorize>
       			
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
      
       
       <!-- 첨부파일 원본 이미지 -->
       <div class='bicPictureWrapper'>
       	<!-- 원본이미지 -->
       	<div class='bicPicture'>
       	</div>
       </div>
       
       <style>
       .uploadResult { width:100%; background-color:gray; }
       .uploadResult ul { display:flex; flex-flow:row; justify-content:center; align-items: center; }
       .uploadResult ul li { list-style:none; padding:10px; align-content:center; text-align:center; }
       .uploadResult ul li img { width:100px; }
       .uploadResult ul li span { color:white; }
       .bicPictureWrapper { position:absolute; display:none; justify-content:center; align-items:center; 
       						top:0%; width:100%; height:100%; background-color:gray; z-index:100; background:rgba(255,255,255,0.5); }
       .bicPicture { position:relative; display:flex; justify-content:center; align-items:center; }
       .bicPicture img { width:600px; }
       </style>
       
       <!-- 첨부파일 목록 -->
       <div class="card shadow mb-4 testdiv">
       	<div class="card-header py-3 col-lg-12">
           <strong class="m-0 font-weight-bold text-primary"><i class="fa fa-folder fa-fw"></i> Files</strong>
         </div>
       	
       	<div class="panel-body">
       		<!-- 첨부된 파일 목록 -->
				<div class="uploadResult">
					<ul>
					</ul>
				</div>	<!-- end uploadResult -->
       	</div>	<!-- end panel-body -->
       </div>	<!-- end card shadow mb-4 testdiv -->
       
       
       
       <!-- 댓글구역 -->
       <div class="card shadow mb-4 testdiv">
       	<div class="card-header py-3 col-lg-12">
           <strong class="m-0 font-weight-bold text-primary"><i class="fa fa-comments fa-fw"></i> Reply</strong>
           <!--  로그인 한 사용자만 댓글을 추가 할 수 있음 -->
           <sec:authorize access="isAuthenticated()">
           		<button id='addReplyBtn' class="btn btn-dark right right">New Reply</button>
           </sec:authorize>
         </div>
       	
       	<!-- 댓글 리스트 -->
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
       	
       	<!-- 댓글 페이징 -->
       	<div class="panel-footer replyPageDiv">
       	
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
       		
       		// 첨부파일 보이기 
       		console.log("$.getJSON Start.........");
   			var bno = '<c:out value="${board.bno}"/>';
   			 
   			$.getJSON("/board/getAttachList", {bno: bno}, function(arr){	// $.getJSON(): AJAX HTTP GET요청을 사용하여 JSON데이터를 가져온다 -> $(selector).getJSON(url,data,success(data,status,xhr))
   				console.log("arr: " + arr);
   				
   				var str = "";
   				
   				$(arr).each(function(i, attach){
   					
   					//image Type
   					if(attach.fileType){
   						var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
   						
   						str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + 
   								"' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "' ><div>";
   						str += "<img src= '/display?fileName=" + fileCallPath + "'>";
   						str += "</div>"
   						str += "</li>"
   						
   					} else {
   						
   						str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + 
   								"' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "' ><div>";
   						str += "<img src= '/resources/img/attach.png'>";
   						str += "</div>"
   						str += "</li>"
   					}
   				});
   				
   				$(".uploadResult ul").html(str); 
   			});/* end $.getJSON */
	
   			// 첨부파일 클릭시 
   			$(".uploadResult").on("click","li",function(e){
   				
   				console.log("view image");
   				
   				var liObj = $(this);
   				
   				var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));
   				
   				if(liObj.data("type")){ 	// 이미지 경우 원본 이미지 보여주기 
   					
   					showImage(path.replace(new RegExp(/\\/g),"/")); // showImage(): 해당 이미지를 보여준다. replace(): 
   					
   				} else {		// 파일인 경우 다운로드 
   					
   					self.location="/download?fileName=" + path
   							
   				}
   			});
   			
       		// 이미지 클릭했을때 원본이미지 보이는 함수 
   			function showImage(fileCallPath){
   				alert(fileCallPath);
   				
   				$(".bicPictureWrapper").css("display", "flex").show();
   				
   				$(".bicPicture").html("<img src='/display?fileName=" + fileCallPath + "'>").animate({width:'100%', height:'100%'}, 1000);
   			}
       		
   			// 원본이미지 닫기 
   			$(".bicPictureWrapper").on("click", function(e){
   				$(".bicPicture").animate({width:'0%', height:'0%'},1000);
   				setTimeout(function(){
   					$('.bicPictureWrapper').hide();
   				}, 1000);
   			});
   			
   			
   			
   			
       		console.log("=========================");
       		console.log("JS TEST");
       		
       		var bnoValue = '<c:out value="${board.bno}" />';
       		var replyUL = $(".chat");
       		
       		showList(1);
       		
       		// 댓글 목록 보기 
       		function showList(page){
       			
       			console.log("show list" + page);
       			
       			replyService.getList({bno:bnoValue, page:page||1}, function(replyCnt, list){
       				
       				console.log("replyCnt: " + replyCnt);
       				console.log("list: " + list);
       				console.log(list);
       				
       				if(page == -1){
       					pageNum = Math.ceil(replyCnt/10.0);
       					showList(pageNum);
       					return;
       				}
       				
       				var str="";
       				
       				if(list == null || list.length == 0){
       					return;
       				}
       				
       				for(var i=0, len =list.length || 0; i<len; i++){
       					str += "<li class='left clearfix' data-rno='" +list[i].rno + "'>";
       					str += "	<div><div class='header'><strong class='primary-font'>" + list[i].replyer + "</strong>";
       					str += "		<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>";
       					str += "		<p>" + list[i].reply + "</p></div></li>";		
       				}
       				
       				replyUL.html(str);
       				
       				// 페이지 출력
       				showReplyPage(replyCnt);
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
       		
       		
       		var replyer = null;
       		
       		<sec:authorize access = "isAuthenticated()">
       			replyer = '<sec:authentication property = "principal.username"/>';
       		</sec:authorize>
       		
       		/* crs토큰과 관련된 변수 */
    		var csrfHeaderName = "${_csrf.headerName}";
    		var csrfTokenValue = "${_csrf.token}";
    		
    		
       		$("#addReplyBtn").on("click", function(e){
       			
       			modal.find("input").val("");
       			modal.find("input[name='replyer']").val(replyer);
       			modalInputReplyDate.closest("div").hide();
       			modal.find("button[id != 'modalCloseBtn']").hide();
       			
       			modalRegisterBtn.show();
       			
       			modal.modal("show");
       			
       		});
       		
       		/* ajaxSend() 이용시 Ajax 전송시 CSRF토큰을 같이 전송하도록 셋팅 되어 있음(첨부파일 경우 ajax에 beforeSend 추가했었음) */
       		$(document).ajaxSend(function(e, xhr, options){
       			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
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
       				
       				modal.find("input").val(""); // 모달창 입력되있던 값들 초기화 
       				modal.modal("hide");		// 모달창 닫기 
       				
       				
       				showList(1);	// 댓글 등록 후 리스트 업데이트(페이징처리이전)
       				showList(-1);	// 댓글 등록 후 리스트 업데이트(페이징이후) 마지막 페이지를 호출 -> 전체 댓글 수 파악 -> 마지막 페이지 호출하여 이동 
       			});
       		});
       		
       		
       		// 특정 댓글 클릭시 수정 창 띄우기 
       		$(".chat").on("click", "li", function(e){
       			
       			var rno = $(this).data("rno");
       			
       			replyService.get(rno, function(reply){
       				
       				modalInputReply.val(reply.reply);
       				modalInputReplyer.val(reply.replyer);
       				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
       				modal.data("rno", reply.rno);
       				
       				modal.find("button[id != 'modalCloseBtn']").hide();
       				modalModBtn.show();
       				modalRemoveBtn.show();
       				
       				$(".modal").modal("show");
       			});
       			console.log(rno);
       		});
       		 
       		
       		// 댓글 수정 창에서 Modify버튼 클릭시 
       		modalModBtn.on("click", function(e){
       			
       			var originalReplyer = modalInputReplyer.val();
       			
       			var reply = { 
       					rno:modal.data("rno"), 
       					reply: modalInputReply.val(),
       					replyer: originalReplyer};
       			
       			if(!replyer){
       				alert("로그인후 수정이 가능합니다.");
       				modal.modal("hide");
       				return;
       			}
       			
       			console.log("Original Replyer: " + originalReplyer);
       			
       			if(replyer != originalReplyer){
       				alert("자신이 작성한 댓글만 수정이 가능합니다.");
       				modal.modal("hide");
       				return;
       			}
       			
       			replyService.update(reply, function(result){
       				
       				alert(result);
       				modal.modal("hide");
       				/* showList(1); 댓글 첫번째 페이지 이동 */
       				showList(pageNum);	// 수정시 수정한 댓글 포함된 페이지 이동 
       			});
       		});
       		
       		// 댓글 수정 창에서 Remove버튼 클릭시 
       		modalRemoveBtn.on("click", function(e){
       			
       			var rno = modal.data("rno");
       			
       			console.log("RNO: " + rno);
       			console.log("REPLYER: " + replyer);
       			
       			if(!replyer){
       				alert("로그인 후 삭제가 가능합니다.");
       				modal.modal("hide");
       				return;
       			}
       			
       			var originalReplyer = modalInputReplyer.val();
       			
       			console.log("Original Replyer: " + originalReplyer);
       			
       			if(replyer != originalReplyer){
       				alert("자신이 작성한 댓글만 삭제가 가능합니다.");
       				modal.modal("hide");
       				return;
       			}
       			
       			replyService.remove(rno, originalReplyer, function(result){
       				
       				alert(result);
       				modal.modal("hide");
       				/* showList(1); 댓글 첫번째 페이지 이동 */
       				showList(pageNum);	// 삭제시 삭제한 댓글 있었던 페이지 이동
       			});
       		});
       		
       		
       		//<div class="panel-footer">에 댓글 페이지 번호 출력
       		var pageNum = 1;
       		var replyPageFooter = $(".panel-footer");
       		
       		function showReplyPage(replyCnt){
       			
       			var endNum = Math.ceil(pageNum/ 10.0) * 10;
       			var startNum = endNum -9;
       			
       			var prev = startNum != 1;
       			var next = false;
       			
       			if(endNum * 10 >= replyCnt){
       				endNum = Math.ceil(replyCnt/10.0);
       			}
       			
       			if(endNum * 10 < replyCnt){
       				next = true;
       			}
       			
       			var str = "<ul class='pagination pull-right'>";
       			
       			if(prev){
       				str += "<li class='page-item'><a class='page-link' href='" + (startNum - 1) + "'>Previous</a></li>";
       			}
       			
       			for(var i = startNum; i <= endNum; i++){
       				
       				var active = pageNum == i? "active":"";
       				str += "<li class='page-item " + active + "'><a class='page-link' href='" + i + "'>" + i + "</a></li>";
       			}
       			
       			if(next){
       				str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
       			}
       			
       			str += "</ul></div>";
       			
       			console.log(str);
       			
       			replyPageFooter.html(str);
       		}
       		
       		
       		// 페이지 번호 클릭시 
       		replyPageFooter.on("click","li a", function(e){
       			
       			e.preventDefault();
       			console.log("page click");
       			
       			var targetPageNum = $(this).attr("href");
       			
       			console.log("targetPageNum: " + targetPageNum);
       			
       			pageNum = targetPageNum;
       			
       			showList(pageNum);
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
   
      
<%@include file="../includes/footer.jsp" %>