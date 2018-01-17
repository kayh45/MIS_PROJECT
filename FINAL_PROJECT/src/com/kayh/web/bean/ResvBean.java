package com.kayh.web.bean;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.kayh.web.dao.ResvDao;
import com.kayh.web.model.Reservation;

public class ResvBean {
	private static ResvBean instance;

	public static ResvBean getInstance() {
		if (instance == null) {
			instance = new ResvBean();
		}
		return instance;
	}

	int virtual_no;// 가상글번호
	int start_page;// 페이징첫번째페이지
	int end_page;// 페이징마지막페이지
	int page_cnt;// 페이지전체수
	int page;// 현재페이지
	int totalArticle;// 전체게시물수

	String srch_type;
	String srch_keyword;

	ArrayList<Reservation> resvList = new ArrayList<Reservation>();

	public void init(HttpServletRequest req) throws UnsupportedEncodingException {

		int cpp = 10;// 한페이지당표시게시물수
		page = req.getParameter("page") == null ? 1 : Integer.valueOf(req.getParameter("page"));
		

		srch_type = req.getParameter("srch_type") == null ? "" : req.getParameter("srch_type");
		srch_keyword = req.getParameter("srch_keyword") == null ? "" : new String(req.getParameter("srch_keyword").getBytes("8859_1"), "EUC-KR");

		resvList = ResvDao.getInstance().getResvList(cpp, page, srch_type, srch_keyword);
		// totalArticleSize 가져오는Query 실행
		totalArticle = ResvDao.getInstance().getResvCnt();

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

		System.out.print("totalArticle: " + totalArticle);
		System.out.print("page_cnt: " + page_cnt);
		System.out.print(resvList.size());
	}

	public Reservation getResvInfo(String no) {
		Reservation resv = ResvDao.getInstance().getResvDetailInfo(no);
		return resv;
	}

	public int modifyResv(HttpServletRequest req) {
		int res = 0;

		// 전달받은 parameter 값으로 Employee 객체 생성
		Reservation resv = new Reservation();
		resv.setResvNo(req.getParameter("resvNo"));
		resv.setCostName(req.getParameter("costName"));
		resv.setCostHp(req.getParameter("costHp"));
		resv.setResvDate(req.getParameter("resvDate"));
		resv.setResvRoom(req.getParameter("resvRoom"));
		resv.setResvTime(req.getParameter("resvTime"));
		resv.setResvAmnt(req.getParameter("resvAmnt"));

		System.out.print(resv.getResvNo());

		// 생성된 객체를 DAO 전달
		res = ResvDao.getInstance().updateResv(resv);

		// 수정된 결과 값 리턴
		return res;
	}

	public int createEmployee(HttpServletRequest req) {
		int res = 0;
		// 전달받은parameter 값으로Employee 객체생성
		Reservation resv = new Reservation();
		
		resv.setResvNo(req.getParameter("resvNo"));
		resv.setCostName(req.getParameter("costName"));
		resv.setCostHp(req.getParameter("costHp"));
		resv.setResvDate(req.getParameter("resvDate"));
		resv.setResvRoom(req.getParameter("resvRoom"));
		resv.setResvTime(req.getParameter("resvTime"));
		resv.setResvAmnt(req.getParameter("resvAmnt"));
		
		res = ResvDao.getInstance().createResv(resv);
		// 수정결과값리턴
		return res;
	}
	public int deleteResv(String no){
		int res=0;
		res= ResvDao.getInstance().deleteResv(no);
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
	
	public ArrayList<Reservation> getResvList() {
		return resvList;
}
	public void setResvList(ArrayList<Reservation> resvList) {
		this.resvList = resvList;
	}
}