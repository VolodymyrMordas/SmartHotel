package com.smarthotel.ejb.services;

import com.smarthotel.ejb.repository.UserRepository;
import com.smarthotel.ejb.repository.VerificationRepository;
import com.smarthotel.entities.User;
import com.smarthotel.entities.Verification;

import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Date;
import java.util.HashMap;

@Stateless
public class EmailService {

    @Resource(lookup = "mail/smartHotel")
    private Session mailSession;

    @EJB
    UserRepository userRepository;

    @EJB
    VerificationRepository verificationRepository;

    public void sendWelcomeEmail(long userId) throws MessagingException {
        final User user = userRepository.find(userId);

        if(user == null){
            return;
        }

        Message msg = new MimeMessage(mailSession);
        msg.setSubject("SmartHotel :: Welcome");
        msg.setSentDate(new Date());

        msg.setRecipients(Message.RecipientType.TO,
                InternetAddress.parse(user.getEmail(), false));
        TemplateService templateService = new TemplateService("smarthotel_welcome.vm", new HashMap<String, Object>(){
            {
                put(User.class.getSimpleName().toLowerCase(),user);
            }
        });
        msg.setText(templateService.renderTemplate());

        Transport.send(msg);
    }

    public void userEmailVerification(final User user, final Verification verification) throws MessagingException {

        Message msg = new MimeMessage(mailSession);
        msg.setSubject("SmartHotel :: Email :: Verification");
        msg.setSentDate(new Date());

        msg.setRecipients(Message.RecipientType.TO,
                InternetAddress.parse(user.getEmail(), false));
        TemplateService templateService = new TemplateService("smarthotel_email_verification.vm", new HashMap<String, Object>(){
            {
                put(User.class.getSimpleName().toLowerCase(), user);
                put(Verification.class.getSimpleName().toLowerCase(), verification);
            }
        });
        msg.setContent(templateService.renderTemplate(), "text/html");

        Transport.send(msg);
    }
}
