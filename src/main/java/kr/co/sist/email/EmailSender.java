package kr.co.sist.email;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import kr.co.sist.util.cipher.DataDecrypt;
import kr.co.sist.vo.EmailVO;

public class EmailSender {
	
    public void mailSend(EmailVO eVO)throws UnsupportedEncodingException, GeneralSecurityException{
    	
    	Properties prop = new Properties();
//    	C:\dev\workspace\mybatis_prj\src\main\java\properties\email.properties
    	System.out.println(System.getProperty("user.dir"));
		try {
			FileInputStream fis=
			 new FileInputStream(System.getProperty("user.dir") + 
					 "/src/main/java/properties/email.properties");
			prop.load(fis);
			if(fis != null) {fis.close();}
		} catch (IOException e) {
			e.printStackTrace();
		}
    	
    	 // 발신자 이메일 계정 정보
    	//des 키 : 0123456789abcdef
         String username = prop.getProperty("username"); // 발신자 네이버 이메일 주소
         String password = prop.getProperty("password"); // 발신자 네이버 이메일 비밀번호

        // SMTP 서버 설정
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");//smtp서버 인증을 사용하는 설정(true-외부에서 인증설정)
        props.put("mail.smtp.starttls.enable", "true");//tls보안을 사용한 연결 설정
        props.put("mail.smtp.host", "smtp.naver.com");//smtp서버의 호스트명 설정 smtp.
        props.put("mail.smtp.port", "587");//smtp port는 587

        // 세션 생성 : 이메일 메시지를 구성하고 전송하는 데 사용
        //Authenticator : smtp서버 인증에 필요한 사용자명과 비번을 전달하는 클래스
        DataDecrypt dd = new DataDecrypt("0123456789abcdef");
        final String username2 = dd.decryption(username);
        final String password2 = dd.decryption(password);
        
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username2, password2);
            }
        });

        try {
            // 메시지 구성
        	//message : 메시지의 헤더 설정 - 발신자, 수신자, 제목, 내용-메타데이터를 설정
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username2)); // 발신자 이메일
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(eVO.getEmail())); // 수신자 이메일
            message.setSubject(eVO.getSubject()); // 이메일 제목
//            message.setText("안녕메일 테스트 고객님의 아이디는 "+username2+"입니다."); // 이메일 내용
            message.setContent(eVO.getContent(),"text/html;charset=UTF-8");

            // 이메일 전송
            Transport.send(message);

        } catch (MessagingException e) {
            e.printStackTrace(); // 디버깅을 위해 스택 트레이스 출력
            throw new RuntimeException(e);
        }//end catch
    }//mailSend
    
    public static void main(String[] args)throws UnsupportedEncodingException, GeneralSecurityException{
    	EmailSender e = new EmailSender();
    	EmailVO eVO = new EmailVO(0, "2dpaesu@gmail.com", "asdfs", "sdfsd");
    	e.mailSend(eVO);
    }
}//class