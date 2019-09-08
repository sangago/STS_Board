package org.gosang.persistence;


import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;




@Log4j
public class JDBCTests {
	
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		
		try(Connection con = 
				DriverManager.getConnection(
							"jdbc:mysql://127.0.0.1:3306/testdb?useSSL=false&serverTimezone=Asia/Seoul",
							"gosang",
							"10060000")){
			
			log.info(con);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	
	}

}


//@Log4j
//public class JDBCTests {
//	
//	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
//	
//	private static final String URL = "jdbc:mysql://127.0.0.1:3306/book_ex?useSSL=false&serverTimezone=Asia/Seoul";
//	
//	private static final String USER = "gosang";
//	
//	private static final String PW = "a1b2c3^^";
//	
//	@Test
//	public void testConnection() throws Exception{
//		Class.forName(DRIVER);
//		try(Connection con = DriverManager.getConnection(URL, USER, PW)){
//			System.out.println(con);
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
//	}
//	
//}
