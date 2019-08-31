package org.gosang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.gosang.domain.Criteria;
import org.gosang.domain.ReplyVO;

public interface ReplyMapper {
	
	int insert(ReplyVO vo);
	
	ReplyVO read(Integer rno);
	
	int delete(Integer rno);
	
	int update(ReplyVO reply);

	// 댓글목록: 두개 이상의 데이터를 파라미터로 전달하기 위해 @Param 이용  
	List<ReplyVO> getListWithPaging(
		@Param("cri") Criteria cri,
		@Param("bno") Integer bno
		);
	
	// 댓글갯수파악
	int getCountByBno(Integer bno);
	
}
