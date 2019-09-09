package org.gosang.service;

import org.gosang.domain.SignupVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class SignupServiceTests {

	@Setter(onMethod_ = {@Autowired})
	private SignupService service;
	
	@Test
	public void testExist() {
		
		SignupVO signup = new SignupVO();
		
		signup.setUserid("testUser");
		signup.setUserpw("1234");
		signup.setUsername("테스트유저");
		
		service.register(signup);
		
		log.info(service);
	}
}
