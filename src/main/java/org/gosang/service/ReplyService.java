package org.gosang.service;

import java.util.List;

import org.gosang.domain.Criteria;
import org.gosang.domain.ReplyPageDTO;
import org.gosang.domain.ReplyVO;

public interface ReplyService {

	int register(ReplyVO vo);
	
	ReplyVO get(Integer rno);
	
	int modify(ReplyVO vo);
	
	int remove(Integer rno);
	
	List<ReplyVO> getList(Criteria cri, Integer bno);
	
	ReplyPageDTO getListPage(Criteria cri, Integer bno);
}
