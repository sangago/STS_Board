package org.gosang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.gosang.domain.Criteria;
import org.gosang.domain.ReplyVO;

public interface ReplyMapper {
	
	public int insert(ReplyVO vo);
	
	public ReplyVO read(Integer rno);
	
	public int delete(Integer rno);
	
	public int update(ReplyVO reply);

	// 댓글목록: 두개 이상의 데이터를 파라미터로 전달하기 위해 @Param 이용  
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("bno") Integer bno);
	
}
