package com.kayh.web.controler;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kayh.web.bean.EmpBean;

/**
 * Servlet implementation class EmployeeServlet
 */
@WebServlet("/emp.do")

public class EmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public EmployeeServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("EUC-KR");
		process(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("EUC-KR");
		process(request, response);
	}

	public void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("act");

		if (action.equals("EMPL")) {// 사원관리리스트

			// 사원관리데이터초기화
			EmpBean.getInstance().init(request);

			String srch_keyword = request.getParameter("srch_keyword") == null ? ""
					: new String(request.getParameter("srch_keyword").getBytes("8859_1"), "EUC-KR");
			// View로보낼데이터Attribute 설정
			request.setAttribute("srch_type", request.getParameter("srch_type"));
			request.setAttribute("srch_keyword", srch_keyword);
			request.setAttribute("empList", EmpBean.getInstance().getEmpList());
			request.setAttribute("startPage", EmpBean.getInstance().getStartPage());
			request.setAttribute("endPage", EmpBean.getInstance().getEndPage());
			request.setAttribute("pageCnt", EmpBean.getInstance().getPageCnt());
			request.setAttribute("cpage", EmpBean.getInstance().getPage());
			request.setAttribute("totalArticle", EmpBean.getInstance().getTotalArticle());
			request.setAttribute("virtual_no", EmpBean.getInstance().getVirtualNum());

			response.setCharacterEncoding("EUC-KR");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/emp/emplist.jsp");
			dispatcher.forward(request, response);

		} else if (action.equals("EMPCR")) {// 사원등록페이지이동
			response.setCharacterEncoding("EUC-KR");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/emp/empwrite.jsp");
			dispatcher.forward(request, response);


		} else if (action.equals("EMPC")) {// 사원등록
			int res = EmpBean.getInstance().createEmployee(request);
			if (res > 0) {
				response.setCharacterEncoding("EUC-KR");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/emp.do?act=EMPL");
				dispatcher.forward(request, response);

			} else {
				response.setCharacterEncoding("EUC-KR");
				PrintWriter out = response.getWriter();
				out.print("<script>alert('사원정보등록에실패하였습니다. 정보확인부탁드립니다.'); history.go(-1);</script>");
			}
		} else if (action.equals("EMPR")) {// 사원상세보기

			int cpage = request.getParameter("page") == null ? 1 : Integer.valueOf(request.getParameter("page"));

			request.setAttribute("cpage", cpage);
			request.setAttribute("srch_type", request.getParameter("srch_type"));
			request.setAttribute("srch_keyword", request.getParameter("srch_keyword"));
			request.setAttribute("empInfo", EmpBean.getInstance().getEmpInfo(request.getParameter("NO")));

			response.setCharacterEncoding("EUC-KR");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/emp/empview.jsp");
			dispatcher.forward(request, response);
		} else if (action.equals("EMPUR")) {// 수정할사원정보+ 사원수정페이지이동
			request.setAttribute("empInfo", EmpBean.getInstance().getEmpInfo(request.getParameter("NO")));
			response.setCharacterEncoding("EUC-KR");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/emp/empmodify.jsp");
			dispatcher.forward(request, response);

		} else if (action.equals("EMPU")) {// 사원수정
			// 정보수정데이터처리
			int res = EmpBean.getInstance().modifyEmployee(request);

			if (res > 0) { // 성공일경우1
				request.setAttribute("empInfo", EmpBean.getInstance().getEmpInfo(request.getParameter("NO")));
				response.setCharacterEncoding("EUC-KR");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/emp/empview.jsp");
				dispatcher.forward(request, response);

			} else {
				response.setCharacterEncoding("EUC-KR");
				PrintWriter out = response.getWriter();
				out.print("<script>alert('사원정보수정에실패하였습니다. 정보확인부탁드립니다.'); history.go(-1);</script>");
			}
		} else if (action.equals("EMPD")) {// 사원삭제
			// 정보수정데이터처리
			int res = EmpBean.getInstance().deleteEmployee(request.getParameter("NO"));
			if (res > 0) { // 성공일경우1
				response.setCharacterEncoding("EUC-KR");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/emp.do?act=EMPL");
				dispatcher.forward(request, response);
			} else {
				response.setCharacterEncoding("EUC-KR");
				PrintWriter out = response.getWriter();
				out.print("<script>alert('사원정보삭제에실패하였습니다. 정보확인부탁드립니다.'); history.go(-1);</script>");
			}
		}
	}
}
