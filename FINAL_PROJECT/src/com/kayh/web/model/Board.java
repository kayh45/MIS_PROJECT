package com.kayh.web.model;

public class Board {

	private String boardNo;
	private String boardSub;
	private String boardCont;
	private String boardWrt;
	private String boardDate;
	private String boardWrtNm;
	
	public String getBoardWrtNm() {
		return boardWrtNm;
	}

	public void setBoardWrtNm(String boardWrtNm) {
		this.boardWrtNm = boardWrtNm;
	}

	public Board() {
	
		
	}
	
	public Board(String boardNo, String boardSub){
		this.boardNo = boardNo;
		this.boardSub = boardSub;
	}
	public String getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardSub() {
		return boardSub;
	}
	public void setBoardSub(String boardSub) {
		this.boardSub = boardSub;
	}
	public String getBoardCont() {
		return boardCont;
	}
	public void setBoardCont(String boardCont) {
		this.boardCont = boardCont;
	}
	public String getBoardWrt() {
		return boardWrt;
	}
	public void setBoardWrt(String boardWrt) {
		this.boardWrt = boardWrt;
	}
	public String getBoardDate() {
		return boardDate;
	}
	public void setBoardDate(String boardDate) {
		this.boardDate = boardDate;
	}


	
	
}
