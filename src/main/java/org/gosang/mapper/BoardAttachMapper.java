package org.gosang.mapper;

import java.util.List;

import org.gosang.domain.BoardAttachVO;

public interface BoardAttachMapper {

	public void insert(BoardAttachVO attach);
	
	public void delete(String uuid);
	
	public List<BoardAttachVO> findByBno(int bno);
	
}
