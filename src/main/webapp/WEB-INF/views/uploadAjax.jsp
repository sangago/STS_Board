<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Upload with Ajax</h1>
	
	<div class='uploadDiv'>
		<input type = 'file' name = 'uploadFile' multiple>
	</div>
	
	<div class='bicPictureWrapper'>
		<div class='bicPicture'>
		</div>
	</div>
	
	
	<style>
	.uploadResult {width: 100%; background-color: gray;}
	.uploadResult ul {display: flex; flex-flow: row; justify-content: center; align-items: center;}
	.uploadResult ul li {list-style: none; padding: 10px; align-items: center; text-align: center;}
	.uploadResult ul li img {width:100px;}
	.uploadResult ul li span {color:white;}
	
	.bicPictureWrapper {
		position: absolute; 
		display:none; 
		justify-content:center; 
		align-items:center; 
		top:0%; 
		width:100%; 
		height:100%; 
		background-color:gray; 
		z-index:100; 
		background:rgba(255,255,255,0.5);
	}
	.bicPicture {
		position: relative;
		display:flex;
		justify-content: center;
		align-items: center;
	}
	.bicPicture img {
		width:600px;
	}
	
	
	</style>
	
	
	<div class='uploadResult'>
		<ul>
		</ul>
	</div>
	
	<button id='uploadBtn'>Upload</button>
	
	
	<!-- https://code.jquery.com/  -> jQuery CDN -->
	<script
  		src="https://code.jquery.com/jquery-3.4.1.min.js"
  		integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  		crossorigin="anonymous"></script>
		
	<script>
		// 썸네일 클릭했을때 크게 보이기 
		function showImage(fileCallPath){
			//alert(fileCallPath);
			
			$(".bicPictureWrapper").css("display", "flex").show();
			
			$(".bicPicture")
			.html("<img src='/display?fileName=" + encodeURI(fileCallPath) + "'>")
			.animate({width:'100%', height: '100%'}, 1000);
		}
		
		// 확대된 이미지 다시 클릭하면 닫기 
		$(".bicPictureWrapper").on("click", function(e){
			$(".bicPicture").animate({width:'0%', height:'0%'}, 1000);
			setTimeout(function(){		// setTimeout(): 시간지연함수 
				$(".bicPictureWrapper").hide();
			}, 1000);
		});
	
		$(document).ready(function(){
			
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");		// 제한하려는 확장자 
			var maxSize = 5242880; 		// 5MB
			
			function checkExtension(fileName, fileSize){
				
				if(fileSize >= maxSize){
					alert("파일 사이즈 초과");
					return false;
				}
				
				if(regex.test(fileName)){
					alert("해당 종류의 파일은 업로드할 수 없습니다.");
					return false;
				}
				
				return true;
			}
			
			
			var cloneObj = $(".uploadDiv").clone();	//$(선택요소).clone(): 선택한 요소 복사하기 
			
			$("#uploadBtn").on("click", function(e){
			
				var formData = new FormData();
				
				var inputFile = $("input[name='uploadFile']");
				
				var files = inputFile[0].files;
				
				console.log(files);
				
				// add filedate to formdata
				for(var i=0; i<files.length; i++){
					
					// 파일의 확장자나 크기의 사전처리 
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
					dataType: 'json',
					success: function(result){
							
							console.log(result);
							
							showUploadedFile(result);
							
							$(".uploadDiv").html(cloneObj.html());
						}
				});	// end $.ajax
			});
			
			// 파일 이름 출력 
			var uploadResult = $(".uploadResult ul");
			
			function showUploadedFile(uploadResultArr){
				
				var str = "";
				
				$(uploadResultArr).each(
					function(i, obj){
						
						if(!obj.image){	// 업로드시 이미지가 아니면 attach.png이미지 보이기 
							
							var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
						
							str += "<li><div><a href='/download?fileName=" + fileCallPath + "'>" + 
									"<img src='/resources/img/attach.png'>" + obj.fileName + "</a>" +
									"<span data-file='/" + fileCallPath + "' data-type='file'> X </span>" + "</div></li>";
							
						} else {	// 업로드시 이미지면 썸네일 보이기 
							// str += "<li>" + obj.fileName + "</li>";
							
							//var fileCallPath = encodeURIComponent( obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);	//encodeURIComponent(): 모든 문자를 코딩하는 함수
							var fileCallPath = encodeURIComponent( obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);	//encodeURIComponent(): 모든 문자를 코딩하는 함수
							
							var originPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
							
							originPath = originPath.replace(new RegExp(/\\/g), "/");
							
							str += "<li><a href=\"javascript:showImage(\'"+ originPath + "\')\"><img src='/display?fileName=" + fileCallPath + 
									"'></a>" + "<span data-file=\'" + fileCallPath + "\' data-type='image'> X </span>" + "</li>";
							
							console.log(str);
							// str += "<li><img src='/display?fileName=" + fileCallPath + "'></li>";
							// str += "<li><a href='/download?fileName=" + fileCallPath + "'>"+"<img src='/display?fileName=" + fileCallPath + "'></a></li>"; // 이미지 누르면 바로 다운로드 
						}
					});
				
				uploadResult.append(str);
			}	// END showUploadedFile()
			
			
			$(".uploadResult").on("click", "span", function(e){
				
				var targetFile = $(this).data("file");
				var type = $(this).data("type");
				console.log(targetFile);
				
				$.ajax({
					url: '/deleteFile',
					data: {fileName: targetFile, type:type},
					dataType: 'text',
					type: 'POST',
					success: function(result){
						alert(result);
					}
				});
			});
			
		});
	</script>
</body>
</html>