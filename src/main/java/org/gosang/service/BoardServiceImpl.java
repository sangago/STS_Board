package org.gosang.service;

import java.util.List;

import org.gosang.domain.BoardVO;
import org.gosang.domain.Criteria;
import org.gosang.mapper.BoardMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private BoardMapper mapper;

	@Override
	public void register(BoardVO board) {
		
		log.info("register........." + board);
		
		mapper.register(board);
	}

	@Override
	public BoardVO get(Integer bno) {
		
		log.info("get........." + bno);
		
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		
		log.info("modify........" + board);
		
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(Integer bno) {
		
		log.info("remove........." + bno);
		
		return mapper.delete(bno) == 1;
	}

//	@Override
//	public List<BoardVO> getList() {
//		
//		log.info("getList............");
//		
//		return mapper.getList();
//	}
	
	@Override
	public List<BoardVO> getList(Criteria cri){
		
		log.info("get List with criteria: " + cri);
		
		return mapper.getListWithPaging(cri);
	}
	
}
