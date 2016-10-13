package com.smarthotel.utils.tmp;

import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.transform.TransformerConfigurationException;
import java.io.File;
import java.io.IOException;

public class XmlPromSAXMain {

    private String path2xml;
//    private String path2xsd;
//    private String path2xsl;

    public XmlPromSAXMain(String path2xml, String path2xsd) {
        this.path2xml = path2xml;
//        this.path2xsd = path2xsd;
//        this.path2xsl = path2xsl;
    }

    public void processXml() throws ParserConfigurationException,
            SAXException, TransformerConfigurationException {
        File xmlFile = new File(path2xml);
//        File xsdFile = new File(path2xsd);

//        File xslFile = new File(path2xsl);
//        File xhtmlFile = new File("src/main/java/ua/in/mordas/itea" +
//                "/lesson18/hw/task1/xslt/import-" + (new Date()).getTime() + ".html");

        XmlPromSAXParser parser = new XmlPromSAXParser();
        SAXParserFactory saxParserFactory = SAXParserFactory.newInstance();
        SAXParser saxParser = saxParserFactory.newSAXParser();

//        SchemaFactory schemaFactory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
//        Schema schema = schemaFactory.newSchema(xsdFile);

//        Validator validator = schema.newValidator();

//        TransformerFactory transformerFactory = TransformerFactory.newInstance();

//        Source xslSource = new StreamSource(xslFile);
//        Transformer transformer = transformerFactory.newTransformer(xslSource);

//        Source xmlSource = new StreamSource(xmlFile);
//        StreamResult xhtmlResult = new StreamResult(xhtmlFile);
        try{
//            validator.validate(new StreamSource(xmlFile));
            saxParser.parse(xmlFile, parser);

//            transformer.transform(xmlSource,xhtmlResult);
        } catch (IOException e){
            e.printStackTrace();
        }
//        } catch (TransformerException e) {
//            System.out.println("--- xsl transform error ---");
//            System.out.println(e.getMessage());
//        }

    }

    public static void main(String[] args) throws ParserConfigurationException,
            SAXException, TransformerConfigurationException {

        File xmlFile = new File("/tmp/prom-ua.xml");
//        File xsdFile = new File("src/resources/xsd/import_schema.xsd");

//        File xslFile = new File("src/resources/xslt/import.xslt");
//        File xhtmlFile = new File("src/resources/xslt/import-" + (new Date()).getTime() + ".html");

        XmlPromSAXParser parser = new XmlPromSAXParser();
        SAXParserFactory saxParserFactory = SAXParserFactory.newInstance();
        SAXParser saxParser = saxParserFactory.newSAXParser();

//        SchemaFactory schemaFactory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
//        Schema schema = schemaFactory.newSchema(xsdFile);

//        Validator validator = schema.newValidator();

//        TransformerFactory transformerFactory = TransformerFactory.newInstance();

//        Source xslSource = new StreamSource(xslFile);
//        Transformer transformer = transformerFactory.newTransformer(xslSource);

//        Source xmlSource = new StreamSource(xmlFile);
//        StreamResult xhtmlResult = new StreamResult(xhtmlFile);
        try{
//            validator.validate(new StreamSource(xmlFile));
            saxParser.parse(xmlFile, parser);
//            transformer.transform(xmlSource,xhtmlResult);
        } catch (IOException e){
            e.printStackTrace();
        }/* catch (SAXException e){
            System.out.println("--- schema validation error ---");
            System.out.println(e.getMessage());
        }*/
//        catch (TransformerException e) {
//            System.out.println("--- xsl transform error ---");
//            System.out.println(e.getMessage());
//        }

    }

    public String getPath2xml() {
        return path2xml;
    }

    public void setPath2xml(String path2xml) {
        this.path2xml = path2xml;
    }

//    public String getPath2xsd() {
//        return path2xsd;
//    }

//    public void setPath2xsd(String path2xsd) {
//        this.path2xsd = path2xsd;
//    }

//    public String getPath2xsl() {
//        return path2xsl;
//    }
//
//    public void setPath2xsl(String path2xsl) {
//        this.path2xsl = path2xsl;
//    }
}
