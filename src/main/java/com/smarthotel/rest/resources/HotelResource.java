package com.smarthotel.rest.resources;

import com.smarthotel.ejb.repository.ApartmentRepository;
import com.smarthotel.ejb.repository.BuildingRepository;
import com.smarthotel.entities.Apartment;
import com.smarthotel.entities.Building;
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

@Path(value = "hotel")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class HotelResource {

    @EJB
    BuildingRepository buildingRepository;

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
        List<Building> userArrayList = buildingRepository.findAll("id", page, limit, direction);

        int count = buildingRepository.count();

        ResponseModel responseModel = new SuccessResponse();
        responseModel.setData(Building.class, new Row<>(userArrayList, count));

        return Response.ok()
                .entity(responseModel).build();
    }


    @GET
    @Path("/{buildingId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response view(@NotNull @PathParam("buildingId") long buildingId){
        Building building = buildingRepository.find(buildingId);

        ResponseModel responseModel = new SuccessResponse();
        responseModel.setData(Building.class, building);

        return Response.ok().entity(responseModel).build();
    }

    @DELETE
    @Path("/{buildingId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response delete(@NotNull @PathParam("buildingId") long buildingId){
        buildingRepository.remove(buildingId);
        ResponseModel responseModel = new SuccessResponse();
        return Response.ok().entity(responseModel).build();
    }

    @GET
    @Path("/{buildingId}/apartment/list")
    @Produces(MediaType.APPLICATION_JSON)
    public Response buildingViewApartments(
            @NotNull @PathParam("buildingId") long buildingId,
            @DefaultValue("asc") @QueryParam("order") String order,
            @DefaultValue("10") @QueryParam("limit") int limit,
            @DefaultValue("0") @QueryParam("offset") int offset){

        int page = offset / limit;

        List<Apartment> apartmentList = apartmentRepository.findByBuildingId(buildingId, page, limit);

        int count = apartmentRepository.countByBuildingId(buildingId);
        ResponseModel responseModel = new SuccessResponse();
        responseModel.setData(Apartment.class, new Row<>(apartmentList,count));

        return Response.ok()
                .entity(responseModel).build();
    }

    @PUT
    @Path("/{buildingId}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response update(
            @NotNull @PathParam("buildingId") long buildingId, Building building ){
        buildingRepository.merge(building);
        buildingRepository.flush();

        ResponseModel responseModel = new SuccessResponse();
        responseModel.setData(Building.class, building);

        return Response.ok().entity(responseModel).build();
    }

    @POST
//    @Path("/")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response create(Building building ){
        buildingRepository.persist(building);
        buildingRepository.flush();

        ResponseModel responseModel = new SuccessResponse();
        responseModel.setData(Building.class, building);

        return Response.ok().entity(responseModel).build();
    }
}