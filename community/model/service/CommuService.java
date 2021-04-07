package community.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import challenge.model.dao.ChallDao;
import challenge.model.vo.Challenge;
import common.model.vo.PageInfo;
import community.model.dao.CommuDao;
import member.model.vo.Member;

public class CommuService {

	// 인기챌린지 갯수
	public int getRankListCount() {
		Connection conn = getConnection();
		
		int listCount = new CommuDao().getRankListCount(conn);
		
		close(conn);
		//System.out.println("서비스 - 인기챌린지 갯수 : " + listCount);
		
		return listCount;
		
	}
	
	// 인기챌린지 리스트
	public ArrayList<Challenge> selectRankList(PageInfo pi) {
		Connection conn = getConnection();

		ArrayList<Challenge> list = new CommuDao().selecRanktList(conn, pi);
		//System.out.println("서비스 - 인기챌린지 리스트 : " + list);
		close(conn);

		return list;

	}

	// 찜 갯수 카운트
	public int getHitsCount(int cNo) {
		Connection conn = getConnection();
		
		int hit = new CommuDao().getHitsCount(conn, cNo);
		
		close(conn);
		
		return hit;
	}

	// 챌린저 top 10 
	public ArrayList<Member> selectChallengerLankList() {
		Connection conn = getConnection();
		ArrayList<Member> mlist = new CommuDao().selectChallengerLankList(conn);
		
		close(conn);
		//System.out.println("service 챌린저 탑텐 : " + mlist);
		
		
		return mlist;
	}

}
