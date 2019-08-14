package org.gosang.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.gosang.domain.AttachFileDTO;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;
import net.sf.jmimemagic.Magic;
import net.sf.jmimemagic.MagicMatch;


@Controller
@Log4j
public class UploadController {
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		
		log.info("upload form");
		
	}
	
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		
		String uploadFolder = "/Users/gosang-a/Downloads/temp";
		
		for(MultipartFile multipartFile : uploadFile) {
			
			log.info("----------------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			
			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				log.error(e.getMessage());
			}	// end catch
		}	// end for		
	}

	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		
		log.info("upload ajax");
		
	}
	
	
	// 중복된 이름 첨부파일 처리 (년/월/일 폴더의 생성)
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
			
			List<AttachFileDTO> list = new ArrayList<>();
			String uploadFolder = "/Users/gosang-a/Downloads/temp";
			
			String uploadFolderPath = getFolder();
			// make folder --------------------
			File uploadPath = new File(uploadFolder, uploadFolderPath);	//getFolder(): 폴더의 경로 
			log.info("upload path: " + uploadPath);
			
			if (uploadPath.exists() ==  false) {	// exists(): 파일이 존재하는지 여부. 반환결과가 참/거짓 
				uploadPath.mkdirs();				// mkdir() : 디렉토리 만들기 함수. 성공결과를 참/거짓으로 반환 mkdirs(): mkdir랑 거의 같은기능이지만 상위 폴더가 없으면 상위폴더를 만든
			}		// make yyyy/MM/dd folder
			
			for (MultipartFile multipartFile : uploadFile) {
				
				AttachFileDTO attachDTO = new AttachFileDTO();

				String uploadFileName = multipartFile.getOriginalFilename();
				
				log.info("----------------------------------");
				log.info("Upload File Name: " + multipartFile.getOriginalFilename());	//getOriginalFilename(): 파일의 실제 이름을 구한다 
				log.info("Upload File Size: " + multipartFile.getSize());
				
				
				// IE has file path
				uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("/") + 1);
				
				log.info("only file name: " + uploadFileName);
				
				attachDTO.setFileName(uploadFileName);
				
				// 파일 중복 방지를 위한 UUID 생성 
				UUID uuid = UUID.randomUUID();	//randomUUID(): 임의의 값 생성 
				uploadFileName = uuid.toString() + "_" + uploadFileName;	// ex -> UUID_파일명(.확장자) 
				
				try {
					
	//				File saveFile = new File(uploadFolder, uploadFileName);
					File saveFile = new File(uploadPath, uploadFileName);
					
					multipartFile.transferTo(saveFile);	//	transferTo(): 파일을 저장한다 
					
					attachDTO.setUuid(uuid.toString());
					attachDTO.setUploadPath(uploadFolderPath);
					
					// 이미지 파일인지 검사
					if(checkImageType(saveFile)) {
						
						attachDTO.setImage(true);
						
						FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));		// FileOutputStream(File file): File객체가 가리키는 파일을 쓰기 위한 객체 생성 
						
						Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);		// getInputStream(): 읽기 
						
						thumbnail.close();
						
					}
					
					// add to List
					list.add(attachDTO);
					
				} catch (Exception e) {
					log.error(e.getMessage());
				}	// end catch
			}	// end for
			
			return new ResponseEntity<>(list, HttpStatus.OK);
		}
	
	// 이미지 파일인지 검사
	private boolean checkImageType(File file) {
		
		try {
			
			Magic magic = new Magic();
			MagicMatch match = magic.getMagicMatch(file, false);
			String contentType = match.getMimeType();
			
			return contentType.startsWith("image");
			
//			return	match.getMimeType().contains("image");
			
//			Mac에서는 null값을 리턴하기때문에 jmimemagic 라이브러리 사용 
//			String contentType = Files.probeContentType(file.toPath());	// probeContentType():마임타임 확인(텍스트인지 이미지인지), toPath(): java.nio.file.Path 객체로 반환한다.
//			return contentType.startsWith("image");		// startsWith(): 특정 문자열로 시작하는지 확인하는 메서드 
			
		} catch (Exception e) {		// (IOException e) ->probeContentType() 사용했을때 예외처리 
			
			e.printStackTrace();
			
		}
		
		return false;
	}
	
	// 섬네일 데이터 전송
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		
		log.info("fileName: " + fileName);
		
		File file = new File("/Users/gosang-a/Downloads/temp/" + fileName);
		
		log.info("file: " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			Magic magic = new Magic();
			MagicMatch match = magic.getMagicMatch(file, false);
			String contentType = match.getMimeType();
			
			header.add("Content-Type", match.getMimeType());	// header.add("Content-Type", Files.probeContentType(file.toPath())); 였으나 Files.probeContentType()가 null값을 반환해서 변경 
			
			log.info("header: " + header);
			
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch(IOException e) {
			
			e.printStackTrace();
			
		} catch(Exception e) {
			
			e.printStackTrace();
			
		}
		
		return result;
	}
	
	// 첨부파일 다운로드
	@GetMapping(value="/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName){
		log.info("download file: " + fileName);
		
		Resource resource = new FileSystemResource("/Users/gosang-a/Downloads/temp/" + fileName);
		
		if(resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		log.info("resource: " + resource);
		
		String resourceName = resource.getFilename();
		
		// uuid 제거
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		
		log.info("resourceOriginalName: " + resourceOriginalName);
//		log.info("resourceName: " + resourceName);
//		log.info("resourceName:::::::::::::::: " + resourceName.substring(resourceName.indexOf("_") + 1));
		
		HttpHeaders headers = new HttpHeaders();
		try {
			
			String downloadName = null;
			
			if(userAgent.contains("Trident")) {
				
				log.info("IE browser");
				
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8"). replaceAll("/+", " ");
				
			} else if(userAgent.contains("Edge")) {
				
				log.info("Edge browser");
				
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
				
				log.info("Edge name: " + downloadName);
				
			} else {
				
				log.info("Chrome browser");
				
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
				
			}
			
			log.info("downloadName: " + downloadName);
			
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
			
		} catch (UnsupportedEncodingException e) {
			
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		
		log.info("deleteFile: " + fileName);
		
		File file;
		
		try {
			file = new File("/Users/gosang-a/Downloads/temp/" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			if(type.equals("image")) {
				
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				
				log.info("largeFileName: " + largeFileName);
				
				file = new File(largeFileName);
				
				file.delete();
			}
		
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}

}
