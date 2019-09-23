package org.gosang.controller;

import org.gosang.domain.SignupVO;
import org.gosang.service.SignupService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/")
@AllArgsConstructor
public class SignupController {
	
	private SignupService service;
	
	@GetMapping("/signup")
	public void register() {
		
	}
	
	// 회원가입
	@PostMapping("/signup")
	public String register(SignupVO signup, RedirectAttributes rttr) {
		
		log.info("============================");
		log.info("register: " + signup);
		
		service.register(signup);		
		rttr.addFlashAttribute("result", signup.getUserid());
		
		log.info("============================");
		
		return "redirect:/customLogin";
	}
	
	
}
