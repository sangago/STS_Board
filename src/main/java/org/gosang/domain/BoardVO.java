package org.gosang.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {

	private int bno;			// null값 처리를 위해 int가 아닌 Integer 사용 
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;
}
