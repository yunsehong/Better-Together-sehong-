package community.model.vo;

import java.sql.Date;

public class Attachment {
	private int fId;			// 파일 pk
	private int bId;			// 참조 bId
	private String originName;  // 원본 파일명
	private String changeName;  // 서버에 저장 된 파일 이름
	private String filePath;    // 파일 저장 경로
	private String status;      // 삭제 여부

	public Attachment() {}

	public Attachment(int fId, int bId, String originName, String changeName, String filePath, String status) {
		super();
		this.fId = fId;
		this.bId = bId;
		this.originName = originName;
		this.changeName = changeName;
		this.filePath = filePath;
		this.status = status;
	}

	public int getfId() {
		return fId;
	}

	public void setfId(int fId) {
		this.fId = fId;
	}

	public int getbId() {
		return bId;
	}

	public void setbId(int bId) {
		this.bId = bId;
	}

	public String getOriginName() {
		return originName;
	}

	public void setOriginName(String originName) {
		this.originName = originName;
	}

	public String getChangeName() {
		return changeName;
	}

	public void setChangeName(String changeName) {
		this.changeName = changeName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Attachment [fId=" + fId + ", bId=" + bId + ", originName=" + originName + ", changeName=" + changeName
				+ ", filePath=" + filePath + ", status=" + status + "]";
	}

	
}
