package com.kayh.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.kayh.web.model.Reservation;

public class ResvDao extends CommonDao {

	private static ResvDao instance;

	public static ResvDao getInstance() {
		if (instance == null) {
			instance = new ResvDao();
		}
		return instance;
	}

	public Reservation getResvDetailInfo(String no) {

		Reservation resv = new Reservation();

		Connection conn = getConnection();

		ResultSet rs = null; // 조회결과값
		PreparedStatement st;

		try {
			st = conn.prepareStatement("SELECT * FROM BANQUET WHERE RESV_NO=? ");
			st.setString(1, no);
			rs = st.executeQuery(); // 쿼리문실행

			if (rs.next()) {
				resv.setResvNo(rs.getString("RESV_NO"));
				resv.setCostName(rs.getString("COST_NAME"));
				resv.setCostHp(rs.getString("COST_HP"));
				resv.setResvDate(rs.getString("RESV_DATE"));
				resv.setResvRoom(rs.getString("RESV_ROOM"));
				resv.setResvTime(rs.getString("RESV_TIME"));
				resv.setResvAmnt(rs.getString("RESV_AMNT"));
			}

			dbClose();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resv;
	}

	public ArrayList<Reservation> getResvList(int cpp, int page, String srch_type, String srch_keyword) {
		ArrayList<Reservation> resvlist = new ArrayList<Reservation>();
		Connection conn = getConnection();
		ResultSet rs = null; // 조회결과값
		PreparedStatement st;

		System.out.println("CPP: " + cpp);
		System.out.println("page: " + page);

		String sql = "SELECT * FROM (SELECT t1.*, ceil(rownum/?) as page FROM "
				+ "(SELECT RESV_NO, COST_NAME, RESV_DATE,"
				+ "RESV_TIME, RESV_ROOM FROM BANQUET";
		if (srch_keyword != null && !srch_keyword.equals("")) {
			if (srch_type.equals("1")) {// 부서
				sql += " WHERE RESV_NO ='" + srch_keyword + "'";
			} else if (srch_type.equals("2")) {// 직급
				sql += " WHERE COST_NAME ='" + srch_keyword + "'";
			} 
		}
		sql += " ORDER BY TO_NUMBER(RESV_NO) DESC) t1) WHERE page = ?";
		try {
			System.out.println(sql);
			st = conn.prepareStatement(sql);
			st.setInt(1, cpp);
			st.setInt(2, page);
			rs = st.executeQuery(); // 쿼리문실행

			while (rs.next()) {
				Reservation resv = new Reservation();
 
				resv.setResvNo(rs.getString("RESV_NO"));
				resv.setCostName(rs.getString("COST_NAME"));
				resv.setResvDate(rs.getString("RESV_DATE"));
				resv.setResvRoom(rs.getString("RESV_ROOM"));
				resv.setResvTime(rs.getString("RESV_TIME"));
				resvlist.add(resv);
			}
			System.out.println("리스트 크기: " + resvlist.size());
			dbClose();
		} catch (SQLException e) {
			// TODOAuto-generated catch block
			e.printStackTrace();
		}
		return resvlist;
	}

	public int getResvCnt() {
		int cnt = 0;
		Connection conn = getConnection();
		ResultSet rs = null; // 조회결과값
		PreparedStatement st;
		try {
			st = conn.prepareStatement("SELECT COUNT(*) AS CNT FROM BANQUET");
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

	public int createResv(Reservation resv) {
		int res = 0;
		Connection conn = getConnection();
		PreparedStatement st;
		String sql = "INSERT INTO BANQUET ( RESV_NO, COST_NAME, COST_HP, RESV_DATE, RESV_ROOM, "
				+ "RESV_TIME, RESV_AMNT)" + "VALUES( RESV_SEQ.nextval, ?,?,?,?,?,?)";
		try {
			st = conn.prepareStatement(sql);
			st.setString(1, resv.getCostName());
			st.setString(2, resv.getCostHp());
			st.setString(3, resv.getResvDate());
			st.setString(4, resv.getResvRoom());
			st.setString(5, resv.getResvTime());
			st.setString(6, resv.getResvAmnt());

			res = st.executeUpdate(); // 쿼리문실행
			// res=0은update 실패, 1은성공

			dbClose();
		} catch (SQLException e) {
			res = 0;
			e.printStackTrace();
		}
		return res;
	}

	public int updateResv(Reservation resv) {
		int res = 0;
		Connection conn = getConnection();
		PreparedStatement st;
		String sql = "UPDATE BANQUET SET COST_NAME=?, COST_HP=?, RESV_DATE=?, RESV_ROOM=?, "
				+ "RESV_TIME=?, RESV_AMNT=?" + "WHERE EMP_NO=? ";
		try {
			st = conn.prepareStatement(sql);
			st.setString(1, resv.getCostName());
			st.setString(2, resv.getCostHp());
			st.setString(3, resv.getResvDate());
			st.setString(4, resv.getResvRoom());
			st.setString(5, resv.getResvTime());
			st.setString(6, resv.getResvAmnt());
			st.setString(7, resv.getResvNo());

			res = st.executeUpdate(); // 쿼리문실행//res=0은update 실패, 1은성공
			dbClose();
		} catch (SQLException e) {
			res = 0;
			e.printStackTrace();
		}
		return res;
	}

	public int deleteResv(String no) {
		int res = 0;
		Connection conn = getConnection();
		PreparedStatement st;

		try {
			st = conn.prepareStatement("DELETE FROM BANQUET WHERE RESV_NO=? ");
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