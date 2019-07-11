package org.gosang.service;

import static org.junit.Assert.assertNotNull;

import org.gosang.domain.BoardVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardService service;
	
	// BoardService 객체가 제대로 주입이 가능한지 확인하는 테스트 
	@Test
	public void testExist() {
		
		log.info(service);
		
		assertNotNull(service);
		
	}
	
//	 등록 
	@Test
	public void testInsert() {
		
		BoardVO board = new BoardVO();

		board.setTitle("새로 작성하는 글 제목");
		board.setContent("새로 작성하는 글 내용");
		board.setWriter("user00");

		service.register(board);
		
		log.info("testInsert 테스트");
	}
	
	// 목록 
	@Test
	public void testGetList() {
		
		service.getList().forEach(board -> log.info(board));
		
	}
	
	
	// 조회 
	@Test
	public void testGet() {
		
		log.info(service.get(1L));
		
	}
	
	// 수정
	@Test
	public void testUpdate() {
		
		BoardVO board = service.get(4L);
		
		if(board == null) {
			return;
		}
		
		board.setTitle("수정된 제목2222");
		log.info("MODIFY RESULT : " + service.modify(board));
		
	}
	
	
	// 삭제
	@Test
	public void testDelete() {
		
		log.info("REMOVE RESULT: " + service.remove(3L));
	}
	
}
