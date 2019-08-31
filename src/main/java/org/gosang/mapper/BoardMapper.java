package org.gosang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.gosang.domain.BoardVO;
import org.gosang.domain.Criteria;

public interface BoardMapper {

//	@Select("select * from tbl_board where bno > 0 ") BoardMapper.xml에 있음 
	
	List<BoardVO> getList();
	
	List<BoardVO> getListWithPaging(Criteria cri);
	
	void register(BoardVO board);
	
	BoardVO read(Integer bno);
	
	int delete(Integer bno);
	
	int update(BoardVO board);
	
	int getTotalCount(Criteria cri);	// 전체 데이터 개수 처리 
	
	void updateReplyCnt(@Param("bno") int bno, @Param("amount") int amount);

	void insertSelectKey(BoardVO board);

}
