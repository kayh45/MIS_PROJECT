package com.kayh.web.model;



public class Reservation {

	private String resvNo;
	private String costName;
	private String costHp;
	private String resvDate;
	private String resvRoom;
	private String resvTime;
	private String resvAmnt;
	
public Reservation() {
		
	}
	
	public Reservation(String resvNo, String costName){
		this.resvNo = resvNo;
		this.costName = costName;
	}
	
	public String getResvNo() {
		return resvNo;
	}
	public void setResvNo(String resvNo) {
		this.resvNo = resvNo;
	}
	public String getCostName() {
		return costName;
	}
	public void setCostName(String costName) {
		this.costName = costName;
	}
	public String getCostHp() {
		return costHp;
	}
	public void setCostHp(String costHp) {
		this.costHp = costHp;
	}
	public String getResvDate() {
		return resvDate;
	}
	public void setResvDate(String resvDate) {
		this.resvDate = resvDate;
	}
	public String getResvRoom() {
		return resvRoom;
	}
	public void setResvRoom(String resvRoom) {
		this.resvRoom = resvRoom;
	}
	public String getResvTime() {
		return resvTime;
	}
	public void setResvTime(String resvTime) {
		this.resvTime = resvTime;
	}
	public String getResvAmnt() {
		return resvAmnt;
	}
	public void setResvAmnt(String resvAmnt) {
		this.resvAmnt = resvAmnt;
	}
	
}
