package org.gosang.mapper;

import java.util.List;

import org.gosang.domain.BoardAttachVO;

public interface BoardAttachMapper {

	void insert(BoardAttachVO attach);
	
	void delete(String uuid);
	
	List<BoardAttachVO> findByBno(int bno);
	
	void deleteAll(int bno);
	
	List<BoardAttachVO> getOldFiles();
}
