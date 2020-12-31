console.log("Reply Module.......");



let replyService = ( () => {
	

	function add(reply, callback, error){
		console.log("reply............");
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : (result, status, xhr) => {
				if(callback){
					callback(result);
				}
			},
			error : (xhr, status, er) => {
				if(error){
					error(er);
				}
			}
		})
	}

	function getList(param, callback, error){
		
		let bno = param.bno;
		
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
				(data) => {
					if(callback){
						callback(data);
					}
				}).fail( (xhr, status, err) => {
					if(error){
						error();
					}
				});
	}
	
	function remove(rno, callback, error){
		$.ajax({
			type: 'delete',
			url : '/replies/' + rno,
			success : (deleteResult, status, xhr) => {
				if(callback){
					callback(deleteResult);
				}
			},
			error : (xhr, status, er) => {
				if(error){
					error(er);
				}
			}
		});
	}
	
	function update(reply, callback, error){
		
		console.log("RNO: " + reply.rno);
		
		$.ajax({
			type:'put',
			url:'/replies/' + reply.rno,
			data : JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: (result, status, xhr) =>{
				if(callback) {
					callback(result);
				}
			},
			error : (xhr, status, er) => {
				if(error){
					error(er);
				}
			}
		});
	}
	
	function get(rno, callback, error){
		$.get("/replies/" + rno + ".json", result => {
			if(callback){
				callback(result);
			}
		}).fail((xhr, status, err) => {
			if(error){
				error();
			}
		});
	}
	
	return {
		add: add,
		getList : getList,
		remove : remove,
		update : update,
		get : get
	};
	
})();