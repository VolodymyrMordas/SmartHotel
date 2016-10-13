$(function() {

    $.hotel.model.order = Backbone.Model.extend({
        urlRoot: '/SmartHotel/v1/order/',
        parse : function(response, options){
            return response.data.order;
        }
    });

    $.hotel.model.apartment = Backbone.Model.extend({
        urlRoot: '/SmartHotel/v1/apartment/list',
        parse : function(response, options){
            console.log(response.data);
            return response.data.apartment;
        }
    });

    ///SmartHotel/v1/apartment/list?order=asc&limit=10&offset=0
});