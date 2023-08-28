package com.itwillbs.service;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.itwillbs.dao.BoardDAO;
import com.itwillbs.domain.BoardDTO;
import com.itwillbs.domain.PageDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardService {
	BoardDAO boardDAO = null; 
	public List<BoardDTO> getBoardList(PageDTO pageDTO) {
		System.out.println("BoardService getBoardList()");
		List<BoardDTO> boardList = null;
		try {
			// 시작하는 행부터 10개 뽑아오기
//			페이지번호     한화면에 보여줄 글개수 => 시작하는 행번호
//			currentPage         pageSize    => startRow
//			    1                 10        => (1-1)*10+1=>0*10+1=> 0+1=>1        ~ 10
//			    2                 10        => (2-1)*10+1=>1*10+1=>10+1=>11       ~ 20
//		        3                 10        => (3-1)*10+1=>2*10+1=>20+1=>21       ~ 30			
			
			
			int startRow = (pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
			// 시작하는 행부터 끝나는 행까지 뽑아오기
//			startRow  pageSize => endRow
//			    1         10   =>   1+10-1 =>10
//			    11        10   =>   11+10-1 =>20
//		        21        10   =>   21+10-1 =>30
			    		
			int endRow = startRow+pageDTO.getPageSize()-1;
			//pageDTO 저장 <= startRow, endRow
			pageDTO.setStartRow(startRow);
			pageDTO.setEndRow(endRow);
			
			// BoardDAO 객체생성
			boardDAO = new BoardDAO();
			// boardList = getBoardList() 메서드 호출
			boardList = boardDAO.getBoardList(pageDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardList;
	}//getBoardList()
	
	public void insertBoard(HttpServletRequest request) {
		try {
			System.out.println("BoardService insertBoard()");
			// request 한글처리
			request.setCharacterEncoding("utf-8");
			// request 파라미터 값 가져오기
			String name = request.getParameter("name");
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			// num, readcount, date => 변수저장
			int readcount = 0; //조회수
			Timestamp date = new Timestamp(System.currentTimeMillis());
			// BoardDAO 객체생성
			boardDAO = new BoardDAO();
			int num = boardDAO.getMaxNum() + 1;
			// BoardDTO 객체생성
			BoardDTO boardDTO = new BoardDTO();
			// set메서드 호출 파라미터값 저장
			boardDTO.setNum(num);
			boardDTO.setName(name);
			boardDTO.setSubject(subject);
			boardDTO.setContent(content);
			boardDTO.setReadcount(readcount);
			boardDTO.setDate(date);
			// 리턴할형없음 insertBoard(boardDTO) 호출
			boardDAO.insertBoard(boardDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}//insertBoard()

	public int getBoardCount() {
		System.out.println("BoardService getBoardCount()");
		int count=0;
		try {
			// BoardDAO 객체생성
			boardDAO = new BoardDAO();
			// count = getBoardCount() 호출
			count = boardDAO.getBoardCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}//getBoardCount

	public BoardDTO getBoard(HttpServletRequest request) {
		System.out.println("BoardService getBoard()");
		BoardDTO boardDTO = null;
		try {
			// request 한글처리
			request.setCharacterEncoding("utf-8");
			// request 파라미터 가져오기 => int num 저장
			int num = Integer.parseInt(request.getParameter("num"));
			// BoardDAO 객체생성
			boardDAO = new BoardDAO();
			// boardDTO = getBoard(num) 메서드 호출
			boardDTO = boardDAO.getBoard(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardDTO;
	}//getBoard

	//첨부파일
	public void finsertBoard(HttpServletRequest request) {
		System.out.println("BoardService finsertBoard()");
		try {
	//파일업로드 1.서버폴더에 파일업로드,데이터베이스 파일이름 저장
	//         2.데이터베이스 파일전체 저장(대용량 데이터베이스)
			
//			파일업로드 프로그램 다운	http://www.servlets.com
//			COS File Upload Library
//			다운로드 cos-22.05.zip 압축풀기
//			lib 폴더 cos.jar
//			webapp - WEB-INF - lib - cos.jar
			
// MultipartRequest 객체생성 사용 => 폴더에 파일업로드, 파라미터정보저장
//			import com.oreilly.servlet.MultipartRequest;
			// 생성자 1) request 2)업로드할 파일경로 3) 파일크기 4) 한글처리 5) 파일이름변경
			//업로드 폴더 만들기 webapp - upload 폴더만들기
			// 업로드 폴더 경로=> 물리적 경로
			String uploadPath=request.getRealPath("/upload");
			// 이클립스에 실행하면 이클립스 가상경로 
			System.out.println(uploadPath);
			//파일 최대크기 지정  10M
			int maxSize=10*1024*1024; 
			// 파일 업로드 했을때 폴더내 파일이름 동일하면 파일이름 변경하는 프로그램
//			import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
			// new DefaultFileRenamePolicy()
			MultipartRequest multi 
			= new MultipartRequest(request, uploadPath, maxSize,"utf-8", new DefaultFileRenamePolicy()); 
			
			// multi 파라미터 값 가져오기
			String name = multi.getParameter("name");
			String subject = multi.getParameter("subject");
			String content = multi.getParameter("content");
			//첨부파일이름 가져오기
			String file = multi.getFilesystemName("file");
			
			// num, readcount, date => 변수저장
			int readcount = 0; //조회수
			Timestamp date = new Timestamp(System.currentTimeMillis());
			// BoardDAO 객체생성
			boardDAO = new BoardDAO();
			int num = boardDAO.getMaxNum() + 1;
			
			// BoardDTO 객체생성
			BoardDTO boardDTO = new BoardDTO();
			// set메서드 호출 파라미터값 저장
			boardDTO.setNum(num);
			boardDTO.setName(name);
			boardDTO.setSubject(subject);
			boardDTO.setContent(content);
			boardDTO.setReadcount(readcount);
			boardDTO.setDate(date);
			//첨부파일
			boardDTO.setFile(file);
			
			// 리턴할형없음 insertBoard(boardDTO) 호출
			boardDAO.insertBoard(boardDTO);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}//finsertBoard

	public void updateBoard(HttpServletRequest request) {
		System.out.println("BoardService updateBoard()");
		try {
			// 한글처리
			request.setCharacterEncoding("utf-8");
			// num name subject content 파라미터 값 가져오기
			int num = Integer.parseInt(request.getParameter("num"));
			String name = request.getParameter("name");
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			// BoardDTO 객체생성
			BoardDTO boardDTO = new BoardDTO();
			// set메서드 호출 파라미터값 저장
			boardDTO.setNum(num);
			boardDTO.setName(name);
			boardDTO.setSubject(subject);
			boardDTO.setContent(content);
			// BoardDAO 객체생성
			boardDAO = new BoardDAO();
			// updateBoard(boardDTO) 메서드호출
			boardDAO.updateBoard(boardDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}//updateBoard()

}//클래스
