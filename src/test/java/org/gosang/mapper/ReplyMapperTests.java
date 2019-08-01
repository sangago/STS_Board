package org.gosang.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.gosang.domain.Criteria;
import org.gosang.domain.ReplyVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	private Integer[] bnoArr = { 2555873, 2555873, 2555873, 2555873, 2555873 };
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;

	// Insert Test
	@Test
	public void testCreate() {
		
		IntStream.rangeClosed(1, 10).forEach(i -> {
			
			ReplyVO vo = new ReplyVO();
			
			vo.setBno(bnoArr[i % 5]);
			vo.setReply("댓글테스트 " + i);
			vo.setReplyer("replyer " + i);
			
			mapper.insert(vo);
		});
	}
	
	
	// Read Test
	@Test
	public void testRead() {
		
		Integer targetRno = 5;
		
		ReplyVO vo = mapper.read(targetRno);
		
		log.info(vo);
	}
	
	
	// Delete Test
//	@Test
//	public void testDelete() {
//		
//		Integer targetRno = 1;
//		
//		mapper.delete(targetRno);
//	}

	// Update Test
	@Test
	public void testUpdate() {
		
		Integer targetRno = 10;
		
		ReplyVO vo = mapper.read(targetRno);
		
		vo.setReply("Update Reply ");
		
		int count = mapper.update(vo);
		
		log.info("UPDATE COUNT: " + count);
	}
	
	// getListWithPaging Test
	@Test
	public void testList() {
		
		Criteria cri = new Criteria();
		
		// bnoArr[0]=314
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		
		replies.forEach(reply -> log.info(reply));
	}
	
	// 댓글 페이징 테스트
	@Test
	public void testList2() {
		
		Criteria cri = new Criteria(2, 10);
		
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 2555873);
		
		replies.forEach(reply -> log.info(reply));
		
	}
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}
}
