package com.smarthotel.utils;

import com.smarthotel.entities.Billing;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class XmlImportSAXParser extends DefaultHandler {

    public static String ELEM_DOCUMENT = "document";
    private boolean readDocument = false;

    public static String ELEM_BILLING = "billing";
    private boolean readBilling = false;

    public static String ELEM_ORDER_ID = "orderId";
    private boolean readOrderId = false;
    private boolean readOrderCurrencyCode = false;

    public static String ELEM_BILLING_AMOUNT = "amount";
    private boolean readBillingAmount = false;

    public static String ELEM_CURRENCY_CODE = "currencyCode";
    private boolean readCurrencyCode = false;

    public static String ELEM_PAYMENT_DATE = "paymentDate";
    private boolean readOPaymentDate = false;

    private List<Billing> billingList = new ArrayList<Billing>();
    private Billing currentBilling;

    @Override
    public void startDocument() throws SAXException {

    }

    @Override
    public void startElement(String uri, String localName, String qName,
                             Attributes attributes) throws SAXException {
        if(qName.equals(ELEM_DOCUMENT)){
            readDocument = true;
        } else if(qName.equals(ELEM_BILLING)){
            readBilling = true;
            currentBilling = new Billing();
        } else if(qName.equals(ELEM_ORDER_ID)){
            readOrderId = true;
        } else if(qName.equals(ELEM_BILLING_AMOUNT)){
            readBillingAmount = true;
        } else if(qName.equals(ELEM_CURRENCY_CODE)){
            readCurrencyCode = true;
        }  else if(qName.equals(ELEM_PAYMENT_DATE)){
            readOPaymentDate = true;
        }
    }

    @Override
    public void endDocument() throws SAXException {
        System.out.println(Arrays.deepToString(billingList.toArray()));
    }

    @Override
    public void endElement(String uri, String localName, String qName) throws SAXException {
        if(qName.equals(ELEM_DOCUMENT)){
            readDocument = false;
        } else if(qName.equals(ELEM_BILLING)){
            readBilling = false;
            billingList.add(currentBilling);
        } else if(qName.equals(ELEM_ORDER_ID)){
            readOrderId = false;
        } else if(qName.equals(ELEM_BILLING_AMOUNT)){
            readBillingAmount = false;
        } else if(qName.equals(ELEM_CURRENCY_CODE)){
            readCurrencyCode = false;
        }  else if(qName.equals(ELEM_PAYMENT_DATE)){
            readOPaymentDate = false;
        }
    }

    private static SimpleDateFormat formatter
            = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

    @Override
    public void characters(char[] ch, int start, int length) throws SAXException {
        if(readDocument){
            if(readBilling){
                if(readOrderId){
                    currentBilling.setOrderId(Long.valueOf(new String(ch, start, length)));
                } else if(readBillingAmount){
                    currentBilling.setAmount(Double.valueOf(new String(ch, start, length)));
                } else if(readOPaymentDate){
                    try{
                        currentBilling.setPaymentDate(new Timestamp(formatter
                                .parse(new String(ch, start, length)).getTime()));
                    } catch (ParseException e){
                        e.printStackTrace();
                    }
                } else if(readCurrencyCode){
                    currentBilling.setCurrencyCode(
                            Integer.valueOf(new String(ch,start,length)));
                }
            }
        }
    }



    public List<Billing> getOrderList() {
        return billingList;
    }
}
