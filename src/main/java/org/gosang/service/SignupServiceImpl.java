package org.gosang.service;

import org.gosang.domain.SignupVO;
import org.gosang.mapper.SignupMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class SignupServiceImpl implements SignupService {

	private SignupMapper mapper;
	
	@Override
	public void register(SignupVO signup) {
		
		log.info("register.........." + signup);
		
		mapper.register(signup);
	}
}
