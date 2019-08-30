package org.gosang.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.gosang.domain.BoardVO;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter implements SessionNames {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		if(session.getAttribute(LOGIN) != null) {
			session.removeAttribute(LOGIN);
		}
		
//		System.out.println("request URI: " request.getRequestURI());
		System.out.println("handler: " + handler);
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object Handler, ModelAndView modelAndView) throws Exception {
		
		HttpSession session = request.getSession();
		
		Object user = modelAndView.getModelMap().get("user");
		
	}
}
