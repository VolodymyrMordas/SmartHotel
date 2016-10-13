package com.smarthotel.rest.model;

import java.io.Serializable;

public class ErrorResponse extends ResponseModel implements Serializable {
    public ErrorResponse() {
        super(Status.error);
    }
}
