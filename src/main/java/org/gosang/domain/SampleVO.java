package org.gosang.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor		// 모든 필드를 파라미터로 가지는 생성자  
@NoArgsConstructor		// 파라미터가 없는 생성자 
public class SampleVO {
	private Integer mno;
	private String firstName;
	private String lastName;
}
