package org.gosang.mapper;

import org.apache.ibatis.annotations.Insert;

public interface Sample1Mapper {
	
	@Insert("insert into tbl_sample1 (col1) values (#{data}) ")
	int insertCol1(String data);
}
