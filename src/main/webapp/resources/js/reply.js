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
	
	// 시간처리: 문화권마다 표기 순서등이 다르기 때문에 화면에서 포맷을 처리
	function displayTime(timeValue){
		
		var today = new Date();
		
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		var str = "";
		
		if(gap < (1000 * 60 * 60 * 24)){	// 1초 * 60초(1분) * 60분(1시간) * 24(시간) -> 24시간이 안됐으면 시분초 표시 
			
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss].join('');
		
		} else {	// 24시간이 넘으면 년월일로 표시 
			
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();
			
			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd ].join('');
		}
	}
	
	
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		displayTime : displayTime
	};
	
	
})();