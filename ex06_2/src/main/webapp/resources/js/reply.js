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
		
		let page = param.page || 1;
		
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
				(data) => {
					if(callback){
						callback(data);//댓글 목록만 가져오는 경우
						//callback(data.replyCnt, data.list);//댓글 숫자 + 목록 가져오는 경우(작동X)
						
					}
				}).fail( (xhr, status, err) => {
					if(error){
						error();
					}
				});
	}
	
	function remove(rno, replyer, callback, error){
		$.ajax({
			type: 'delete',
			url : '/replies/' + rno,
			data : JSON.stringify({rno:rno, replyer:replyer}),
			contentType: "application/json; charset=utf-8",
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
	
	function displayTime(timeValue){
		let today = new Date();
		
		let gap = today.getTime() - timeValue;
		
		let dateObj = new Date(timeValue);
		let str = "";
		
		if(gap < (1000 * 60 * 60 * 24)) {
			
			let hh = dateObj.getHours();
			let mi = dateObj.getMinutes();
			let ss = dateObj.getSeconds();
			
			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
					':', (ss > 9 ? '' : '0') + ss].join('');
		} else {
			let yy = dateObj.getFullYear();
			let mm = dateObj.getMonth() + 1; // getMonth() is zero-based
			let dd = dateObj.getDate();
			
			return [ yy, '/', (mm > 9 ? '' : '0') + mm,
					'/', (dd > 9 ? '' : '0') + dd].join('');
		}
	}
	
	return {
		add: add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		displayTime : displayTime
	};
	
})();