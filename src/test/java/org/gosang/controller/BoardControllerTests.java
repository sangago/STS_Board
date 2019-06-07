package org.gosang.controller;

import org.gosang.domain.BoardVO;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration	// WebApplicationContext 이용 (ServletContext이용)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@Log4j
public class BoardControllerTests {
	
	@Setter(onMethod_ = { @Autowired } )
	
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	
	
	@Test
	public void testList() throws Exception{
		
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
				.andReturn()			// getList()에서 반환된 결과 
				.getModelAndView()		// 요청을 통해 생성된 ModelAndView 객체를 구함 
				.getModelMap());
	}
	
	
	@Test
	public void testRegister() throws Exception{
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
				.param("title", "테스트 새글 제목")
				.param("content", "테스트 새글 내용")
				.param("writer", "user00")
				).andReturn().getModelAndView().getViewName();
		
				log.info(resultPage);
				
	}
	
	
	@Test
	public void testGet() throws Exception{
		
		log.info(mockMvc.perform(MockMvcRequestBuilders
				.get("/board/get")
				.param("bno","4"))
				.andReturn()
				.getModelAndView().getModelMap());
	}
	
	
	@Test
	public void testModify() throws Exception{
		
		String resultPage = mockMvc
				.perform(MockMvcRequestBuilders.post("/board/modify")
						.param("bno", "1")
						.param("title", "수정된 테스트 새글 제목")
						.param("content", "수된 테스트 새글 내용")
						.param("writer", "user00"))
						.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	
	
	@Test
	public void testRemove() throws Exception{
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
				.param("bno", "4")
				).andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
}

/* MockMvc
 *  
 * perform() 메서드를 이용하여 요청을 생성 할 수 있다 
 * 등록, 수정, 삭제 return 타입이 string인 이유는 MockMvc를 이용해서 파라미터를 전달할때는 문자열로만 처리해야 하기 때문 
 * 
 * */

/* MockMvcBuilders
 * 
 * 가짜로 URL과 파라미터등을 브라우저에서 사용하는 것처럼 만들어서 Controller를 실행해 볼 수 있다 
 * 
 * MockMvcRequestBuilder의 post()를 이용하면 POST방식으로 데이터를 전달할 수 있고,
 * param()를 이용해서 전달해야하는 파라미터 지정 
 * */
 