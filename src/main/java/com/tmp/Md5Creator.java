package com.tmp;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Md5Creator {
    public static void main(String[] args) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        String password = "1234567890";
        MessageDigest md = MessageDigest.getInstance("MD5");

        md.update(password.getBytes("UTF-8")); // Change this to "UTF-16" if needed
        byte[] digest = md.digest();
        BigInteger bigInt = new BigInteger(1, digest);
        String output = bigInt.toString(16);

        System.out.println(output);
    }
}
