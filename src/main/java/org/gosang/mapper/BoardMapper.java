package org.gosang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.gosang.domain.BoardVO;

public interface BoardMapper {

//	@Select("select * from tbl_board where bno > 0 ") BoardMapper.xml에 있음 
	
	public List<BoardVO> getList();
	
	public void register(BoardVO board);
	
	public BoardVO read(Integer bno);
	
	public int delete(Integer bno);
	
	public int update(BoardVO board);
}
