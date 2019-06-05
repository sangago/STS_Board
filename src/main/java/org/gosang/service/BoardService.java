package org.gosang.service;

import java.util.List;

import org.gosang.domain.BoardVO;

public interface BoardService {
	
	public void insert(BoardVO board);
	
	public BoardVO get(Long bno);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	
	public List<BoardVO> getList();
}
