package org.gosang.mapper;

import java.util.List;

public interface BoardAttachVO {

	public void insert(BoardAttachVO vo);
	
	public void delete(String uuid);
	
	public List<BoardAttachVO> findByBno(Long bno);
	
}
