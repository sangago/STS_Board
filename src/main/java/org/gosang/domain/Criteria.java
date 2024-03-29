package org.gosang.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private int pageNum;	// 페이지 번호 
	private int amount;		// 한페이지당 몇개의 데이터를 보여줄 것인가 
	
	private String type;
	private String keyword;
	
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
	
	public String[] getTypeArr() {		// 검색조건 : T(제목) W(작성자) C(내용)
		
		return type == null? new String[] {}: type.split("");
	}
	
	// UriComponentsBuilder 클래스 : 여러개의 파라미터를 연결해서 URL의 형태로 만들어 주는 기능이 있
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
	}
}
