$(function () {

    var AppRouter = Backbone.Router.extend({
        routes: {
            "user/list":        "userList",
            "user/:id":         "userView",

            "hotel/list":       "hotelList",
            "hotel/staff":      "hotelStaff",
            "hotel/test":       "hotelTest",

            "hotel/:id":        "hotelView",

            "apartment/list":   "apartmentList",
            "apartment/:id":    "apartmentView",

            "logout":           "logout",
            "timeline":         "timeline",
            "billing" :         "billing",

            "order/list":       "orderList",
            "order/:id":        "orderView"
        }
    });

    $.hotel.Router = new AppRouter;

    $.hotel.Router.on('route:userList', function () {
        (new $.hotel.view.users()).render();
    });

    $.hotel.Router.on('route:orderList', function () {
        (new $.hotel.view.orders()).render();
    });

    $.hotel.Router.on('route:hotelList', function () {
        (new $.hotel.view.hotels()).render();
    });

    $.hotel.Router.on('route:hotelView', function (hotelId) {
        var p = new $.hotel.model.hotel({id : hotelId});
        p.fetch({
            success: function (response) {
                new $.hotel.view.hotel({
                    model : new $.hotel.model.hotel(response.toJSON()),
                    el : $('#page-wrapper')
                })
            }
        });
    });

    $.hotel.Router.on('route:apartmentView', function (id) {
        (new $.hotel.view.apartment(id)).render();
    });

    $.hotel.Router.on('route:apartmentList', function () {
        (new $.hotel.view.apartments()).render();
    });

    $.hotel.Router.on('route:logout', function () {
        $.hotel.util.modal('do logout');
    });

    $.hotel.Router.on('route:timeline', function () {
        var modal = (new $.hotel.util.modal('do timeline'));
        modal.show();
    });

    $.hotel.Router.on('route:billing', function () {
        (new $.hotel.view.billing()).render();
    });

    $.hotel.Router.on('route:userView', function (id) {
        (new $.hotel.view.user(id)).render();
    });

    $.hotel.Router.on('route:orderView', function (id) {
        (new $.hotel.view.order(id)).render();
    });

    $.hotel.Router.on('route:hotelTest', function () {
        var modal = (new $.hotel.util.modal('do hotel test'));
        modal.show();
    });

    $.hotel.Router.on('route:hotelStaff', function () {
        var modal = (new $.hotel.util.modal('do hotel staff'));
        modal.show();
    });

    Backbone.history.start();
});