package org.gosang.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.gosang.domain.SampleVO;
import org.gosang.domain.Ticket;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;




@RestController
@RequestMapping("/sample")
@Log4j
public class SampleController {
	
	@GetMapping(value = "/getText", produces = "text/plain; charset=UTF-8")
	public String getText() {
		log.info("MIME TYPE: " + MediaType.TEXT_PLAIN_VALUE);
		
		return "안녕하세요.";
	}
	
	// SampleVO를 리턴하는 메서드
	@GetMapping(value = "/getSample",
			produces = { MediaType.APPLICATION_JSON_UTF8_VALUE,		// JSON 방식의 데이터 생성 
						 MediaType.APPLICATION_XML_VALUE })			// XML 방식의 데이터 생
	public SampleVO getSample() {
		
		return new SampleVO(112, "스타", "로드");
	}
	
	@GetMapping(value = "/getSample2")
	public SampleVO getSample2() {
		return new SampleVO(113, "로켓", "라쿤");
	}
	
	@GetMapping(value = "/getList")
	public List<SampleVO> getList(){
		
		return IntStream.range(1,10).mapToObj(i -> new SampleVO(i, i + "First", i + "Last")).collect(Collectors.toList());
		
		// IntStream.range(1, 10) : 1에서 10사이의 integer를 차례대로 나옴 (1,2,3,4,5,6,7,8,9)
		// mapToObj() : mapToObj(i->i+","); 정수를 문자열로 변환 
		// collect(Collectors.toList() : 스트림의 모든 요소를 컬렉션에 수집 
	}
	
	@GetMapping(value = "/getMap") // 맵 경우 '키'와 '값'을 하나의 객체로 간주 
	public Map<String,SampleVO> getMap(){
		
		Map<String, SampleVO> map = new HashMap<>();
		map.put("First", new SampleVO(111,"그루트", "주니어"));
		
		return map;
	}
	
	@GetMapping(value = "/check", params = { "height", "weight" })
	public ResponseEntity<SampleVO> check(Double height, Double weight){
		
		SampleVO vo = new SampleVO(0, "" + height, "" + weight);
		
		ResponseEntity<SampleVO> result = null;
		
		if (height < 150) {		// HttpStatus : 데이터와 함께 HTTP 헤더 상태 메시지 같이 전달 
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);	
		} else {
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		
		return result;
	}
	
	@GetMapping("/product/{cat}/{pid}")
	public String[] getPath(@PathVariable("cat") String cat, @PathVariable("pid") Integer pid) { // @PathVariable: int, double같은 기본 자료형은 사용 못함 
		
		return new String[] { "category: " + cat, "productid: " + pid };
	}
	
	@PostMapping("/ticket")
	public Ticket convert(@RequestBody Ticket ticket) {
		
		log.info("convert.....ticket" + ticket);
		
		return ticket;
	}
}
