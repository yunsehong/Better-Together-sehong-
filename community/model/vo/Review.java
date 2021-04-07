package community.model.vo;

import java.sql.Date;

public class Review {
	/* REVIEW_SEQ	NUMBER
	REVIEW_CONTENT	VARCHAR2(1000 BYTE)
	REVIEW_DATE	DATE
	REVIEW_MODIFY	DATE
	REVIEW_GRADE	NUMBER
	CHALL_NO	NUMBER
	REVIEW_STATUS	VARCHAR2(4 BYTE)
	USER_ID	VARCHAR2(20 BYTE)
	NICKNAME	VARCHAR2(20 BYTE)
	 * */
	private int rId;
	private String rContent;
	private Date createDate;
	private Date modifyDate;
	private int rGrade;
	private String challTitle;
	private int challNo;
	private String status;
	private String userId;
	private String nickName;
	
	public Review() {}

	public Review(int rId, String rContent, Date createDate, Date modifyDate, int rGrade, String challTitle,
			int challNo, String status, String userId, String nickName) {
		super();
		this.rId = rId;
		this.rContent = rContent;
		this.createDate = createDate;
		this.modifyDate = modifyDate;
		this.rGrade = rGrade;
		this.challTitle = challTitle;
		this.challNo = challNo;
		this.status = status;
		this.userId = userId;
		this.nickName = nickName;
	}

	public int getrId() {
		return rId;
	}

	public void setrId(int rId) {
		this.rId = rId;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public int getrGrade() {
		return rGrade;
	}

	public void setrGrade(int rGrade) {
		this.rGrade = rGrade;
	}

	public String getChallTitle() {
		return challTitle;
	}

	public void setChallTitle(String challTitle) {
		this.challTitle = challTitle;
	}

	public int getChallNo() {
		return challNo;
	}

	public void setChallNo(int challNo) {
		this.challNo = challNo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	@Override
	public String toString() {
		return "Review [rId=" + rId + ", rContent=" + rContent + ", createDate=" + createDate + ", modifyDate="
				+ modifyDate + ", rGrade=" + rGrade + ", challTitle=" + challTitle + ", challNo=" + challNo
				+ ", status=" + status + ", userId=" + userId + ", nickName=" + nickName + "]";
	}
	
	
	
}
