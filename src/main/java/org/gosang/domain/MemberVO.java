package org.gosang.domain;

import java.util.Date;
import java.util.List;

import javax.persistence.Entity;

import lombok.Data;

@Data
@Entity
public class MemberVO {
	
	private String userid;
	private String userpw;
	private String userName;
	private boolean enabled;
	
	private Date regDate;
	private Date updateDate;
	private List<AuthVO> authList;

}
