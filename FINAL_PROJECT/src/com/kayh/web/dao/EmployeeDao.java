package com.kayh.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.kayh.web.model.Employee;

public class EmployeeDao extends CommonDao {

	private static EmployeeDao instance;

	public static EmployeeDao getInstance() {
		if (instance == null) {
			instance = new EmployeeDao();
		}
		return instance;
	}

	public Employee getEmpDetailInfo(String no) {

		Employee emp = new Employee();

		Connection conn = getConnection();

		ResultSet rs = null; // 조회결과값
		PreparedStatement st;

		try {
			st = conn.prepareStatement("SELECT * FROM EMPLOYEE WHERE EMP_NO=? ");
			st.setString(1, no);
			rs = st.executeQuery(); // 쿼리문실행

			if (rs.next()) {
				emp.setEmpNo(rs.getString("EMP_NO"));
				emp.setEmpName(rs.getString("EMP_NAME"));
				emp.setEmpPosi(rs.getString("EMP_POSI"));
				emp.setEmpDept(rs.getString("EMP_DEPT"));
				emp.setEmpHp(rs.getString("EMP_HP"));
				emp.setEmpEmail(rs.getString("EMP_EMAIL"));
				emp.setEmpPw(rs.getString("EMP_PW"));
				emp.setEmpAuth(rs.getString("EMP_AUTH"));
				emp.setEmpID(rs.getString("EMP_ID"));
			}

			dbClose();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return emp;
	}

	public boolean loginCheck(String no, String pass) {
		boolean res = false;

		Connection conn = getConnection();

		ResultSet rs = null; // 조회 결과값
		PreparedStatement st;

		try {
			st = conn.prepareStatement("SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID =? AND EMP_PW =?");
			st.setString(1, no);
			st.setString(2, pass);
			rs = st.executeQuery();

			if (rs.next()) {
				res = true;
				return res;
			}

			dbClose();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

	public Employee getEmpInfo(String user) {
		Employee emp = new Employee();

		Connection conn = getConnection();

		ResultSet rs = null; // 조회 결과값
		PreparedStatement st;

		try {
			st = conn.prepareStatement("SELECT EMP_NAME, EMP_AUTH, EMP_DEPT, EMP_NO FROM EMPLOYEE WHERE EMP_ID = ? ");
			st.setString(1, user);
			rs = st.executeQuery(); // 쿼리문 실행

			if (rs.next()) {
				emp.setEmpName(rs.getString("EMP_NAME"));
				emp.setEmpAuth(rs.getString("EMP_AUTH"));
				emp.setEmpDept(rs.getString("EMP_DEPT"));
				emp.setEmpNo(rs.getString("EMP_NO"));
			}
			dbClose();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return emp;
	}

	public ArrayList<Employee> getEmpList(int cpp, int page, String srch_type, String srch_keyword) {
		ArrayList<Employee> emplist = new ArrayList<Employee>();
		Connection conn = getConnection();
		ResultSet rs = null; // 조회결과값
		PreparedStatement st;

		System.out.println("CPP: " + cpp);
		System.out.println("page: " + page);

		String sql = "SELECT * FROM (SELECT t1.*, ceil(rownum/?) as page FROM "
				+ "(SELECT EMP_NO, EMP_ID, EMP_NAME, EMP_POSI, "
				+ "DECODE(EMP_AUTH, 1, '관리자', '일반사용자')AS EMP_AUTH FROM EMPLOYEE";
		if (srch_keyword != null && !srch_keyword.equals("")) {
			if (srch_type.equals("1")) {// 부서
				sql += " WHERE EMP_ID ='" + srch_keyword + "'";
			} else if (srch_type.equals("2")) {// 직급
				sql += " WHERE EMP_POSI ='" + srch_keyword + "'";
			} else if (srch_type.equals("3")) {// 이름
				sql += " WHERE EMP_NAME ='" + srch_keyword + "'";
			} else {
				sql += " WHERE EMP_DEPT ='" + srch_keyword + "' OR EMP_POSI ='" + srch_keyword + "' OR EMP_NAME ='"
						+ srch_keyword + "'";
			}
		}
		sql += " ORDER BY TO_NUMBER(EMP_NO) DESC) t1) WHERE page = ?";
		try {
			System.out.println(sql);
			st = conn.prepareStatement(sql);
			st.setInt(1, cpp);
			st.setInt(2, page);
			rs = st.executeQuery(); // 쿼리문실행

			while (rs.next()) {
				Employee emp = new Employee();
				emp.setEmpNo(rs.getString("EMP_NO"));
				emp.setEmpName(rs.getString("EMP_NAME"));
				emp.setEmpPosi(rs.getString("EMP_POSI"));
				emp.setEmpID(rs.getString("EMP_ID"));
				emp.setEmpAuth(rs.getString("EMP_AUTH"));

				emplist.add(emp);
			}
			dbClose();
		} catch (SQLException e) {
			// TODOAuto-generated catch block
			e.printStackTrace();
		}
		return emplist;
	}

	public int getEmpCnt() {
		int cnt = 0;
		Connection conn = getConnection();
		ResultSet rs = null; // 조회결과값
		PreparedStatement st;
		try {
			st = conn.prepareStatement("SELECT COUNT(*) AS CNT FROM EMPLOYEE");
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

	public int createEmployee(Employee emp) {
		int res = 0;
		Connection conn = getConnection();
		PreparedStatement st;
		String sql = "INSERT INTO EMPLOYEE ( EMP_NO, EMP_NAME, EMP_POSI, EMP_DEPT, EMP_HP, "
				+ "EMP_EMAIL, EMP_PW, EMP_AUTH, EMP_ID)" + "VALUES( EMP_SEQ.nextval, ?,?,?,?,?,?,?,?)";
		try {
			st = conn.prepareStatement(sql);
			st.setString(1, emp.getEmpName());
			st.setString(2, emp.getEmpPosi());
			st.setString(3, emp.getEmpDept());
			st.setString(4, emp.getEmpHp());
			st.setString(5, emp.getEmpEmail());
			st.setString(6, emp.getEmpPw());
			st.setString(7, emp.getEmpAuth());
			st.setString(8, emp.getEmpID());

			res = st.executeUpdate(); // 쿼리문실행
			// res=0은update 실패, 1은성공

			dbClose();
		} catch (SQLException e) {
			res = 0;
			e.printStackTrace();
		}
		return res;
	}

	public int updateEmployee(Employee emp) {
		int res = 0;
		Connection conn = getConnection();
		PreparedStatement st;
		String sql = "UPDATE EMPLOYEE SET EMP_NAME=?, EMP_POSI=?, EMP_DEPT=?, EMP_HP=?, "
				+ "EMP_EMAIL=?, EMP_PW=?, EMP_AUTH=?, EMP_ID=?" + "WHERE EMP_NO=? ";
		try {
			st = conn.prepareStatement(sql);
			st.setString(1, emp.getEmpName());
			st.setString(2, emp.getEmpPosi());
			st.setString(3, emp.getEmpDept());
			st.setString(4, emp.getEmpHp());
			st.setString(5, emp.getEmpEmail());
			st.setString(6, emp.getEmpPw());
			st.setString(7, emp.getEmpAuth());
			st.setString(8, emp.getEmpID());
			st.setString(9, emp.getEmpNo());

			res = st.executeUpdate(); // 쿼리문실행//res=0은update 실패, 1은성공
			dbClose();
		} catch (SQLException e) {
			res = 0;
			e.printStackTrace();
		}
		return res;
	}

	public int deleteEmployee(String no) {
		int res = 0;
		Connection conn = getConnection();
		PreparedStatement st;

		try {
			st = conn.prepareStatement("DELETE FROM EMPLOYEE WHERE EMP_NO=? ");
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

	public boolean idCheck(String empID) { // 아이디 중복을 체크하는 메서드
		boolean isIn = false;
		Connection conn = getConnection();
		PreparedStatement st;
		ResultSet rs = null;

		try { 
			StringBuffer query = new StringBuffer();
			query.append("SELECT EMP_ID FROM EMPLOYEE WHERE EMP_ID = ?");
			st = conn.prepareStatement(query.toString());
			st.setString(1, empID);
			rs = st.executeQuery();

			if (rs.next()) isIn = true;

		} catch (SQLException e) {
			// TODOAuto-generated catch block
			e.printStackTrace();
		}
		return isIn;
	}	
}
