package com.smarthotel.ejb.services;

import com.smarthotel.ejb.repository.UserRepository;
import com.smarthotel.ejb.repository.VerificationRepository;
import com.smarthotel.entities.User;
import com.smarthotel.entities.Verification;
import com.smarthotel.generic.service.GenericService;
import com.smarthotel.rest.ApplicationException;
import com.smarthotel.utils.SendTextMessage;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.mail.MessagingException;

@Stateless
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class UserService extends GenericService<User, Long, UserRepository> {

    @EJB
    UserRepository userRepository;

    @EJB
    VerificationRepository verificationRepository;

    @EJB
    EmailService emailService;

    @Override
    public UserRepository getRepository() {
        return userRepository;
    }

    public void userPhoneNumberVerification(long userId) throws ApplicationException {
        User user = userRepository.find(userId);

        Verification v = verificationRepository
                .findByUserType(userId, Verification.T_PHONE);

        if(v == null){
            v = new Verification();
            v.setUserId(userId);
            v.setType(Verification.T_PHONE);
        }

        v.setCode(Verification.createdCode());
        verificationRepository.merge(v);
        verificationRepository.flush();

        String msg = "http://api.mordas.in.ua/SmartHotel/v1/user/phone/confirmation/"
                + v.getCode();

        SendTextMessage sendTextMessage = new SendTextMessage(
                msg, user.getPhone());
        //TODO:uncommented this 4 using
        sendTextMessage.send();
    }

    public void userEmailVerification(long userId) throws ApplicationException {
        User user = userRepository.find(userId);

        if(user == null){
            throw new ApplicationException(ApplicationException.E_4009,
                    "couldn't find user by id = " + userId);
        }

        try {
            Verification v = verificationRepository
                    .findByUserType(userId, Verification.T_EMAIL);

            if(v == null){
                v = new Verification();
                v.setUserId(userId);
                v.setType(Verification.T_EMAIL);
            }

            v.setCode(Verification.createdCode());

            verificationRepository.merge(v);
            verificationRepository.flush();

            emailService.userEmailVerification(user, v);

        } catch (MessagingException e) {
            e.printStackTrace();
            throw new ApplicationException(ApplicationException.E_4009,e.getMessage());
        }
    }

    public void userPhoneNumberConfirmation(short code)
            throws ApplicationException {
        User user = this.userConfirmation(code, Verification.T_PHONE);
        user.setPhoneVerified(true);
        if(!user.isPhoneVerified()){
            userRepository.merge(user);
            userRepository.flush();
        }

    }

    public void userEmailConfirmation(short code)
            throws ApplicationException {
        User user = this.userConfirmation(code, Verification.T_EMAIL);
        user.setEmailVerified(true);

        if(!user.isEmailVerified()){
            userRepository.merge(user);
            userRepository.flush();
        }
    }

    private User userConfirmation(short code, short type)
            throws ApplicationException {
        Verification verification = verificationRepository.findByCodeType(code, type);
        if(verification == null){
            throw new ApplicationException(ApplicationException.E_4010,"can't find " +
                    "verification code");
        }

        User user = userRepository.find(verification.getUserId());
        if(user == null){
            throw new ApplicationException(ApplicationException.E_4009,
                    "couldn't find user by id = " + verification.getUserId());
        }

        verificationRepository.remove(verification.getId());
        verificationRepository.flush();

        return user;
    }
}