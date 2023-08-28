package com.itwillbs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.itwillbs.domain.BoardDTO;
import com.itwillbs.domain.PageDTO;

public class BoardDAO {
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs =null;
	
	//1,2 단계 디비 연결 메서드  정의 => 필요로 할때 호출 사용
	public Connection getConnection() throws Exception {
		Context init = new InitialContext();
		DataSource ds=
		(DataSource)init.lookup("java:comp/env/jdbc/Mysql");
		con=ds.getConnection();
		return con;
	}
	//기억장소 해제 메서드()
	public void dbClose() {
		//  => con, pstmt, rs 기억장소 해제
		if(rs != null) {try {rs.close();} catch (SQLException e) {	}}			
		if(pstmt != null) {try {pstmt.close();} catch (SQLException e) {	}}
		if(con != null) {try {con.close();} catch (SQLException e) {	}}
	}
	
	public List<BoardDTO> getBoardList(PageDTO pageDTO) {
		System.out.println("BoardDAO getBoardList()");
		List<BoardDTO> boardList = null;
		try {
			//1,2 디비연결
			con = getConnection();
			//3 sql  => mysql 제공 => limit 시작행-1, 몇개
//			String sql="select * from board order by num desc";
			String sql="select * from board order by num desc limit ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pageDTO.getStartRow()-1);//시작행-1
			pstmt.setInt(2, pageDTO.getPageSize());//몇개
			//4 실행 => 결과 저장
			rs = pstmt.executeQuery();
			// boardList 객체생성
			boardList = new ArrayList<>();
			//5 결과 행접근 => BoardDTO객체생성 => set호출(열접근저장)
			// => 배열 한칸에 저장
			while(rs.next()) {
				BoardDTO boardDTO =new BoardDTO();
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				// => 배열 한칸에 저장
				boardList.add(boardDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbClose();
		}
		return boardList;
	}//getBoardList()
	
	public int getMaxNum() {
		System.out.println("BoardDAO getMaxNum()");
		int num = 0;
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql select max(num) from members
			String sql = "select max(num) from board;";
			pstmt=con.prepareStatement(sql);
			//4 실행 => 결과저장
			rs =pstmt.executeQuery();
			//5 if 다음행  => 열데이터 가져와서 => num저장
			if(rs.next()) {
				num = rs.getInt("max(num)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbClose();
		}
		return num;
	}//getMaxNum()
	
	public void insertBoard(BoardDTO boardDTO) {
		System.out.println("BoardDAO insertBoard()");
		// board테이블 file 열추가
		// mysql -uroot -p1234 jspdb
		// file컬럼 추가
		// alter table board
		// add file varchar(100);
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql insert
			String sql = "insert into board(num,name,subject,content,readcount,date,file) values(?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, boardDTO.getNum());      //(물음표 순서,값)
			pstmt.setString(2, boardDTO.getName()); 
			pstmt.setString(3, boardDTO.getSubject());
			pstmt.setString(4, boardDTO.getContent());
			pstmt.setInt(5, boardDTO.getReadcount());
			pstmt.setTimestamp(6, boardDTO.getDate());
			//파일추가
			pstmt.setString(7, boardDTO.getFile());
			
			//4 실행 
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbClose();
		}
	}//insertBoard()
	
	public int getBoardCount() {
		int count = 0;
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql select count(*) from board
			String sql = "select count(*) from board;";
			pstmt=con.prepareStatement(sql);
			//4 실행 => 결과저장
			rs = pstmt.executeQuery();
			//5 결과 행접근 => 열접근 => count변수 저장
			if(rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbClose();
		}
		return count;
	}//getBoardCount()
	
	public BoardDTO getBoard(int num) {
		BoardDTO boardDTO = null;
		try {
			//1,2 디비연결
			con = getConnection();
			//3 sql select * from board where num = ?
			String sql="select * from board where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4 실행 => 결과 저장
			rs = pstmt.executeQuery();
			//5 결과 행접근 => boardDTO 객체생성 
			//        => set메서드 호출 => 열접근 데이터 저장
			if(rs.next()) {
				boardDTO = new BoardDTO();
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				//첨부파일
				boardDTO.setFile(rs.getString("file"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbClose();
		}
		return boardDTO;
	}//getBoard
	
	public void updateBoard(BoardDTO boardDTO) {
		try {
			//1,2 디비연결
			con = getConnection();
			// 3 sql update
			String sql="update board set subject=?, content=? where num=? ";
			pstmt = con.prepareStatement(sql);			
			pstmt.setString(1, boardDTO.getSubject());
			pstmt.setString(2, boardDTO.getContent());
			pstmt.setInt(3, boardDTO.getNum());
			// 4 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
	}

}//클래스
