package org.gosang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.gosang.domain.BoardVO;
import org.gosang.domain.Criteria;

public interface BoardMapper {

//	@Select("select * from tbl_board where bno > 0 ") BoardMapper.xml에 있음 
	
	public List<BoardVO> getList();
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public void register(BoardVO board);
	
	public BoardVO read(Integer bno);
	
	public int delete(Integer bno);
	
	public int update(BoardVO board);
	
	public int getTotalCount(Criteria cri);	// 전체 데이터 개수 처리 
	
	public void updateReplyCnt(@Param("bno") int bno, @Param("amount") int amount);

	public void insertSelectKey(BoardVO board);

}
