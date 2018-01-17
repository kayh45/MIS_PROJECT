package com.kayh.web.controler;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kayh.web.bean.BoardBean;

/**
 * Servlet implementation class BoardServlet
 */
@WebServlet("/board.do")
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public BoardServlet() {
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
			BoardBean.getInstance().init(request);

			String srch_keyword = request.getParameter("srch_keyword") == null ? ""
					: new String(request.getParameter("srch_keyword").getBytes("8859_1"), "EUC-KR");
			// View로보낼데이터Attribute 설정
			request.setAttribute("srch_type", request.getParameter("srch_type"));
			request.setAttribute("srch_keyword", srch_keyword);
			request.setAttribute("boardList", BoardBean.getInstance().getBoardList());
			request.setAttribute("startPage", BoardBean.getInstance().getStartPage());
			request.setAttribute("endPage", BoardBean.getInstance().getEndPage());
			request.setAttribute("pageCnt", BoardBean.getInstance().getPageCnt());
			request.setAttribute("cpage", BoardBean.getInstance().getPage());
			request.setAttribute("totalArticle", BoardBean.getInstance().getTotalArticle());
			request.setAttribute("virtual_no", BoardBean.getInstance().getVirtualNum());

			response.setCharacterEncoding("EUC-KR");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/board/boardlist.jsp");
			dispatcher.forward(request, response);

		} else if (action.equals("EMPCR")) {// 예약 정보 등록페이지이동
			response.setCharacterEncoding("EUC-KR");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/board/boardwrite.jsp");
			dispatcher.forward(request, response);


		} else if (action.equals("EMPC")) {// 예약 정보 등록
			int res = BoardBean.getInstance().createBoard(request);
			if (res > 0) {
				response.setCharacterEncoding("EUC-KR");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/board.do?act=EMPL");
				dispatcher.forward(request, response);

			} else {
				response.setCharacterEncoding("EUC-KR");
				PrintWriter out = response.getWriter();
				out.print("<script>alert('게시물 등록에실패하였습니다. 정보확인부탁드립니다.'); history.go(-1);</script>");
			}
		} else if (action.equals("EMPR")) {// 예약정보 상세보기

			int cpage = request.getParameter("page") == null ? 1 : Integer.valueOf(request.getParameter("page"));

			request.setAttribute("cpage", cpage);
			request.setAttribute("srch_type", request.getParameter("srch_type"));
			request.setAttribute("srch_keyword", request.getParameter("srch_keyword"));
			request.setAttribute("boardInfo", BoardBean.getInstance().getBoardInfo(request.getParameter("NO")));

			response.setCharacterEncoding("EUC-KR");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/board/boardview.jsp");
			dispatcher.forward(request, response);
		} else if (action.equals("EMPUR")) {// 수정할 예약 정보+ 예약 정보 수정페이지이동
			request.setAttribute("boardInfo", BoardBean.getInstance().getBoardInfo(request.getParameter("NO")));
			response.setCharacterEncoding("EUC-KR");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/board/boardmodify.jsp");
			dispatcher.forward(request, response);

		} else if (action.equals("EMPU")) {// 예약 정보 수정
			// 정보수정데이터처리
			int res = BoardBean.getInstance().modifyBoard(request);

			if (res > 0) { // 성공일경우1
				request.setAttribute("boardInfo", BoardBean.getInstance().getBoardInfo(request.getParameter("NO")));
				response.setCharacterEncoding("EUC-KR");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/board.do?act=EMPL");
				dispatcher.forward(request, response);

			} else {
				response.setCharacterEncoding("EUC-KR");
				PrintWriter out = response.getWriter();
				out.print("<script>alert('게시물 수정에실패하였습니다. 정보확인부탁드립니다.'); history.go(-1);</script>");
			}
		} else if (action.equals("EMPD")) {// 예약 정보삭제
			// 정보수정데이터처리
			int res = BoardBean.getInstance().deleteBoard(request.getParameter("NO"));
			if (res > 0) { // 성공일경우1
				response.setCharacterEncoding("EUC-KR");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/board.do?act=EMPL");
				dispatcher.forward(request, response);
			} else {
				response.setCharacterEncoding("EUC-KR");
				PrintWriter out = response.getWriter();
				out.print("<script>alert('게시물 삭제에실패하였습니다. 정보확인부탁드립니다.'); history.go(-1);</script>");
			}
		}
	}
}