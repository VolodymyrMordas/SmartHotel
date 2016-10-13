package com.smarthotel.rest;

import com.smarthotel.rest.model.ErrorResponse;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;

/**
 * Catch Application Exception
 */
public class ApplicationExceptionMapper implements ExceptionMapper<ApplicationException> {

    @Override
    public Response toResponse(ApplicationException e) {
        ErrorResponse errorResponse = new ErrorResponse();
        errorResponse.setCode(e.getCode());
        errorResponse.setMessage(e.getMessage().toLowerCase());
        return Response.status(e.getCode())
                .entity(errorResponse)
                .type(MediaType.APPLICATION_JSON).
                        build();
    }
}