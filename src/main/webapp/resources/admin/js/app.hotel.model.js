$(function() {

    $.hotel.model = {};

    $.hotel.model.user = Backbone.Model.extend({
        urlRoot: '/SmartHotel/v1/user/',
        parse : function(response, options){
            return response.data.user;
        }
    });

    $.hotel.model.order = Backbone.Model.extend({
        urlRoot: '/SmartHotel/v1/order/',
        parse : function(response, options){
            return response.data.order;
        }
    });

    $.hotel.model.hotel = Backbone.Model.extend({
        urlRoot: '/SmartHotel/v1/hotel/',
        parse : function(response, options){
            return response.data.building;
        },
        validate: function(attrs, options) {
            console.log('hotel model validation');
            console.log(attrs);
            if ((attrs.title == '') || (attrs.title == null)) {
                console.log(attrs.title);
                return "not null or empty";
            }
        }
    });

    //$.hotel.model.apartment = Backbone.Model.extend({
    //    urlRoot: '/SmartHotel/v1/apartment',
    //    parse : function(response, options){
    //        return response.data.apartment;
    //    },
    //    validate: function(attrs, options) {
    //        console.log('hotel model apartment');
    //        console.log(attrs);
    //        if ((attrs.title == '') || (attrs.title == null)) {
    //            console.log(attrs.title);
    //            return "not null or empty";
    //        }
    //    }
    //});

    $.hotel.model.apartment = Backbone.Model.extend({
        urlRoot: '/SmartHotel/v1/apartment',
        parse : function(response, options){
            return response.data.apartment;
        },
        validate: function(attrs, options) {
            console.log('hotel model apartment');
            console.log(attrs);
            if ((attrs.title == '') || (attrs.title == null)) {
                console.log(attrs.title);
                return "not null or empty";
            }
        }
    });

    $.hotel.model.userPhone = Backbone.Model.extend({
        urlRoot: '/SmartHotel/v1/user/phone/verification/',
        parse : function(response, options){
            return response.data;
        }
    });

    $.hotel.model.userEmail = Backbone.Model.extend({
        urlRoot: '/SmartHotel/v1/user/email/verification/',
        parse : function(response, options){
            return response.data;
        }
    });
});