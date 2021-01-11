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
		<h1 class="page-header">Board Read Page</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			
			<div class="panel-heading">Board Read Page</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				
				
				<div class="form-group">
					<label>Bno</label><input class="form-control" name="bno"
					value='<c:out value="${board.bno }"/>' readonly="readonly"/>
				</div>
				
				<div class="form-group">
					<label>Title</label><input class="form-control" name="title"
					value='<c:out value="${board.title }"/>' readonly="readonly"/>
				</div>
				
				<div class="form-group">
					<label>Text area</label>
					<textarea class="form-control" rows="3" name="content" readonly="readonly"><c:out value="${board.content }" /></textarea>
				</div>
				
				<div class="form-group">
					<label>Writer</label> <input class="form-control" name="writer"
					value='<c:out value="${board.writer }"/>' >
				</div>
				
				<sec:authentication property="principal" var="pinfo" />
				
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq board.writer }">
						<button data-oper="modify" class="btn btn-default">
						<a href="/board/modify">Modify</a></button>
					</c:if>
				</sec:authorize>
				
				<button data-oper="list" class="btn btn-info">
				<a href="/board/list">List</a></button>
				
				<form id="operForm" action="/board/modify" method="get">
					<input type="hidden" id='bno' name='bno' value='<c:out value="${board.bno }" />'>
					<input type="hidden" id='pageNum' name='pageNum' value='<c:out value="${cri.pageNum }" />'>
					<input type="hidden" id='amount' name='amount' value='<c:out value="${cri.amount }" />'>
					<input type="hidden" id='keyword' name='keyword' value='<c:out value="${cri.keyword }" />'>
					<input type="hidden" id='type' name='type' value='<c:out value="${cri.type }" />'>
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
				<div class="uploadResult">
					<ul>
					</ul>
				</div>
			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		
		<!-- /.panel -->
		<div class="panel panel-default">
		<!-- 	<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
			</div> -->
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
				<sec:authorize access="isAuthenticated()">
				<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
				</sec:authorize>
			</div>
			
			<!-- /.panel-heading -->
			<div class="panel-body">
			
				<ul class="chat">
					<!--  start reply -->
					<li class="left clearfix" data-rno='12'>
						<div>
							<div class="header">
								<strong class="primary-font">user00</strong>
								<small class="pull-right text-muted">2020-12-31 12:12</small>
							</div>
							<p>Good Job!</p>
						</div>
					</li>
					<!-- end reply -->
				</ul>
				<!-- ./ end ul -->
			</div>
			<!-- /.panel .chat-panel -->
			<div class="panel-footer">
			
			</div>
		</div>
	</div>
	<!-- ./end row -->
</div>

<!-- 댓글달기용 모달창 -->
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                	<label>Reply</label>
                	<input class="form-control" name='reply' value='New Reply!!!'>
                </div>
                
                <div class="form-group">
                	<label>Replyer</label>
                	<input class="form-control" name='replyer' value='replyer'>
                </div>
                
                <div class="form-group">
                	<label>Reply Date</label>
                	<input class="form-control" name='replyDate' value=''>
                </div>
                
            </div>
            <div class="modal-footer">
                <button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
                <button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
                <button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
                <button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->


<!-- 자바스크립트 파일 인식 400p -->
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">
// 12번 댓글 수정

