package org.gosang.domain;

import lombok.Data;

@Data
public class AttachFileDTO {
	
	private String fileName;	// 파일이름 
	private String uploadPath;	// 업로드 경로 
	private String uuid;		// uuid값 
	private boolean image;		// 이미지 여부 
	
}
