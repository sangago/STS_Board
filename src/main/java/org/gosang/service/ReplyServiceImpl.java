package org.gosang.service;

import java.util.List;

import org.gosang.domain.Criteria;
import org.gosang.domain.ReplyPageDTO;
import org.gosang.domain.ReplyVO;
import org.gosang.mapper.BoardMapper;
import org.gosang.mapper.ReplyMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor	// ReplyMapper 타입의 객체를 필요로 하는 생성자 생성 (@Setter 주입같은역할..)
public class ReplyServiceImpl implements ReplyService {

	//@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	//@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {

		log.info("register........." + vo);
		
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Integer rno) {

		log.info("get........." + rno);
		
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {

		log.info("modify........." + vo);
		
		return mapper.update(vo);
	}
	
	@Transactional
	@Override
	public int remove(Integer rno) {

		log.info("remove........." + rno);
		
		ReplyVO vo = mapper.read(rno);
		
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Integer bno) {

		log.info("get Reply List of a Board " + bno);
		
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Integer bno) {
		
		return new ReplyPageDTO( mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}

}
