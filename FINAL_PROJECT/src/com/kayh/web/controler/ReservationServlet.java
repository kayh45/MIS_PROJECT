package com.kayh.web.controler;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kayh.web.bean.ResvBean;

/**
 * Servlet implementation class ReservationServlet
 */
@WebServlet("/Resv.do")
public class ReservationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ReservationServlet() {
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

		if (action.equals("EMPL")) {// �����������Ʈ

			// ��������������ʱ�ȭ
			ResvBean.getInstance().init(request);

			String srch_keyword = request.getParameter("srch_keyword") == null ? ""
					: new String(request.getParameter("srch_keyword").getBytes("8859_1"), "EUC-KR");
			// View�κ���������Attribute ����
			request.setAttribute("srch_type", request.getParameter("srch_type"));
			request.setAttribute("srch_keyword", srch_keyword);
			request.setAttribute("resvList", ResvBean.getInstance().getResvList());
			request.setAttribute("startPage", ResvBean.getInstance().getStartPage());
			request.setAttribute("endPage", ResvBean.getInstance().getEndPage());
			request.setAttribute("pageCnt", ResvBean.getInstance().getPageCnt());
			request.setAttribute("cpage", ResvBean.getInstance().getPage());
			request.setAttribute("totalArticle", ResvBean.getInstance().getTotalArticle());
			request.setAttribute("virtual_no", ResvBean.getInstance().getVirtualNum());

			response.setCharacterEncoding("EUC-KR");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/banq/banqlist.jsp");
			dispatcher.forward(request, response);

		} else if (action.equals("EMPCR")) {// ���� ���� ����������̵�
			response.setCharacterEncoding("EUC-KR");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/banq/banqwrite.jsp");
			dispatcher.forward(request, response);


		} else if (action.equals("EMPC")) {// ���� ���� ���
			int res = ResvBean.getInstance().createEmployee(request);
			if (res > 0) {
				response.setCharacterEncoding("EUC-KR");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/Resv.do?act=EMPL");
				dispatcher.forward(request, response);

			} else {
				response.setCharacterEncoding("EUC-KR");
				PrintWriter out = response.getWriter();
				out.print("<script>alert('����������Ͽ������Ͽ����ϴ�. ����Ȯ�κ�Ź�帳�ϴ�.'); history.go(-1);</script>");
			}
		} else if (action.equals("EMPR")) {// �������� �󼼺���

			int cpage = request.getParameter("page") == null ? 1 : Integer.valueOf(request.getParameter("page"));

			request.setAttribute("cpage", cpage);
			request.setAttribute("srch_type", request.getParameter("srch_type"));
			request.setAttribute("srch_keyword", request.getParameter("srch_keyword"));
			request.setAttribute("resvInfo", ResvBean.getInstance().getResvInfo(request.getParameter("NO")));

			response.setCharacterEncoding("EUC-KR");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/banq/banqview.jsp");
			dispatcher.forward(request, response);
		} else if (action.equals("EMPUR")) {// ������ ���� ����+ ���� ���� �����������̵�
			request.setAttribute("resvInfo", ResvBean.getInstance().getResvInfo(request.getParameter("NO")));
			response.setCharacterEncoding("EUC-KR");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/banq/banqmodify.jsp");
			dispatcher.forward(request, response);

		} else if (action.equals("EMPU")) {// ���� ���� ����
			// ��������������ó��
			int res = ResvBean.getInstance().modifyResv(request);

			if (res > 0) { // �����ϰ��1
				request.setAttribute("resvInfo", ResvBean.getInstance().getResvInfo(request.getParameter("NO")));
				response.setCharacterEncoding("EUC-KR");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/banq/banqview.jsp");
				dispatcher.forward(request, response);

			} else {
				response.setCharacterEncoding("EUC-KR");
				PrintWriter out = response.getWriter();
				out.print("<script>alert('�������������������Ͽ����ϴ�. ����Ȯ�κ�Ź�帳�ϴ�.'); history.go(-1);</script>");
			}
		} else if (action.equals("EMPD")) {// ���� ��������
			// ��������������ó��
			int res = ResvBean.getInstance().deleteResv(request.getParameter("NO"));
			if (res > 0) { // �����ϰ��1
				response.setCharacterEncoding("EUC-KR");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/Resv.do?act=EMPL");
				dispatcher.forward(request, response);
			} else {
				response.setCharacterEncoding("EUC-KR");
				PrintWriter out = response.getWriter();
				out.print("<script>alert('�������������������Ͽ����ϴ�. ����Ȯ�κ�Ź�帳�ϴ�.'); history.go(-1);</script>");
			}
		}
	}
}