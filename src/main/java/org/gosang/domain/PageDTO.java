package org.gosang.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10;		// Math.ceil() : 소수점을 올림으로 처리하는 함수 
		this.startPage = this.endPage - 9;		// 화면에 페이지가 10개씩 보여진다면 -9
		
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		
		this.next = this.endPage < realEnd;
	}
	
//	DTO는 계층간 데이터 교환을 위한 자바빈즈(=계층간 데이터 교환을 위한 객체)
//	VO로 바꿔 말 할수도 있지만 VO는 read only 속성을 가진다 
}