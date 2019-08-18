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
		<!-- <h1 class="h3 mb-2 text-gray-800">Board Register</h1>
          <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below. For more information about DataTables, please visit the <a target="_blank" href="https://datatables.net">official DataTables documentation</a>.</p>
 		-->
       <!-- DataTales Example -->
    	<div class="card shadow mb-4">
        	<div class="card-header py-3 col-lg-12">
        		<h6 class="m-0 font-weight-bold text-primary">Board Modify Page</h6>
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
				      		<!-- 파일선택 버튼 -->
				      		<div class="panel-body uploadDiv">
            					<input type="file" name='uploadFile' multiple>
            				</div>
            				
				      		<!-- 첨부된 파일 목록 -->
							<div class="uploadResult">
								<ul>
								</ul>
							</div>	<!-- end uploadResult -->
				      	</div>	<!-- end panel-body -->
			      	</div>	<!-- end card shadow mb-4 testdiv -->
        		
        		
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
       		
       		<!-- 수정/삭제 데이터 처리를 위한 <form>태그 전송 -->
       		<input type='hidden' name='pageNum' value='<c:out value="${ cri.pageNum }"/>'>
       		<input type='hidden' name='amount' value='<c:out value="${ cri.amount }"/>'>
       		<input type="hidden" name="type" value='${ cri.type }' />
			<input type="hidden" name="keyword" value='${ cri.keyword }' />
       		
       		
       	</form>
       	
       </div>  

     </div>
     <!-- /.container-fluid -->



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
					str += "<span> " + attach.fileName + "</span>";
					str += "<button type='button' data file='/" + fileCallPath + "/'data-type='image'"
					str +=  "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br/>";
					str += "<img src= '/display?fileName=" + fileCallPath + "'>";
					str += "</div>"
					str += "</li>"
					
				} else {
					
					str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + 
							"' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "' ><div>";
					str += "<span> " + attach.fileName + "</span><br/>"
					str += "<button type='button' data-file=/'" + fileCallPath + "/'data-type='file'"
					str += " class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br/>";
					str += "<img src= '/resources/img/attach.png'>";
					str += "</div>"
					str += "</li>"
				}
			});
			
			$(".uploadResult ul").html(str); 
			});/* end $.getJSON */
		
		
		
		var formObj = $("form");
		
		$('button').on("click", function(e){
			
			e.preventDefault(); //<form>태그의 버튼의 기본은 submit으로 처리하기 때문에 e.preventDefault()로 기본 동작을 막고 마지막에 submit수행(클릭이벤트 외에 별도의 브라우저 행동을 막기위해 사용)
			
			var operation = $(this).data("oper");
			
			console.log(operation);
			
			if(operation === 'remove'){
				formObj.attr("action", "/board/remove");
			}else if(operation ==='list'){
				// list로 이동
				formObj.attr("action","/board/list").attr("method","get");
				
				// 수정페이지에서 list클릭시 1페이지가 아닌 보고 있던 페이지 이동을 위해 
				var pageNumTag = $("input[name='pageNum']").clone(); // clone(): dom요소 복사
				var amountTag = $("input[name='amount']").clone();
				var typeTag = $("input[name='type']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				
				formObj.empty();
				
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(typeTag);
				formObj.append(keywordTag);
				
				/* self.location="/board/list";
				return; */
			} else if(operation === 'modify'){
				
				console.log("submit clicked");
				
				var str = "";
				
				$(".uploadResult ul li").each(function(i, obj){
					
					var jobj = $(obj);
					
					console.dir(jobj);
					
					str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + jobj.data("filename")+"'>";
					str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data("uuid")+"'>";
					str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + jobj.data("path")+"'>";
					str += "<input type='hidden' name='attachList[" + i + "].fileType'value='" + jobj.data("type")+"'>";
					
				});
				formObj.append(str).submit();
			}
			formObj.submit();
		});
		
		// x버튼 클릭시
		$(".uploadResult").on("click", "button", function(e){
			
			console.log("delete file");
			
			if(confirm("Remove this file? ")){
				var targetLi = $(this).closest("li");
				targetLi.remove();
			}
		});
		
		// 첨부파일 추가
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;
		
		function checkExtension(fileName, fileSize){
			
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드 할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		$("input[type='file']").change(function(e){
			
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			
			for(var i=0; i<files.length; i++){
				
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
		
			$.ajax({
	            url: '/uploadAjaxAction',
	            processData: false,
	            contentType: false,
	            data: formData,
	            type: 'POST',
	            success: function(result){
					console.log(result);
					showUploadResult(result);
				}	
			});/* end $.ajax */
		
		});/* end change() */
		
		
		function showUploadResult(uploadResultArr){
			
			if(!uploadResultArr || uploadResultArr.length == 0){ return; }
			
			var uploadUL = $(".uploadResult ul");
			
			var str = "";
			
			$(uploadResultArr).each(function(i, obj){
				
				// image type
				if(obj.image){
					
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
					
					str += "<li data-path='" + obj.uploadPath + "'"; 
					str += "data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'";
					str += "><div>";
					str += "<span>" + obj.fileName + "</span>";
					str += "<button type='button' data-file='/"+ fileCallPath + "/'data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?fileName=" +fileCallPath + "'>";
					str += "</div>";
					str += "</li>";
					
					//console.log(fileCallPath);
					
				} else {
					
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "'data-filename='" + obj.fileName + "' data-type='" + obj.image + "' ><div>";
					str += "<span>" + obj.fileName + "</span>";
					str += "<button type='button' data-file='/"+ fileCallPath + "/'data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str += "</li>";
					
					//console.log(fileCallPath);
				}
			});
			
			uploadUL.append(str);
		
			// x버튼 클릭시 첨부파일 삭제
			$(".uploadResult").on("click", "button", function(e){
				
				console.log("delete file");
				
				var targetFile = $(this).data("file");
				var type = $(this).data("type");
				
				var targetLi = $(this).closest("li");
				
				$.ajax({
					url: "/deleteFile",
					data: {fileName:targetFile, type:type},
					dataType: 'text',
					type: 'POST',
					success: function(result){
						alert(result);
						targetLi.remove();
					}
				});/* end .ajax */
				
			});
		}
		
		
	});
</script>
      
<%@include file="../includes/footer.jsp" %>