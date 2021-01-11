<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp" %>
<style>
.uploadResult {
	width:100%;
	background-color: gray;
}
.uploadResult ul{
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}
.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}
.uploadResult ul li img{
	width: 100px;
}
.uploadResult ul li span{
	color: white;
}
.bigPictureWrapper{
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top:0%;
	width:100%;
	height:100%;
	background-color:gray;
	z-index:100;
	background:rgba(255, 255, 255, 0.5);
}
.bigPicture{
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
.bigPicture img {
	width: 600px;
}
</style>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Modify Page</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			
			<div class="panel-heading">Board Modify Page</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				
			<form role="form" action="/board/modify" method="post">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>	
					<!-- 319페이지 추가 -->
					<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
					<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'>
					<!-- 346페이지 추가 -->
					<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
					<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
			
					<div class="form-group">
						<label>Bno</label><input class="form-control" name="bno"
						value='<c:out value="${board.bno }"/>' readonly="readonly"/>
					</div>
					
					<div class="form-group">
						<label>Title</label><input class="form-control" name="title"
						value='<c:out value="${board.title }"/>' />
					</div>
					
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name="content" ><c:out value="${board.content }" /></textarea>
					</div>
					
					<div class="form-group">
						<label>Writer</label> <input class="form-control" name="writer"
						value='<c:out value="${board.writer }"/>' >
					</div>
					
					
					<sec:authentication property="principal" var="pinfo" />
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq board.writer }">
							<button data-oper="modify" class="btn btn-default" type="submit">
							Modify</button>
							<button data-oper="remove" class="btn btn-danger" type="submit">
							Remove</button>
						</c:if>
					</sec:authorize>
					
					
					<button data-oper="list" class="btn btn-info" type="submit">
					 List </button>
				</form>
			</div>	
			<!-- end panel-body -->
		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->

<div class="bigPictureWrapper">
	<div class="bigPicture">
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
		
			<div class="panel-heading">Files</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name="uploadFile" multiple="multiple">
				</div>
			
			
				<div class="uploadResult">
					<ul>
					
					</ul>
				</div>
			</div>
			<!-- end panel body -->
		</div>
		<!-- end panel body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->

<script type="text/javascript">
	 
	$(document).ready(() => {
		(() => {
			let bno = '<c:out value="${board.bno}" />';
			
			$.getJSON("/board/getAttachList", {bno:bno}, arr =>{
				
				console.log(arr);
				
				let str = "";
				
				$(arr).each((i, attach) => {
				
					//image type
					if(attach.fileType){
						let fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
						
						str += "<li data-path='"+ attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='" + attach.fileType +"' ><div>";
						str += "<span> " + attach.fileName+"</span>";
						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' ";
						str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/display?fileName="+fileCallPath+"'>";
						str += "</div>";
						str += "</li>";
						
					}else{
						str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type="+attach.fileType+"' ><div>";
						str += "<span> " + attach.fileName + "</span><br/>";
						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' ";
						str += " class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/resources/img/attach.png'></a>";
						str += "</div>";
						str += "</li>";
					}
				});
				
				$(".uploadResult ul").html(str);
			});//end getjson
		})();//end function
		
		
		let formObj = $("form");
		// 화살표 문법 사용시 data-oper 데이터 자체를 못 받아옴	
		$('button').on("click", function(e) {//e => { 
			
			e.preventDefault();
			
			let operation = $(this).data("oper");
			
			console.log(operation);
			
			if(operation === 'remove'){
				formObj.attr("action", "/board/remove");
			}else if(operation === 'list'){
				//move to list
				//self.location = "/board/list";(266페이지 수정)
				formObj.attr("action", "/board/list").attr("method", "get");
				let pageNumTag = $("input[name='pageNum']").clone();
				let amountTag = $("input[name='amount']").clone();
				let keywordTag = $("input[name='keyword']").clone();
				let typeTag = $("input[name='type']").clone();
				
				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
			}else if(operation === 'modify'){

				console.log("submit clicked");
				
				let str = "";
				
					$(".uploadResult ul li").each((i, obj) =>{
					
						let jobj = $(obj);
						
						console.dir(jobj);
				
						str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+ jobj.data("filename")+"'>";
						str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+ jobj.data("uuid")+"'>";
						str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+ jobj.data("path")+"'>";
						str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
					});
					formObj.append(str).submit();
			}
			formObj.submit();
			
		});
		
		$(".uploadResult").on("click", "button", function(e) {
			
			console.log("delete file");
			
			if(confirm("Remove this file?")){
				
				let targetLi = $(this).closest("li");
				targetLi.remove();
			}
		
		});
		
		let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		let maxSize = 5242880; // 5Mb
		
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
		
		function showUploadResult(uploadResultArr){
			
			if(!uploadResultArr || uploadResultArr.length == 0){return;}
			
			let uploadUL = $(".uploadResult ul");
			
			let str = "";
			
			$(uploadResultArr).each((i, obj) =>{
				
				//image type
				if(obj.image){
					let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
					str += "<li data-path='"+obj.uploadPath+"'";
					str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName + "' data-type='" + obj.image + "'";
					str += "><div>";
					str += "<span> " + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?fileName=" + fileCallPath + "'>";
					str += "</div>";
					str += "</li>";
				} else {
					let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					let fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li "
					str += "data-path='"+obj.uploadPath+"' data-uuid='" + obj.uuid + "' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
					str += "<span> " + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'>";
					str += "</div>";
					str += "</li>";
				}
			});
			uploadUL.append(str);
		}
		
		let csrfHeaderName = "${_csrf.headerName}";
		let csrfTokenValue = "${_csrf.token}";
		
		$("input[type='file']").change(e =>{
			
			let formData = new FormData();
			
			let inputFile = $("input[name='uploadFile']");
			
			let files = inputFile[0].files;
			
			for(let i = 0; i < files.length; i++){
				
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url: '/uploadAjaxAction',
				processData : false,
				contentType: false, 
				data: formData,
				beforeSend: xhr =>{
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				type: 'POST',
				dataType: 'json',
				success: result =>{
					console.log(result);
					showUploadResult(result); //업로드 결과 처리 함수
				}
			});
			
		});
		
		
		
		
	});//end ready

</script>


<%@include file="../includes/footer.jsp" %>