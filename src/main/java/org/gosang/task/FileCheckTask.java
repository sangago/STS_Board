package org.gosang.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

import org.gosang.domain.BoardAttachVO;
import org.gosang.mapper.BoardAttachMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {
	
	@Setter(onMethod_ = { @Autowired })
	private BoardAttachMapper attachMapper;
	
	private String getFolderYesterDay() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		 Calendar cal = Calendar.getInstance();
		 
		 cal.add(Calendar.DATE, -1);
		 
		 String str = sdf.format(cal.getTime());
		 
		 return str.replace("-", File.separator);
	}
	
	
	/* cron 설정 
	 * cron = "seconds(0~59) minutes(0~59) hours(0~23) day(1~31) month(1~12) dayofweek(1~7) year(optional)"
	 * 		* 모든
	 * 		? 제외 
	 * 		- 기간 
	 * 		, 특정 시간 
	 * 		/ 시작 시간과 반복시간 
	 * 		L 마지막
	 * 		W 가까운 평일 
	*/
	@Scheduled(cron="0 0 2 * * *")	// cron : 주기 제어 -> 매일 새벽 2시에 동작 
	public void checkFiles() throws Exception{
		
		log.warn("File Check Task run........");
		log.warn("===========================");
		
		// file list in database
		List<BoardAttachVO> fileList = attachMapper.getOldFiles();
		
		// ready for check file in directory with database file list
		List<Path> fileListPaths = fileList.stream().map(vo -> Paths.get("/Users/gosang-a/Downloads/temp/", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName())).collect(Collectors.toList());
		
		// image file has thumnail file
		fileList.stream().filter(vo -> vo.isFileType() == true).map(vo -> Paths.get("/Users/gosang-a/Downloads/temp/", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName())).forEach(p -> fileListPaths.add(p));
		
		log.warn("===========================");
		
		fileListPaths.forEach(p -> log.warn(p));
		
		// files in yesterday directory
		File targetDir = Paths.get("/Users/gosang-a/Downloads/temp/", getFolderYesterDay()).toFile();
		
		log.warn("삭제될 폴더 경로: " + targetDir);
		
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		
		log.warn("----------------------------");
		
		for(File file : removeFiles) {
			
			log.warn(file.getAbsolutePath());
			
			file.delete();
		}	
	}
	
}
