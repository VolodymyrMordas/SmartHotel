package com.smarthotel.utils.tmp;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class XmlPromSAXParser extends DefaultHandler {

    public static String ELEM_OFFER = "offer";
    private boolean readOffer = false;

    @Override
    public void startDocument() throws SAXException {

    }

    private int count;

    @Override
    public void startElement(String uri, String localName, String qName,
                             Attributes attributes) throws SAXException {
        if(qName.equals(ELEM_OFFER)){
            readOffer = true;
            count++;
            System.out.println(count + " : group_id = " + attributes.getValue("group_id"));
        }
    }

    @Override
    public void endDocument() throws SAXException {
//        System.out.println(Arrays.deepToString(billingList.toArray()));
    }

    @Override
    public void endElement(String uri, String localName, String qName) throws SAXException {
        if(qName.equals(ELEM_OFFER)){
            readOffer = false;
        }
    }

    @Override
    public void characters(char[] ch, int start, int length) throws SAXException {
        if(readOffer){

        }
    }
}
