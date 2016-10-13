package com.smarthotel.rest.resources;

import com.smarthotel.ejb.repository.BillingRepository;
import com.smarthotel.entities.Billing;
import com.smarthotel.rest.model.Row;
import com.smarthotel.rest.model.SuccessResponse;
import com.smarthotel.utils.XMLImportSAXMain;
import org.glassfish.jersey.media.multipart.FormDataContentDisposition;
import org.glassfish.jersey.media.multipart.FormDataParam;
import org.xml.sax.SAXException;

import javax.ejb.EJB;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerConfigurationException;
import java.io.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
//import com.sun.jersey.core.header.FormDataContentDisposition;
//import com.sun.jersey.multipart.FormDataParam;

@Path(value = "billing")
public class BillingResource {

    @EJB
    BillingRepository billingRepository;

    @POST
    @Path("/upload")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public Response uploadFile(
            @FormDataParam("files") InputStream uploadedInputStream,
            @FormDataParam("files") FormDataContentDisposition fileDetail) throws SAXException {

        String xmlPath = "/tmp/" + fileDetail.getFileName() + (new Date()).getTime();
        String xsdPath = "/tmp/xsd/import_schema.xsd";
        System.out.println(uploadedInputStream);
        System.out.println(fileDetail.getFileName());

        writeToFile(uploadedInputStream, xmlPath);

        XMLImportSAXMain xmlImportSAX = new XMLImportSAXMain(xmlPath, xsdPath);
        List<Billing> billingList = new ArrayList<>();
        try {
            billingList.addAll(xmlImportSAX.processXml());
        } catch (ParserConfigurationException e) {
            e.printStackTrace();
        } catch (TransformerConfigurationException e) {
            e.printStackTrace();
        }


        for (int i = 0; i < billingList.size(); i++) {
            billingRepository.persist(billingList.get(i));
        }

        SuccessResponse successResponse = new SuccessResponse();
        successResponse.setData(Billing.class, new Row<>(billingList, billingList.size()));

        return Response.status(200).entity(successResponse).build();

    }

    // save uploaded file to new location
    private void writeToFile(InputStream uploadedInputStream,
                             String uploadedFileLocation) {

        try {
            int read = 0;
            byte[] bytes = new byte[1024];

            OutputStream out = new FileOutputStream(new File(uploadedFileLocation));
            while ((read = uploadedInputStream.read(bytes)) != -1) {
                out.write(bytes, 0, read);
            }
            out.flush();
            out.close();
        } catch (IOException e) {

            e.printStackTrace();
        }

    }
}