package org.gosang.service;

import org.gosang.domain.SignupVO;
import org.gosang.mapper.SignupMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class SignupServiceImpl implements SignupService {
	
	@Setter(onMethod_ = @Autowired)	// 암호화된 문자
	private PasswordEncoder pwencoder;
	
	@Setter(onMethod_ = @Autowired)
	private SignupMapper mapper;
	
	@Override
	public void register(SignupVO signup) {
		
		String encUserpw = pwencoder.encode(signup.getUserpw()); //Userpw를 암호화 하여 문자열로 만든다
		log.info("암호화된 비밀번호: " + encUserpw);
		
		signup.setUserpw(encUserpw);		// 암호화된 encUserpw를 userpw에 넣는다
		
		log.info("register.........." + signup);
		
		mapper.register(signup);
	}
}
