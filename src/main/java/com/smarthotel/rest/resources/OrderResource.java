package com.smarthotel.rest.resources;

import com.smarthotel.ejb.repository.OrderRepository;
import com.smarthotel.entities.Order;
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

@Path(value = "order")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class OrderResource {

    @EJB
    OrderRepository orderRepository;

    @GET
    @Path("/list/")
    @Produces(MediaType.APPLICATION_JSON)
    public Response list(
            @DefaultValue("asc") @QueryParam("order") String order,
            @DefaultValue("10") @QueryParam("limit") int limit,
            @DefaultValue("0") @QueryParam("offset") int offset) {
        int page = offset / limit;
        Direction direction = (( order.equals("asc") ) ? Direction.ASCENDING : Direction.DESCENDING);
        List<Order> orderArrayList = orderRepository.findAll("id", page, limit, direction);

        ResponseModel responseModel = new SuccessResponse();
        responseModel.setData(Order.class, new Row<>(orderArrayList, orderRepository.count()));

        return Response.ok()
                .entity(responseModel).build();
    }

    @GET
    @Path("/{orderId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response view(@NotNull @PathParam("orderId") long orderId){
        Order order = orderRepository.find(orderId);

        ResponseModel responseModel = new SuccessResponse();
        responseModel.setData(Order.class, order);

        return Response.ok().entity(responseModel).build();
    }

    @GET
    @Path("/user/{userId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response userOrderList(
            @NotNull @PathParam("userId") long userId,
            @DefaultValue("asc") @QueryParam("order") String sort,
            @DefaultValue("10") @QueryParam("limit") int limit,
            @DefaultValue("0") @QueryParam("offset") int offset){

        int page = offset / limit;
        //Direction direction = (( sort.equals("asc") ) ? Direction.ASCENDING : Direction.DESCENDING);

        List<Order> orderList = orderRepository.findByUserId(userId, page, limit);

        ResponseModel responseModel = new SuccessResponse();
        responseModel.setData(Order.class, new Row<>(orderList, orderRepository.count()));

        return Response.ok().entity(responseModel).build();
    }

    @PUT
    @Path("/{orderId}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response update(
            @NotNull @PathParam("userId") long orderId, Order order ){
        orderRepository.merge(order);
        orderRepository.flush();

        ResponseModel responseModel = new SuccessResponse();
        responseModel.setData(Order.class, order);

        return Response.ok().entity(responseModel).build();
    }
}