/**
 * 
 */

console.log("Reply Module.........");

var replyService = (function(){
	
	function add(reply, callback, error){
		
		console.log("add reply........");
		
		$.ajax({
			type : 'post',									// 통신타입 (post, get)
			url : '/replies/new',							// 요청할 url
			data : JSON.stringify(reply),					// 서버에 요청시 보낼 파라미터 
			contentType : "application/json; charset=utf-8",// 전송할테이터 타입 데이터 타입
		//	dataType : 서버로부터 받는(수신) 데이터 타입(생략가능)
			success : function(result, status, xhr) {		// 요청 및 응답 성공시 행위 
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	// 댓글목록 
	function getList(param, callback, error){		// param 객체 통해 파라미터 전달받아 JSON 목록 호출 
		
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
				function(data){
					if(callback){
						callback(data);
					}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}

	
	// 댓글 삭제
	function remove(rno, callback, error){
		$.ajax({
			type : 'delete',								// 통신타입 (post, get, delete 등등)
			url : '/replies/' + rno,						// 요청할 url
			success : function(deleteResult, status, xhr) {		// 요청 및 응답 성공시 행위 
				if (callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	
	// 댓글수정 
	function update(reply, callback, error){
		
		console.log("RNO:" + reply.rno);
		
		$.ajax({
			type : 'put',									// 통신타입 (post, get, put 등등)
			url : '/replies/' + reply.rno,							// 요청할 url
			data : JSON.stringify(reply),					// 서버에 요청시 보낼 파라미터 
			contentType : "application/json; charset=utf-8",// 전송할테이터 타입 데이터 타입
		//	dataType : 서버로부터 받는(수신) 데이터 타입(생략가능)
			success : function(result, status, xhr) {		// 요청 및 응답 성공시 행위 
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	// 댓글조회
	function get(rno, callback, error){
		
		$.get("/replies/" + rno + ".json", function(result){
			
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get
	};
	
	
})();