$(document).ready(() => {
	(() => {
		let bno = '<c:out value="${board.bno}"/>';
		
		$.getJSON("/board/getAttachList", {bno:bno}, arr =>{
			
			console.log(arr);
			
			let str = "";
			
			$(arr).each((i, attach) =>{
				//image type
				if(attach.fileType){
				let fileCallPath = encodeURIComponent(attach.uploadPath+ "/s_" + attach.uuid + "_" + attach.fileName);
				
				str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName +"' data-type='" + attach.fileType +"' ><div>";
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div>";
				str += "</li>";
				} else {
					str += "<li data-path='" + attach.uploadPath + "' data-uuid='"+ attach.uuid + "' data-filename='"+attach.fileName +"' data-type='"+attach.fileType+"' ><div>";
					str += "<span> " + attach.fileName + "</span><br/>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str += "</li>";
				}
			});
			
			$(".uploadResult ul").html(str);
			
		});
	})();
	
	$(".uploadResult").on("click", "li", function(e){
		
		console.log("view image");
		
		let liObj = $(this);
		
		let path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_"+liObj.data("filename"));
		
		if(liObj.data("type")){
			showImage(path.replace(new RegExp(/\\/g), "/"));
		}else{
			//download
			self.location = "/download?fileName="+path;
		}
	});
	
	function showImage(fileCallPath){
		alert(fileCallPath);
		
		$(".bigPictureWrapper").css("display", "flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName="+fileCallPath+"'>")
		.animate({width:'100%', height:'100%'}, 1000);
	}
	
	$(".bigPictureWrapper").on("click", e=>{
		$(".bigPicture").animate({width:'0%', height:'0%'}, 1000);
		setTimeout(()=>{
			$('.bigPictureWrapper').hide();
		});
	});
	
	
	let bnoValue = '<c:out value="${board.bno}" />';
	let replyUL = $(".chat");
	
	showList(1);
	
	function showList(page){

		console.log("show List " + page);
		
		replyService.getList({bno:bnoValue, page:page || 1}, 
							function(replyData){
			
			console.log("replyCnt: " + replyData.replyCnt);
			console.log("list: " + replyData.list);
			console.log(replyData.list);
			
			if(page == -1){
				pageNum = Math.ceil(replyData.replyCnt / 10.0);
				showList(pageNum);
				return;
			}
			
			
			let str = "";
			if(replyData.list == null || replyData.list.length == 0){
				return;
			}
			for(let i=0, len=replyData.list.length || 0; i < len; i++){
				str += "<li class='left clearfix' data-rno='" + replyData.list[i].rno +"'>";
				str += "  <div><div class='header'><strong class='primary-font'>[" + replyData.list[i].rno + "] " + replyData.list[i].replyer + "</strong>";
				str += "    <small class='pull-right text-muted'>"+replyService.displayTime(replyData.list[i].replyDate)+"</small></div>";
				str += "      <p>"+replyData.list[i].reply+"</p></div></li>";
				
			}
			replyUL.html(str);
			
			showReplyPage(replyData.replyCnt);
		});//end function
	}//end showList
	
	let modal = $(".modal");
	let modalInputReply = modal.find("input[name='reply']");
	let modalInputReplyer = modal.find("input[name='replyer']");
	let modalInputReplyDate = modal.find("input[name='replyDate']");
	
	let modalModBtn = $("#modalModBtn");
	let modalRemoveBtn = $("#modalRemoveBtn");
	let modalRegisterBtn = $("#modalRegisterBtn");
	
	let replyer = null;
	
	<sec:authorize access="isAuthenticated()">
	
	replyer = '<sec:authentication property="principal.username"/>';
	
	</sec:authorize>
	
	let csrfHeaderName = "${_csrf.headerName}";
	let csrfTokenValue = "${_csrf.token}";
	
	$("#addReplyBtn").on("click", e => {
		modal.find("input").val("");
		modal.find("input[name='replyer']").val(replyer);
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		
		modalRegisterBtn.show();
		
		$(".modal").modal("show");
	});
	
	//Ajax spring security header...
	$(document).ajaxSend((e, xhr, options) => {
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	modalRegisterBtn.on("click", e =>{
		
		let reply = {
				reply : modalInputReply.val(),
				replyer: modalInputReplyer.val(),
				bno: bnoValue
		};
	
	
		replyService.add(reply, result =>{
			
			alert(result);
			
			modal.find("input").val("");
			modal.modal("hide");
			
			//showList(1);
			showList(-1);
		});
	});
	
	$(".chat").on("click", "li", function(e) {
		let rno = $(this).data("rno");
		
		replyService.get(rno, reply => {
			
			modalInputReply.val(reply.reply);
			
			modalInputReplyer.val(reply.replyer);
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
			modal.data("rno", reply.rno);
			
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			
			$(".modal").modal("show");
		});
	});
	
	modalModBtn.on("click", e => {
		
		let reply = {rno:modal.data("rno"),
					reply:modalInputReply.val()};
		
		replyService.update(reply, result => {
			
			alert(result);
			modal.modal("hide");
			showList(1);
		});
	});
	
	modalRemoveBtn.on("click", e => {
		
		let rno = modal.data("rno");
		
		replyService.remove(rno, result => {
			
			alert(result);
			modal.modal("hide");
			showList(1);
		});
	});
	
	
	let pageNum = 1;
	let replyPageFooter = $(".panel-footer");
	
	function showReplyPage(replyCnt){
		
		let endNum = Math.ceil(pageNum / 10.0) * 10;
		let startNum = endNum - 9;
		
		let prev = startNum != 1;
		let next = false;
		
		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt/10.0);
		}
		
		if(endNum * 10 < replyCnt){
			next = true;
		}
		
		let str = "<ul class='pagination pull-right'>";
		
		if(prev){
			str += "<li class='page-item'><a class='page-link' href='" + (startNum -1)+"'>Previous</a></li>";
		}
		
		for(let i = startNum; i <= endNum; i++){
			let active = pageNum == i ? "active" : "";
			
			str += "<li class='page-item " + active + " '><a class='page-link' href='" + i + "'>" + i + "</a></li>";
		}
		
		if(next){
			str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1)+ "'>Next</a></li>";
		}
		
		str += "</ul></div>";
		
		console.log(str);
		
		replyPageFooter.html(str);
	}	

	replyPageFooter.on("click", "li a", function(e) {

		e.preventDefault();
		console.log("page click");
		
		let targetPageNum = $(this).attr("href");
		
		console.log("targetPageNum : " + targetPageNum);
		
		pageNum = targetPageNum;
		
		showList(pageNum);
	});
	
	
});
</script>



<script type="text/javascript">
	$(document).ready( () =>{
		let operForm = $("#operForm");
		
		$("button[data-oper='modify']").on("click", function(e){
			e.preventDefault();
			operForm.attr("action", "/board/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			e.preventDefault();
			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list").submit();
		});
	});
</script>



<%@include file="../includes/footer.jsp" %>