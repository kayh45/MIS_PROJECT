package com.kayh.web.bean;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.kayh.web.dao.BoardDao;
import com.kayh.web.model.Board;

public class BoardBean {
	private static BoardBean instance;

	public static BoardBean getInstance() {
		if (instance == null) {
			instance = new BoardBean();
		}
		return instance;
	}

	int virtual_no;// ����۹�ȣ
	int start_page;// ����¡ù��°������
	int end_page;// ����¡������������
	int page_cnt;// ��������ü��
	int page;// ����������
	int totalArticle;// ��ü�Խù���

	String srch_type;
	String srch_keyword;

	ArrayList<Board> boardList = new ArrayList<Board>();

	public void init(HttpServletRequest req) throws UnsupportedEncodingException {

		int cpp = 10;// ����������ǥ�ðԽù���
		page = req.getParameter("page") == null ? 1 : Integer.valueOf(req.getParameter("page"));
		

		srch_type = req.getParameter("srch_type") == null ? "" : req.getParameter("srch_type");
		srch_keyword = req.getParameter("srch_keyword") == null ? "" : new String(req.getParameter("srch_keyword").getBytes("8859_1"), "EUC-KR");

		boardList = BoardDao.getInstance().getBoardList(cpp, page, srch_type, srch_keyword);
		// totalArticleSize ��������Query ����
		totalArticle = BoardDao.getInstance().getBoardCnt();

		page_cnt = (int) Math.ceil((float) totalArticle / cpp);

		if (page > page_cnt) {
			page = page_cnt;
		}
		virtual_no = totalArticle - (page - 1) * cpp + 1;

		start_page = (int) ((page - 1) / 10) * 10 + 1;

		end_page = start_page + 9;

		if (end_page > page_cnt) {
			end_page = page_cnt;
		}

		System.out.println("totalArticle: " + totalArticle);
		System.out.println("page_cnt: " + page_cnt);
		System.out.println(boardList.size());
	}

	public Board getBoardInfo(String no) {
		Board board = BoardDao.getInstance().getBoardDetailInfo(no);
		return board;
	}

	public int modifyBoard(HttpServletRequest req) {
		int res = 0;

		// ���޹��� parameter ������ Employee ��ü ����
		Board board = new Board();
		board.setBoardNo(req.getParameter("boardNo"));
		board.setBoardSub(req.getParameter("boardSub"));
		board.setBoardCont(req.getParameter("boardCont"));
		board.setBoardDate(req.getParameter("boardDate"));
		board.setBoardWrt(req.getParameter("boardWrt"));

		System.out.print(board.getBoardNo());

		// ������ ��ü�� DAO ����
		res = BoardDao.getInstance().updateBoard(board);

		// ������ ��� �� ����
		return res;
	}

	public int createBoard(HttpServletRequest req) {
		int res = 0;
		// ���޹���parameter ������Employee ��ü����
		Board board = new Board();
		
		board.setBoardNo(req.getParameter("boardNo"));
		board.setBoardSub(req.getParameter("boardSub"));
		board.setBoardCont(req.getParameter("boardCont"));
		board.setBoardDate(req.getParameter("boardDate"));
		board.setBoardWrt(req.getParameter("boardWrt"));
		board.setBoardWrtNm(req.getParameter("boardWrtNm"));
		
		res = BoardDao.getInstance().createBoard(board);
		// �������������
		return res;
	}
	public int deleteBoard(String no){
		int res=0;
		res= BoardDao.getInstance().deleteBoard(no);
		return res;
		}
	
	public int getTotalArticle() { return totalArticle; }
	public boolean isFirstPage() { return page == 1? true : false; }
	public boolean isEndPage() { return page == page_cnt ? true : false; }
	public boolean isNowPage(int p) { return page == p ? true : false; }
	public boolean isPrevPage() { return end_page < 11? true : false; }
	public boolean isNextPage() { return end_page == page_cnt ? true : false; }
	public int getStartPage() { return start_page; }
	public int getEndPage() { return end_page; }
	public int getPageCnt() { return page_cnt; }
	public int getPage() { return page; }
	public boolean isList() { return totalArticle != 0 ? true : false; }
	public int getVirtualNum() { return --virtual_no; }
	
	public ArrayList<Board> getBoardList() {
		return boardList;
}
	public void setBoardList(ArrayList<Board> boardList) {
		this.boardList = boardList;
	}
}