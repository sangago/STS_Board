package org.gosang.controller;

import org.gosang.domain.BoardVO;
import org.gosang.domain.Criteria;
import org.gosang.domain.PageDTO;
import org.gosang.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor				// 생성자를 만들고 자동으로 주입 (의존성처리)
public class BoardController {
	
	private BoardService service;
	
//	@GetMapping("/list")
//	public void list(Model model) {
//		
//		log.info("list");
//		
//		model.addAttribute("list", service.getList());
//	}
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		
		log.info("list:" + cri);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, 123));
		
	}
	
	//게시물 등록 
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		
		log.info("register: " + board);
		
		service.register(board);
		
		rttr.addFlashAttribute("result", board.getBno());
		
		return "redirect:/board/list";
	}
	
	// 입력페이지 보기  
	@GetMapping("/register") 
	public void register() {
		
	}
	
	
	// 수정/삭제가 가능한 화면으로 이동
	@GetMapping({"/get","/modify"})		// 배열로 처리 
	public void get(@RequestParam(value="bno", defaultValue="bno") Integer bno, @ModelAttribute("cri") Criteria cri, Model model) {
		
		log.info("/get or /modify");
		model.addAttribute("board", service.get(bno));
	}
	
	
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("modify:" + board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Integer bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("remove..." + bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/board/list";			// 게시물 삭제 후 목록 페이지 이동 
		
	}
	
	
}

/* RedirectAttributes 
 * 
 * redirect 사용시 GET 메소드 방식을 이용한다. 그래서 URL에 파라미터가 노출되는 단점이 있다
 * 스프링은 RedirectAttributes클래스를 제공한다.
 * RedirectAttributes 클래스에는 addFlashAttribute() 메소드가 포함되어 있다
 * 
 * addFlashAttribute() 메소드는 redirect 전에 플래시 속성을 세션에 복사한다. 
 * redirect 이후에는 저장된 플래시 속성을 세션에서 모델로 이동시켜 헤더에 파라미터를 붙이지 않기 때문에 URL에 노출되지 않는다
 *  
 * 글등록과 수정에 파라미터로 RedirectAttributes를 사용하는 이유는
 * 어떤 작업(등록, 수정, 삭제) 이후 페이지(목록페이지)로 이동하기 위함이다.
 * (새롭게 등록된 게시물의 번호를 같이 전달하기 위해서 이용) 
 *  
 * */

/* @RequestParam 
 * HTTP요청 파라미터를 메소드 파라미터에 넣어주는 애노테이션 
 * */


/* return시 "redirect:" 사용 
 * 스프링 MVC가 내부적으로 response.sendRedirect()를 처리해 준다  
 * */