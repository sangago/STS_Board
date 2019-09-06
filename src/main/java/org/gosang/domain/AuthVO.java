package org.gosang.domain;

import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class AuthVO {
	
	@NotEmpty(message="ID를 입력하세요.")
	private String userid;
	
	@NotEmpty(message="Password를 입력하세요.")
	private String auth;
}
