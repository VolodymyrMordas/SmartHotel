package com.smarthotel.rest.resources;

import com.smarthotel.ejb.repository.ApartmentRepository;
import com.smarthotel.entities.Apartment;
import com.smarthotel.generic.Direction;
import com.smarthotel.rest.model.ResponseModel;
import com.smarthotel.rest.model.Row;
import com.smarthotel.rest.model.SuccessResponse;
import com.sun.istack.internal.NotNull;

import javax.ejb.EJB;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

@Path(value = "apartment")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ApartmentResource {

    @EJB
    ApartmentRepository apartmentRepository;

    @GET
    @Path("/list/")
    @Produces(MediaType.APPLICATION_JSON)
    public Response list(
            @DefaultValue("asc") @QueryParam("order") String order,
            @DefaultValue("10") @QueryParam("limit") int limit,
            @DefaultValue("0") @QueryParam("offset") int offset) {
        int page = offset / limit;
        Direction direction = (( order.equals("asc") ) ? Direction.ASCENDING : Direction.DESCENDING);
        List<Apartment> apartmentList = apartmentRepository.findAll("id", page, limit, direction);
        int count = apartmentRepository.count();
        ResponseModel responseModel = new SuccessResponse();
        responseModel.setData(Apartment.class, new Row<>(apartmentList,count));

        return Response.ok()
                .entity(responseModel).build();
    }

    @GET
    @Path("/{apartmentId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response view(@NotNull @PathParam("apartmentId") long apartmentId){
        Apartment apartment = apartmentRepository.find(apartmentId);

        ResponseModel responseModel = new SuccessResponse();
        responseModel.setData(Apartment.class, apartment);

        return Response.ok().entity(responseModel).build();
    }


    @PUT
    @Path("/{apartmentId}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response update(
            @NotNull @PathParam("apartmentId") long apartmentId, Apartment apartment ){
        apartmentRepository.merge(apartment);
        apartmentRepository.flush();

        ResponseModel responseModel = new SuccessResponse();
        responseModel.setData(Apartment.class, apartment);

        return Response.ok().entity(responseModel).build();
    }


    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response create(Apartment apartment ){
        apartmentRepository.persist(apartment);
        apartmentRepository.flush();

        ResponseModel responseModel = new SuccessResponse();
        responseModel.setData(Apartment.class, apartment);

        return Response.ok().entity(responseModel).build();
    }
}