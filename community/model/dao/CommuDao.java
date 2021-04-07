package community.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import challenge.model.dao.ChallDao;
import challenge.model.vo.Challenge;
import common.model.vo.PageInfo;
import member.model.vo.Member;


public class CommuDao {
	
	private Properties prop = new Properties();

	public CommuDao() {
		String fileName = ChallDao.class.getResource("/sql/community/commu-query.xml").getPath();
		try {
			prop.loadFromXML(new FileInputStream(fileName));
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	public int getRankListCount(Connection conn) {
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getRankListCount");
		
		try {
			stmt = conn.createStatement();
			
			rset = stmt.executeQuery(sql);

			if (rset.next()) {
				listCount = rset.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		//System.out.println("dao - 인기챌린지 갯수 : " + listCount);
		
		return listCount;
	}

	public ArrayList<Challenge> selecRanktList(Connection conn, PageInfo pi) {
		ArrayList<Challenge> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectRankList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
			int endRow = startRow + pi.getBoardLimit() - 1;

//			pstmt.setInt(1, startRow);
//			pstmt.setInt(2, endRow);

			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Challenge(rset.getInt("CHALL_NO"),
									   rset.getString("CHALL_TITLE"),
									   rset.getString("FILE_PATH"),
									   rset.getString("CHALL_FREQUENCY"),
									   rset.getString("CHALL_PERIOD"),
									   rset.getDate("CHALL_START"),
									   rset.getInt("CNT"),
									   rset.getString("CHALL_STATUS")
									   ));
			}
			
			//System.out.println("dao - 인기챌린지 리스트 : " + list);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return list;
		
	}
	
	// 찜 갯수 카운트 
	public int getHitsCount(Connection conn, int cNo) {
		int hit = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getHitsCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			pstmt.setInt(1, cNo);
			
			if(rset.next()) {
				hit = rset.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(rset);
		}
		
		return hit;
	}

	// 챌린저 top 10
	public ArrayList<Member> selectChallengerLankList(Connection conn) {
		ArrayList<Member> mlist = new ArrayList<>();
		Statement stmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectChallengetLankList");
		
		try {
			stmt = conn.createStatement();
			
			rset = stmt.executeQuery(sql);
			
			while(rset.next()) {
				mlist.add(new Member(rset.getString(1)));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		// System.out.println("dao top10 : " + mlist);
		
		return mlist;
	}

}
