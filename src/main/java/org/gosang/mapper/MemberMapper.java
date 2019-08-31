package org.gosang.mapper;

import org.gosang.domain.MemberVO;

public interface MemberMapper {
	
	MemberVO read(String userid);
		
}
