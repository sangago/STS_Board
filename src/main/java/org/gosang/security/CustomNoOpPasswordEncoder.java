package org.gosang.security;

import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomNoOpPasswordEncoder implements PasswordEncoder {

	public String encode(CharSequence rawPassword) {
		
		log.warn("before encode: " + rawPassword);
		
		return rawPassword.toString();
	}
	
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		
		log.warn("matches: " + rawPassword + " : " + encodedPassword);
		
		return rawPassword.toString().equals(encodedPassword);
	}
	
	/*
	 * PasswordEncoder 인터페이스
	 * encode(): 실제로 패스워드를 암호화 할 때 사용 
	 * matches(): 사용자에게 입력받은 패스워드를 비교 할 때 사용 
	 * 
	 * 
	 * */
}
