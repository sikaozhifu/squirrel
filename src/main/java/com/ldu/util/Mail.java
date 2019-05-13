package com.ldu.util;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Date;
import java.util.Properties;
import java.util.Random;

/**
 * @Author:chenwei
 * @Description
 * @Date: Created 2018/1/4
 */
public class Mail {
    private String code;
    //发送邮件的帐号和密码
    private String username="765108648";

    private String password="gxungxsauhdgbbhd";
    //发送邮件的主机
    private String host = "smtp.qq.com";

    private String mail_from = "765108648@qq.com";

    private String mail_subject = "中北";

    private String mail_body = "您的验证码为："+code+"有效期为5分钟";

    private String personalName = "我的邮件";

    private Integer port = 587;
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
    public void sendMail(String code,String mail_to) throws SendFailedException{
        try {
            //发送邮件的props文件
            Properties props = new Properties();
            // 初始化props
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.port",port);

            //进行邮件服务用户认证
            Authenticator auth = new MyEmailAutherticator(username,password);
            // 创建session,和邮件服务器进行通讯
            Session session = Session.getDefaultInstance(props,auth);
            // 创建mime类型邮件
            MimeMessage message = new MimeMessage(session);
            //设置邮件格式
            message.setContent("Hello","text/html;charset=utf-8");
            // 设置主题
            message.setSubject(mail_subject);
            //设置邮件内容
            message.setText("【中北二手交易】您申请的邮箱验证码是:" + code + "(切勿将验证码告知他人),请在15分钟内输入完成验证.如非本人操作,请忽略这条邮件.");
            //设置邮件标题
            //message.setHeader(mail_head_name, mail_head_value);
            message.setSentDate(new Date());//设置邮件发送时期
            Address address = new InternetAddress(mail_from,personalName);
            //设置邮件发送者的地址
            message.setFrom(address);
            //======单发邮件======
            //设置邮件接收者的地址
            Address toaddress = new InternetAddress(mail_to);
            // 设置收件人
            message.addRecipient(Message.RecipientType.TO,toaddress);

            //======群发邮件======
//            List<String> recipients = new ArrayList<String>();
//            recipients.add("123456789@qq.com");
//            recipients.add("234567890@gmail.com");
//            final int num = recipients.size();
//            InternetAddress[] addresses = new InternetAddress[num];
//            for (int i = 0; i < num; i++) {
//                addresses[i] = new InternetAddress(recipients.get(i));
//            }
//            message.setRecipients(Message.RecipientType.TO, addresses);
            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
