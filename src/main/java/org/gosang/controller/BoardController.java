package org.gosang.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.gosang.domain.BoardAttachVO;
import org.gosang.domain.BoardVO;
import org.gosang.domain.Criteria;
import org.gosang.domain.PageDTO;
import org.gosang.service.BoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
//		model.addAttribute("pageMaker", new PageDTO(cri, 123));
		
		int total = service.getTotal(cri);
		
		log.info("total: " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}
	
	//게시물 등록 
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")	// @PreAuthorize: 요청이 들어와 함수를 실행하기 전에 권한을 검사 / isAuthenticated(): 어떤 사용자든 로그 한 사용자만 사용 할 수 있음
	public String register(BoardVO board, RedirectAttributes rttr) {
		
		log.info("============================");
		log.info("register: " + board);
		
		if(board.getAttachList() != null) {
			
			board.getAttachList().forEach(attach -> log.info(attach));
			
		}
		
		service.register(board);		
		rttr.addFlashAttribute("result", board.getBno());
		
		log.info("============================");
		
		return "redirect:/board/list";
	}
	
	// 입력페이지 보기  
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		
	}
	
	
	// 수정,삭제가 가능한 화면으로 이동
	@GetMapping({"/get","/modify"})		// 배열로 처리 
	public void get(@RequestParam(value="bno", defaultValue="bno") Integer bno, @ModelAttribute("cri") Criteria cri, Model model) {
		
		log.info("/get or /modify");
		model.addAttribute("board", service.get(bno));
	}
	
// UriComoponentsBuilder를 사용 한 수정&삭제 	
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, BindingResult result, RedirectAttributes rttr) {
		
		log.info("modify:" + board);
		log.info("modify:::::::::::::::" + result);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/board/list" + cri.getListLink();
		
	}
	
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Integer bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String writer) {
		
		log.info("remove..." + bno);
		
		// 첨부파일 리스트 
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		if(service.remove(bno)) {
			
			// delete Attach Files
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/board/list" + cri.getListLink();			// 게시물 삭제 후 목록 페이지 이동 
		
	}
// END    UriComoponentsBuilder를 사용 한 수정&삭제	
	
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody		// 자바 객체를 HTTP 요청의 body 내용으로 매핑하는 역할(JSON 데이터를 반환)
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Integer bno){
		
		log.info("getAttachList " + bno);
		
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
	
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		log.info("delete attach files.........");
		log.info("attachList");
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("/Users/gosang-a/Downloads/temp/" + attach.getUploadPath() + "/" + attach.getUuid() + "_" + attach.getFileName());
				
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					
					Path thumbNail = Paths.get("/Users/gosang-a/Downloads/temp/" + attach.getUploadPath() + "/s_" + attach.getUuid() + "_" + attach.getFileName());
					
					Files.delete(thumbNail);
				}
			} catch(Exception e) {
				log.error("delete file error" + e.getMessage());
			}// end catch
		});
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