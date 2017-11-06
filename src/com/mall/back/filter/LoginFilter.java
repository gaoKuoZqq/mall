package com.mall.back.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter{

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO 自动生成的方法存根
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
			HttpServletRequest req = (HttpServletRequest) request;
			HttpServletResponse resp = (HttpServletResponse) response;
			HttpSession session = req.getSession(false);
			String uri = req.getRequestURI();
			String requestPath = uri.substring(uri.lastIndexOf("/") + 1, uri.length());
			if (requestPath.equals("goLogin.action") || requestPath.equals("checkLogin.action") || requestPath.equals("checkImg")) {
				chain.doFilter(request, response);
				return;
			}
			if (session == null || session.getAttribute("username") == null) {
				resp.sendRedirect(req.getContextPath() + "/user/goLogin.action");
			}else {
				chain.doFilter(request, response);
			}
			
			
			
	}

	@Override
	public void destroy() {
		// TODO 自动生成的方法存根
		
	}}
