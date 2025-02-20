package com.kh.email;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

public class MailTestRun {

	public static void main(String[] args) throws Exception {
		
		 JavaMailSenderImpl	mailSender = new JavaMailSenderImpl();
		 
		 // 메일 서버 관련 설정
		 mailSender.setHost("smtp.gmail.com");
		 mailSender.setPort(587);
		 mailSender.setUsername("ojlee6207@gmail.com");	// 인증 설정한 이메일 계정
		 mailSender.setPassword("erpn qgpc nkgf nosv");	// 발급받은 앱 비밀번호
		 
		 Properties prop = new Properties();
		 prop.put("mail.smtp.auth", true);
		 prop.put("mail.smtp.starttls.enable", true);
		 
		 mailSender.setJavaMailProperties(prop);
		 
		 // 메일 전송
		 MimeMessage message = mailSender.createMimeMessage();
		 MimeMessageHelper msgHelper = new MimeMessageHelper(message, true, "UTF-8");
	 
		 msgHelper.setFrom("ojlee6207@gmail.com", "[KH] 테스트 메일");		// 발신자 이메일
		 msgHelper.setSubject("테스트메일 제목입니당");						// 메일 제목
		 msgHelper.setText("메일 내용 부분....");							// 메일 내용
		 msgHelper.setTo("foodeat1@naver.com");						// 수신자 이메일
	
		 File attachFile = new File(MailTestRun.class.getResource("/static/img/goldengate.jpg").getPath());
		 msgHelper.addAttachment("goldengate.jpg", attachFile);		// 첨부파일
		 
		 mailSender.send(message);
		 
		 System.out.println("메일 전송 완료");
	}

}
