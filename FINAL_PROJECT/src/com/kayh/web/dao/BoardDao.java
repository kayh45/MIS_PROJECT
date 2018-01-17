package com.kayh.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.kayh.web.model.Board;

public class BoardDao extends CommonDao {

	private static BoardDao instance;

	public static BoardDao getInstance() {
		if (instance == null) {
			instance = new BoardDao();
		}
		return instance;
	}

	public Board getBoardDetailInfo(String no) {

		Board board = new Board();

		Connection conn = getConnection();

		ResultSet rs = null; // 조회결과값
		PreparedStatement st;

		try {
			st = conn.prepareStatement("SELECT * FROM BOARD WHERE BD_NO=? ");
			st.setString(1, no);
			rs = st.executeQuery(); // 쿼리문실행

			if (rs.next()) {
				board.setBoardNo(rs.getString("BD_NO"));
				board.setBoardSub(rs.getString("BD_SUB"));
				board.setBoardCont(rs.getString("BD_CONT"));
				board.setBoardDate(rs.getString("BD_DATE"));
				board.setBoardWrt(rs.getString("BD_WRT"));
				board.setBoardWrtNm(rs.getString("BD_WRT_NM"));
			}

			dbClose();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return board;
	}

	public ArrayList<Board> getBoardList(int cpp, int page, String srch_type, String srch_keyword) {
		ArrayList<Board> boardlist = new ArrayList<Board>();
		Connection conn = getConnection();
		ResultSet rs = null; // 조회결과값
		PreparedStatement st;

		System.out.println("CPP: " + cpp);
		System.out.println("page: " + page);

		String sql = "SELECT * FROM (SELECT t1.*, ceil(rownum/?) as page FROM "
				+ "(SELECT BD_NO, BD_SUB, BD_DATE,"
				+ "BD_WRT, BD_WRT_NM , BD_CONT FROM BOARD";
		if (srch_keyword != null && !srch_keyword.equals("")) {
			if (srch_type.equals("1")) {// 부서
				sql += " WHERE BD_WRT_NM ='" + srch_keyword + "'";
			} else if (srch_type.equals("2")) {// 직급
				sql += " WHERE BD_SUB ='" + srch_keyword + "'";
			} 
		}
		sql += " ORDER BY TO_NUMBER(BD_NO) DESC) t1) WHERE page = ?";
		
		try {
			System.out.println(sql);
			st = conn.prepareStatement(sql);
			st.setInt(1, cpp);
			st.setInt(2, page);
			rs = st.executeQuery(); // 쿼리문실행

			while (rs.next()) {
				Board board = new Board();
 
				board.setBoardNo(rs.getString("BD_NO"));
				board.setBoardSub(rs.getString("BD_SUB"));
				board.setBoardCont(rs.getString("BD_CONT"));
				board.setBoardDate(rs.getString("BD_DATE"));
				board.setBoardWrt(rs.getString("BD_WRT"));
				board.setBoardWrt(rs.getString("BD_WRT_NM"));
				boardlist.add(board);
			}
			
			System.out.println("리스트 크기: " + boardlist.size());
			dbClose();
		} catch (SQLException e) {
			// TODOAuto-generated catch block
			e.printStackTrace();
		}
		return boardlist;
	}

	public int getBoardCnt() {
		int cnt = 0;
		Connection conn = getConnection();
		ResultSet rs = null; // 조회결과값
		PreparedStatement st;
		try {
			st = conn.prepareStatement("SELECT COUNT(*) AS CNT FROM BOARD");
			rs = st.executeQuery(); // 쿼리문실행
			if (rs.next()) {
				cnt = rs.getInt("CNT");
				System.out.println("cnt" + cnt);
			}
			dbClose();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public int createBoard(Board board) {
		int res = 0;
		Connection conn = getConnection();
		PreparedStatement st;
		String sql = "INSERT INTO BOARD ( BD_NO, BD_SUB, BD_CONT, BD_DATE, BD_WRT, BD_WRT_NM) "
				+  "VALUES( BD_SEQ.nextval, ?,?,?,?,?)";
		System.out.println(sql);
		try {
			st = conn.prepareStatement(sql);
			st.setString(1, board.getBoardSub());
			st.setString(2, board.getBoardCont());
			st.setString(3, board.getBoardDate());
			st.setString(4, board.getBoardWrt());
			st.setString(5, board.getBoardWrtNm());
			

			res = st.executeUpdate(); // 쿼리문실행
			// res=0은update 실패, 1은성공

			dbClose();
		} catch (SQLException e) {
			res = 0;
			e.printStackTrace();
		}
		return res;
	}

	public int updateBoard(Board board) {
		int res = 0;
		Connection conn = getConnection();
		PreparedStatement st;
		String sql = "UPDATE BOARD SET BD_SUB=?, BD_CONT=?, BD_DATE=?, BD_WRT=? "
				+ "WHERE BD_NO=? ";
		try {
			st = conn.prepareStatement(sql);
			st.setString(1, board.getBoardSub());
			st.setString(2, board.getBoardCont());
			st.setString(3, board.getBoardDate());
			st.setString(4, board.getBoardWrt());
			st.setString(5, board.getBoardNo());
			
			System.out.println("정보" + board.getBoardNo());

			res = st.executeUpdate(); // 쿼리문실행//res=0은update 실패, 1은성공
			dbClose();
		} catch (SQLException e) {
			res = 0;
			e.printStackTrace();
		}
		return res;
	}

	public int deleteBoard(String no) {
		int res = 0;
		Connection conn = getConnection();
		PreparedStatement st;

		try {
			st = conn.prepareStatement("DELETE FROM BOARD WHERE BD_NO=? ");
			st.setString(1, no);
			res = st.executeUpdate();
			dbClose();
		} catch (SQLException e) {
			// TODOAuto-generated catch block
			res = 0;
			e.printStackTrace();
		}
		return res;
	}

}