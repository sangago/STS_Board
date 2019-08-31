package org.gosang.service;

import java.util.List;

import org.gosang.domain.BoardAttachVO;
import org.gosang.domain.BoardVO;
import org.gosang.domain.Criteria;

public interface BoardService {
	
	void register(BoardVO board);
	
	BoardVO get(Integer bno);
	
	boolean modify(BoardVO board);
	
	boolean remove(Integer bno);
	
//	public List<BoardVO> getList();
	
	List<BoardVO> getList(Criteria cri);
	
	int getTotal(Criteria cri);
	
	List<BoardAttachVO> getAttachList(Integer bno);
}
