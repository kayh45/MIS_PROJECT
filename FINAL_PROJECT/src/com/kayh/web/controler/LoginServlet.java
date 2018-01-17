package com.kayh.web.controler;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kayh.web.bean.LoginBean;
import com.kayh.web.model.Employee;

/**
 * Servlet implementation class LoginServelet
 */
@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		process(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		process(request, response);
	}
	private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String action = request.getParameter("act") == null ? "" : request.getParameter("act");
		
		if (action.equals("MAIN")) { // 메인화면 세팅
			
			response.setCharacterEncoding("EUC-KR");
			RequestDispatcher dispatcher = request.getRequestDispatcher("main.jsp");
			dispatcher.forward(request, response);
			
		} else if (action.equals("LOGOUT")) {
			HttpSession session = request.getSession();
			session.removeAttribute((String) session.getAttribute("userNo"));
			session.removeAttribute((String) session.getAttribute("userName"));
			session.removeAttribute((String) session.getAttribute("userAuth"));
			
			session.invalidate();
			
			System.out.println("-------------------------------LOGOUT");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
		} else {
			// 1.
			String user = request.getParameter("user"); //
			String pass = request.getParameter("pass"); //
			//
			System.out.println(user); //
			System.out.println(pass); //
			// 2.
			if ((user != null && user.trim().length() > 0) && (pass != null && pass.trim().length() > 0)) {
				// 3.
				LoginBean login = LoginBean.getInstance();
				boolean grade = false;
				grade = login.loginCheck(user, pass);
				System.out.println(grade);
				if (grade) {
					Employee emp = LoginBean.getInstance().getEmpInfo(user);
					HttpSession session = request.getSession(true);
					session.setAttribute("userNo", emp.getEmpNo());
					session.setAttribute("userName", emp.getEmpName());
					session.setAttribute("userDept", emp.getEmpDept());
					session.setAttribute("userAuth", emp.getEmpAuth());
					System.out.println(emp.getEmpAuth());
					response.setCharacterEncoding("EUC-KR");
					
					RequestDispatcher dispatcher = request.getRequestDispatcher("main.jsp");
					dispatcher.forward(request, response);
					
				} else {
					
					response.setCharacterEncoding("EUC-KR");
					PrintWriter out = response.getWriter();
					out.print("<script>alert('아이디 및 암호를 확인하시기 바랍니다.'); history.go(-1); </script>");
				}
			}
		}
	}
}
