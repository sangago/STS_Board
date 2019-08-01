package org.gosang.controller;

import java.util.List;

import org.gosang.domain.Criteria;
import org.gosang.domain.ReplyPageDTO;
import org.gosang.domain.ReplyVO;
import org.gosang.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor	// ReplyService 타입의 객체를 필요로 하는 생성자 생성 (@Setter 주입같은역할..)
public class ReplyController {
	
	private ReplyService service;
	
	@PostMapping(value = "/new",
			consumes = "application/json",				// @Consumes : 수신 하고자하는 데이터 포맷을 정의.
			produces = { MediaType.TEXT_PLAIN_VALUE })	// @Produces : 출력하고자 하는 데이터 포맷을 정의.
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){		// @RequestBody: json 데이터를 ReplyVO 타입으로 변환  
		
		// ReplyServiceImpl을 호출해서 register()를 호출. 댓글이 추가된 숫자 확인후 결과반환
		
		log.info("ReplyVO: " + vo);
		
		int insertCount = service.register(vo);
		
		log.info("Reply INSERT COUNT: " + insertCount);
		
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	@GetMapping(value = "/pages/{bno}/{page}",
			produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("bno") Integer bno){
		
		log.info("getList...........");
		
		Criteria cri = new Criteria(page,10);
		
		log.info("cri: " + cri);
		
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	}
	
	
	// 댓글조회 
	@GetMapping(value = "/{rno}",
			produces = { MediaType.APPLICATION_XML_VALUE,
						 MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Integer rno) {
		
		log.info("get: " + rno);
		
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	
	@DeleteMapping(value="/{rno}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> remove(@PathVariable("rno") Integer rno){
		
		log.info("remove: " + rno);
		
		return service.remove(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	@RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH },
			value = "/{rno}",
			consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify(
			@RequestBody ReplyVO vo,				// 수정되는 데이터는 json포멧이기 때문에 @RequestBody 이용 	
			@PathVariable("rno") Integer rno) {
				
				vo.setRno(rno);
				
				log.info("rno: " + rno);
				
				log.info("modify: " + vo);
				
				return service.modify(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
