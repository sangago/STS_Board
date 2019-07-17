package org.gosang.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private int pageNum;	// 페이지 번호 
	private int amount;		// 한페이지당 몇개의 데이터를 보여줄 것인가 
	
	public Criteria() {
		this(1,10);		// 1페이지, 게시글10개 
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	// 페이징에서 보여지는 데이터 시작값 BoardMapper.xml id="getListWithPaging" 사용 
	public int getPageStart() {
		return (this.pageNum - 1) * amount;
	}
	
}
