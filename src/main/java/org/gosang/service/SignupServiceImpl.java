package org.gosang.service;

import org.gosang.domain.SignupVO;
import org.gosang.mapper.SignupMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class SignupServiceImpl implements SignupService {
	
	@Setter(onMethod_ = @Autowired)
	private SignupMapper mapper;
	
	@Override
	public void register(SignupVO signup) {
		
		log.info("register.........." + signup);
		
		mapper.register(signup);
	}
}
