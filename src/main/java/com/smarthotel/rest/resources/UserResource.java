package com.smarthotel.rest.resources;

import com.smarthotel.ejb.repository.UserRepository;
import com.smarthotel.ejb.repository.VerificationRepository;
import com.smarthotel.ejb.services.UserService;
import com.smarthotel.entities.User;
import com.smarthotel.generic.Direction;
import com.smarthotel.rest.ApplicationException;
import com.smarthotel.rest.model.ResponseModel;
import com.smarthotel.rest.model.Row;
import com.smarthotel.rest.model.SuccessResponse;
import com.sun.istack.internal.NotNull;

import javax.ejb.EJB;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

@Path(value = "user")
@Produces(MediaType.APPLICATION_JSON)
//@Consumes(MediaType.APPLICATION_JSON)
public class UserResource {

    @EJB
    UserRepository userRepository;

    @EJB
    UserService userService;

    @EJB
    VerificationRepository verificationRepository;

    @GET
    @Path("/list")
    @Produces(MediaType.APPLICATION_JSON)
    public Response list(
            @DefaultValue("asc") @QueryParam("order") String order,
            @DefaultValue("10") @QueryParam("limit") int limit,
            @DefaultValue("0") @QueryParam("offset") int offset) {
        int page = offset / limit;
        Direction direction = (( order.equals("asc") ) ? Direction.ASCENDING : Direction.DESCENDING);
        List<User> userArrayList = userRepository.findAll("id", page, limit, direction);
        int count = userRepository.count();
        ResponseModel responseModel = new SuccessResponse();
        responseModel.setData(User.class, new Row<>(userArrayList, count));

        return Response.ok()
                .entity(responseModel).build();
    }

    @GET
    @Path("/{userId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response view(@NotNull @PathParam("userId") long userId){
        User user = userRepository.find(userId);

        ResponseModel responseModel = new SuccessResponse();
        responseModel.setData(User.class, user);

        return Response.ok().entity(responseModel).build();
    }

    @GET
    @Path("/phone/verification/{userId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response verifyPhone(@NotNull @PathParam("userId") long userId){
        ResponseModel responseModel = new ResponseModel();

        try{
            userService.userPhoneNumberVerification(userId);
        } catch (ApplicationException e) {
            e.printStackTrace();
            responseModel.setStatus(ResponseModel.Status.error);
            responseModel.setMessage(e.getMessage());

            return Response.ok()
                    .entity(responseModel)
                    .build();
        }
        responseModel.setStatus(ResponseModel.Status.success);

        return Response.ok().entity(responseModel).build();
    }

    @GET
    @Path("/phone/confirmation/{code}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response confirmPhone(@NotNull @PathParam("code") short code){
        ResponseModel responseModel = new ResponseModel();

        try {
            userService.userPhoneNumberConfirmation(code);
            responseModel.setStatus(ResponseModel.Status.success);
        } catch (ApplicationException e) {
            e.printStackTrace();
            responseModel.setStatus(ResponseModel.Status.error);
            responseModel.setMessage(e.getMessage());
        }

        return Response.ok().entity(responseModel).build();
    }

    @PUT
    @Path("/{userId}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response update(
            @NotNull @PathParam("userId") long userId, User user ){
        userRepository.merge(user);
        userRepository.flush();

        ResponseModel responseModel = new SuccessResponse();
        responseModel.setData(User.class, user);

        return Response.ok().entity(responseModel).build();
    }

    @GET
    @Path("/email/verification/{code}")
    public Response userEmailVerification(
            @NotNull @PathParam("code") long code){
        ResponseModel responseModel = new ResponseModel();
        try {
            userService.userEmailVerification(code);
        } catch (ApplicationException e) {
            e.printStackTrace();
            responseModel.setStatus(ResponseModel.Status.error);
            responseModel.setMessage(e.getMessage());

            return Response.ok()
                    .entity(responseModel)
                    .build();
        }

        responseModel.setStatus(ResponseModel.Status.success);

        return Response.ok().entity(responseModel)
                .build();
    }

    @GET
    @Path("/email/confirmation/{code}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response userEmailConfirmation(@NotNull @PathParam("code") short code){
        ResponseModel responseModel = new ResponseModel();

        try {
            userService.userEmailConfirmation(code);
            responseModel.setStatus(ResponseModel.Status.success);
        } catch (ApplicationException e) {
            e.printStackTrace();
            responseModel.setStatus(ResponseModel.Status.error);
            responseModel.setMessage(e.getMessage());
        }

        return Response.ok().entity(responseModel).build();
    }
}