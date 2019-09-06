package org.gosang.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.gosang.domain.AuthVO;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		
		log.info("access Denied : " + auth);
		
		model.addAttribute("msg", "Access Denied");
	}
	
	
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		
		log.info("************* error: " + error);
		log.info("************* logout: " + logout);
		
		if(error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
		
		
	}
	
	@RequestMapping(value="/customLogin", method=RequestMethod.POST)
    public String loginInput(@Valid  @ModelAttribute("auth") AuthVO auth, Errors errors, HttpServletRequest request){ 
         
            if(errors.hasErrors()){ // 에러 있다면
                return "/customLogin";
            } else {
                    return "/board/list";
            }
        
    }
	
	
	
	@GetMapping("/customLogout")
	public void logoutGET() {
		
		log.info("custom logout");
		
	}
	
	@PostMapping("/customLogout")
	public void logoutPost() {
		
		log.info("post custom logout");
		
	}

}
