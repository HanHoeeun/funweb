package com.itwillbs.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itwillbs.service.ProductService;

public class ProductController extends HttpServlet{

	RequestDispatcher dispatcher = null;
	ProductService productService = null;
	
	// HttpServlet 처리 담당자 -> 자동으로 doGet, doPost 호출
	//-> 재정의여 사용
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ProductController doGet()");
		doProcess(request, response);
	}//doGet()

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ProductController doPost()");
		doProcess(request, response);
	}//doPost()
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ProductController doProcess()");
		// 가상주소 뽑아오기
		String sPath=request.getServletPath();
		System.out.println("뽑은 가상주소 :  " + sPath);
		// 뽑은 가상주소 비교하기 => 실제 페이지 연결
		if (sPath.equals("/producs.po")) {
			// product/products.jsp 주소변경 없이 연결
			dispatcher
			= request.getRequestDispatcher("product/products.jsp");
			dispatcher.forward(request, response);
		} // products.me
		
		
		if(sPath.equals("/productReg.po")) {
			
			dispatcher 
			    = request.getRequestDispatcher("product/productReg.jsp");
			dispatcher.forward(request, response);
			
		}//
		
		
		
		
		
		
		
		
		
		
		
		
		
	}//doProcess()
}
