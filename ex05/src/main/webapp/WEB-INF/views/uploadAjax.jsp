<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.uploadResult {
	width:100%;
	background-color: gray;
}

.uploadResult ul{
	display:flex;
	flex-flow:row;
	justify-contet: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img{
	width: 20px;
}
</style>

<title>Insert title here</title>
</head>
<body>

	<h1>Upload with Ajax</h1>
	
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	
	<div class='uploadResult'>
		<ul>
		
		</ul>
	</div>

	<button id='uploadBtn'>Upload</button>

<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script>
$(document).ready( () => {
	
	let regex = new RegExp("(.*?)\.(exe|sh|zip|alz|py)$");
	
	let maxSize = 5242880; //5MB
	
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
	
	let uploadResult = $(".uploadResult ul");
	
	function showUploadedFile(uploadResultArr){
		
		let str = "";
		
		$(uploadResultArr).each( (i, obj) => {
			
			if(!obj.image){
			str += "<li><img src='/resources/img/attach.png'>"
				+ obj.fileName + "</li>";
			} else {
			//str += "<li>" + obj.fileName + "</li>";
			let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
			
			str += "<li><img src='/display?fileName="+ fileCallPath +"'><li>";
			}
		});
		
		uploadResult.append(str);
	}
	
	
	
	
	let cloneObj = $(".uploadDiv").clone();
	
	$('#uploadBtn').on("click", e =>{
		
		let formData = new FormData();
		
		let inputFile = $("input[name='uploadFile']");
		
		let files = inputFile[0].files;

		console.log(files);
		
		//add filedate to formdata
		for(let i = 0; i < files.length; i++){
			
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url: "/uploadAjaxAction",
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType:'json',
			success: result => {
				console.log(result);
				
				showUploadedFile(result);
				
				$(".uploadDiv").html(cloneObj.html());
			}
		});
	});
});
</script>


</body>
</html>