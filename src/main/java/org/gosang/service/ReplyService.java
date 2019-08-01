package org.gosang.service;

import java.util.List;

import org.gosang.domain.Criteria;
import org.gosang.domain.ReplyPageDTO;
import org.gosang.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);
	
	public ReplyVO get(Integer rno);
	
	public int modify(ReplyVO vo);
	
	public int remove(Integer rno);
	
	public List<ReplyVO> getList(Criteria cri, Integer bno);
	
	public ReplyPageDTO getListPage(Criteria cri, Integer bno);
}
