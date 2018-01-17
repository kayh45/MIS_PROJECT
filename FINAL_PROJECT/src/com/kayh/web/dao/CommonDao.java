package com.kayh.web.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class CommonDao {
	
	private Connection conn = null;
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "kayh";
	String pass = "1111";
	
	private void init() {
		url = "jdbc:oracle:thin:@localhost:1521:xe";
		user = "kayh";
		pass = "1111";
		
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			System.out.println("init己傍");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public Connection getConnection(){
		try {
			init();
			conn = DriverManager.getConnection(url, user, pass);
			System.out.println("立加 己傍");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(url + " " + user + " " + pass);
			System.out.println("立加 角菩");
			e.printStackTrace();
		}
		return conn;
	}
	
	public void dbClose() {
		try {
			conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
}
