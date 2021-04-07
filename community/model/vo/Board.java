package community.model.vo;

import java.sql.Date;

public class Board {
	/* BOARD_SEQ	NUMBER
	BOARD_TITLE	VARCHAR2(60 BYTE)
	BOARD_CONTENT	VARCHAR2(1000 BYTE)
	BOARD_DATE	DATE
	BOARD_MODIFY	DATE
	BOARD_CNT	NUMBER
	BOARD_FILEPATH	VARCHAR2(500 BYTE)
	BOARD_STATUS	VARCHAR2(4 BYTE)
	USER_ID	VARCHAR2(20 BYTE)
	NICKNAME	VARCHAR2(20 BYTE)
	 * */
	private int bId;			// 게시글번호
	private String bTitle;		// 제목
	private String bContent;	// 내용
	private Date createDate;	// 작성일
	private Date modifyDate;	// 수정일
	private int bCount;			// 조회수
	private String bFilepath;	// 파일경로
	private String status;		// 게시글상태(Y, N)
	private String userId;		// 회원id
	private String nickName;	// 닉네임
	
	public Board() {}

	public Board(int bId, String bTitle, String bContent, Date createDate, Date modifyDate, int bCount,
			String bFilepath, String status, String userId, String nickName) {
		super();
		this.bId = bId;
		this.bTitle = bTitle;
		this.bContent = bContent;
		this.createDate = createDate;
		this.modifyDate = modifyDate;
		this.bCount = bCount;
		this.bFilepath = bFilepath;
		this.status = status;
		this.userId = userId;
		this.nickName = nickName;
	}
	
	

	public Board(String bTitle, String bContent, String userId, String nickName) {
		super();
		this.bTitle = bTitle;
		this.bContent = bContent;
		this.userId = userId;
		this.nickName = nickName;
		
	}

	public int getbId() {
		return bId;
	}

	public void setbId(int bId) {
		this.bId = bId;
	}

	public String getbTitle() {
		return bTitle;
	}

	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}

	public String getbContent() {
		return bContent;
	}

	public void setbContent(String bContent) {
		this.bContent = bContent;
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

	public int getbCount() {
		return bCount;
	}

	public void setbCount(int bCount) {
		this.bCount = bCount;
	}

	public String getbFilepath() {
		return bFilepath;
	}

	public void setbFilepath(String bFilepath) {
		this.bFilepath = bFilepath;
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
		return "Board [bId=" + bId + ", bTitle=" + bTitle + ", bContent=" + bContent + ", createDate=" + createDate
				+ ", modifyDate=" + modifyDate + ", bCount=" + bCount + ", bFilepath=" + bFilepath + ", status="
				+ status + ", userId=" + userId + ", nickName=" + nickName + "]";
	}
	
	
	
}
