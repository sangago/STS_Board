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
          <h1 class="h3 mb-2 text-gray-800">Board Register</h1>
          <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below. For more information about DataTables, please visit the <a target="_blank" href="https://datatables.net">official DataTables documentation</a>.</p>

          <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3 col-lg-12">
              <h6 class="m-0 font-weight-bold text-primary">Board Register</h6>
            </div>
            
            <!-- 입력부분 -->
          	<form role="form" action="/board/register" method="post">
          	
          		<!-- CSRF 토큰 설정 -->
          		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          	
	          	<div class="form-group">
	          		<label>Title</label>
	          		<input class="form-control" name='title' />
	          	</div>
	          	
	          	<div class="form-group">
	          		<label>Text area</label>
	          		<textarea class="form-control" rows="5" name='content'></textarea>
	          	</div>
	          	
	          	<div class="form-group">
	          		<label>Writer</label>
	          		<input class="form-control" name='writer' value='<sec:authentication property="principal.username"/>' readonly="readonly" />
	          	</div>
	          	
	          	<div class="form-group">
	          		<button type="submit" class="btn btn-primary button-right-m5">Submit</button>
	          		<button type="reset" class="btn btn-danger button-right-m5">Reset</button>
	          		<button type="button" data-oper='list' class="btn btn-info button-right-m5"  onclick="location.href='/board/list'">List</button>
	          	</div>
	          
          	</form>
          	
          </div>
          
          <!-- 파일 첨부 -->
          <div class="attach-panel card shadow mb-4">
            <div class="card-header py-3 col-lg-12 panel-heading">
              <h6 class="m-0 font-weight-bold text-primary">File Attach</h6>
            </div>
            
            <div class="panel-body uploadDiv">
            	<input type="file" name='uploadFile' multiple>
            </div>
                       
            <div	class="uploadResult">
            	<ul>
            	
            	</ul>
            </div>
          </div><!-- end attach-panel -->

        </div><!-- end container-fluid -->
      
      
	<script>
	
	$(document).ready(function(e){
		
		var formObj = $("form[role='form']");
		
		$("button[type='submit']").on("click", function(e){
			
			e.preventDefault();
			
			console.log("submit clicked");
			
			var str = "";
			
			$(".uploadResult ul li").each(function(i, obj){
				
				var jobj = $(obj);
				
				console.dir(jobj);
				
				str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + jobj.data("filename") + "'>";
				str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data("uuid") + "'>";
				str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + jobj.data("path") + "'>";
				str += "<input type='hidden' name='attachList[" + i + "].fileType' value='" + jobj.data("type") + "'>";
			});
			
			formObj.append(str).submit();
		});
		
		
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
		
		/* crs토큰과 관련된 변수 */
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
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
	            beforeSend: function(xhr){		/* beforeSend: Ajax를 요청하기 직전의 콜백함수. jqXHR 객체를 수정 할수 있다. */
	            	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);		/* jqXHR에 헤더값 추가 */
	            },
	            data: formData,
	            type: 'POST',
	            dataType: 'json',
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
					beforeSend: function(xhr){		/* beforeSend: Ajax를 요청하기 직전의 콜백함수. jqXHR 객체를 수정 할수 있다. */
			            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);		/* jqXHR에 헤더값 추가 */
			        },
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