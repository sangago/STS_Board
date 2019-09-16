package org.gosang.domain;

import java.util.Date;

import lombok.Data;

@Data
public class SignupVO {
	
	private Integer userbno;
	private String userid;
	private String userpw;
	private String username;
	
	private boolean enabled;
	private Date regDate;
	private Date updateDate;
	
}
