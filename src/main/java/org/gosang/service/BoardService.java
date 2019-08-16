package org.gosang.service;

import java.util.List;

import org.gosang.domain.BoardAttachVO;
import org.gosang.domain.BoardVO;
import org.gosang.domain.Criteria;

public interface BoardService {
	
	public void register(BoardVO board);
	
	public BoardVO get(Integer bno);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Integer bno);
	
//	public List<BoardVO> getList();
	
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public List<BoardAttachVO> getAttachList(Integer bno);
}
