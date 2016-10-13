$(function () {

    $.hotel.view.hotels = Backbone.View.extend({
        template: _.template($('#app-hotel-buildings-tmpl').html()),

        initialize: function () {
            this.listenTo(this.model, "change", this.render);
        },

        render: function () {
            var that = this;
            var $pageWrapper = $('#page-wrapper');
            $pageWrapper.html(this.template());
            this.refreshTable();

            $('#hotel-create-hotel').on('click', function(e){
                var newHotel = new $.hotel.view.hotelCreate();
                var modal = new $.hotel.util.modal(newHotel.template(), {
                        title : 'Create hotel',
                        buttons : [
                            {
                                title : 'Save',
                                onClick : function(){
                                    var loader = new $.hotel.util.loader();
                                    loader.show();

                                    var hotelModel = new $.hotel.model.hotel();
                                    var modelValues = newHotel.values();

                                    //modelValues['validate'] = true;
                                    //console.log(modelValues);
                                    hotelModel.on('error', function(model, error){
                                        console.log(error); // printing the error message on console.
                                    });
                                    hotelModel.save(modelValues,{
                                        success : function(){
                                            modal.hide();
                                            loader.hide();
                                            $('#building-list').bootstrapTable('refresh');
                                        },
                                        error : function(){
                                            loader.hide();
                                        }
                                    });
                                }
                            }
                        ],
                        onShowInit : function(){
                            var infoWindow = new google.maps.InfoWindow({map: map});
                            var latlng = new google.maps.LatLng(-34.397, 150.644);
                            var myOptions = {
                                zoom: 13,
                                center: latlng,
                                mapTypeId: google.maps.MapTypeId.ROADMAP
                            };

                            var map = new google.maps.Map(document.getElementById("map"),
                                myOptions);

                            google.maps.event.addListener(map, 'click', function(event) {
                                var marker = new google.maps.Marker({
                                    position: event.latLng,
                                    map: map,
                                    animation: google.maps.Animation.DROP,
                                    mapTypeId: google.maps.MapTypeId.TERRAIN
                                });

                                $('#hotelLatitude').val(event.latLng.lat());
                                $('#hotelLongitude').val(event.latLng.lng());

                                map.setCenter(event.latLng);
                            });

                            // Try HTML5 geolocation.
                            if (navigator.geolocation) {
                                navigator.geolocation.getCurrentPosition(function(position) {
                                    var pos = {
                                        lat: position.coords.latitude,
                                        lng: position.coords.longitude
                                    };

                                    infoWindow.setPosition(pos);
                                    infoWindow.setContent('Location found.');
                                    map.setCenter(pos);
                                }, function() {
                                    infoWindow.setPosition(map.getCenter());
                                    infoWindow.setContent(true ?
                                        'Error: The Geolocation service failed.' :
                                        'Error: Your browser doesn\'t support geolocation.');
                                    //handleLocationError(true, infoWindow, map.getCenter());
                                });
                            } else {
                                infoWindow.setPosition(map.getCenter());
                                infoWindow.setContent(false ?
                                    'Error: The Geolocation service failed.' :
                                    'Error: Your browser doesn\'t support geolocation.');
                                // Browser doesn't support Geolocation
                                //handleLocationError(false, infoWindow, map.getCenter());
                            }

                        }
                });

                modal.show();
            });

            return this;
        },

        refreshTable: function () {
            $('#building-list').bootstrapTable({
                url: '/SmartHotel/v1/hotel/list',
                pagination: true,
                sidePagination : 'server',
                pageSize: $.hotel.ITEM_ON_PAGE,
                //onClickRow: function (row, el) {
                //    $.hotel.Router.navigate('building/' + row.id, {trigger: true});
                //},
                showRefresh: true,
                showToggle: true,
                showColumns: true,
                responseHandler : function(res){
                    return res.data.building;
                },
                columns: [
                    {
                        field: 'id',
                        title: 'id'
                    }, {
                        field: 'title',
                        title: 'title'
                    }, {
                        field: 'description',
                        title: 'description'
                    },{
                        field: 'type',
                        title: 'type'
                    }, {
                        field: 'status',
                        title: 'status'
                    }, {
                        field: 'created_at',
                        title: 'created_at'
                    }, {
                        field: 'updated_at',
                        title: 'updated_at'
                    }, {
                        align: 'center',
                        valign: 'middle',
                        events: operateEvents,
                        formatter: function(value, row, index) {
                            return actionsHotelList(value, row, index);
                        }
                    }]
            });
        }
    });

    function actionsHotelList(){
        return [
            '<nobr><a class="view" href="javascript:void(0)" title="view">',
                '<i style="color: #2795e9;" class="glyphicon glyphicon-eye-open"></i>',
            '</a> &nbsp;',
            '<a class="edit" href="javascript:void(0)" title="edit">',
                '<i style="color: #eea236;" class="glyphicon glyphicon-edit"></i>',
            '</a> &nbsp;',
            '<a class="remove" href="javascript:void(0)" title="remove">',
                '<i style="color: #FF0000;" class="glyphicon glyphicon-remove"></i>',
            '</a></nobr>'
        ].join('')
    }

    window.operateEvents = {
        'click .complete': function (e, value, row, index) {
            var complete = new $.hotel.model.TransactionComplete({'id' : row.transaction.id});
            complete.fetch({
                success: function (response) {
                    accountTransaction.render();
                },
                error : function (a,b) {
                    var error = $.parseJSON(b.responseText);
                    $.il.util.appModal(error.exception.message);
                }
            });
        },
        'click .view' : function(e, value, row, index){
            $.hotel.Router.navigate('hotel/' + row.id, {trigger: true});
        },
        'click .edit' : function(e, value, row, index){
            $.hotel.Router.navigate('hotel/' + row.id, {trigger: true});
        },
        'click .remove': function (e, value, row, index) {
            var hotelModel = new $.hotel.model.hotel(row);
            hotelModel.destroy({
                success: function(row, response) {
                    $('#building-list').bootstrapTable('remove', {
                        field: 'id', values: [row.id]
                    });
                }
            });
        }
    };

    $.hotel.view.hotelCreate = Backbone.View.extend({
        template: _.template($('#app-hotel-create-tmpl').html()),
        render: function () {
            return this;
        },
        initialize : function(){
            console.log('hotelCreate initialize');
        },
        values : function(){
            var result = {};
            $.each($("#app-hotel-form-create-hotel")
                    .find("[data-form-field*='hotel']"), function(k,v){

                result[$(v).attr('name')] = $(v).val();
            });
            return result;
        }
    });

    $.hotel.view.hotelApartment = Backbone.View.extend({
        template: _.template($('#app-hotel-create-apartment-tmpl').html()),
        render : function(){
            return this;
        },
        values : function(){
            var result = {};
            $.each($("#app-hotel-form-create-apartment")
                .find("[data-form-field*='hotel']"), function(k,v){

                result[$(v).attr('name')] = $(v).val();
            });
            return result;
        }
    });

    $.hotel.view.hotelMap = Backbone.View.extend({
        template: _.template($('#app-hotel-map-tmpl').html()),
        inited : null,
        render: function () {
            return this;
        },
        initialize : function(opt){
            this.inited = opt;
        },
        values : function(){
            var that = this.inited;

            console.log(this.inited);
            $.each($("#app-hotel-form-map-hotel")
                .find("[data-form-field*='hotel']"), function(k,v){

                that[$(v).attr('name')] = $(v).val();
            });

            return this.inited;
        }
    });

    $.hotel.view.hotel = Backbone.View.extend({
        template: _.template($('#app-hotel-building-tmpl').html()),
        events: {
            "click #hotel-create-apartment" : 'createApartment'
        },

        initUploadWidget : function(){
            new $.hotel.util.uploadWidget({
                title : 'title upload widget',
                el : $('#app-hotel-upload-images')
            });
        },

        initialize: function () {
            this.model.on('change', this.saveModel, this);
            this.render();
        },

        saveModel : function(){
            var that = this;
            var loader = new $.hotel.util.loader();
            this.model.save(this.model.toJSON(),{
                success : function(){
                    loader.hide();
                    that.render();
                },
                error : function(){
                    loader.hide();
                }});
        },

        createApartment : function(){
            var that = this;
            var newApartment = new $.hotel.view.hotelApartment();
            var modal = new $.hotel.util.modal( newApartment.template(
                    { building : this.model.toJSON() }), {
                title : 'Create apartment',
                buttons : [
                    {
                        title : 'Save',
                        onClick : function(){
                            var loader = new $.hotel.util.loader();
                            loader.show();

                            var apartmentModel = new $.hotel.model.apartment();
                            var modelValues = newApartment.values();
                            console.log(modelValues)

                            apartmentModel.on('error', function(model, error){
                                console.log(error); // printing the error message on console.
                            });
                            apartmentModel.save(modelValues,{
                                success : function(){
                                    modal.hide();
                                    loader.hide();
                                    that.render();
                                },
                                error : function(){
                                    loader.hide();
                                }
                            });
                        }
                    }
                ],
                onShowInit : function(){

                }
            });

            modal.show();
    },

        render: function () {
            var that = this;

            this.$el.html(
                this.template({
                    building: this.model.toJSON()
                })
            );

            this.initUploadWidget();

            var viewMap = new google.maps.Map(
                document.getElementById("hotel-view-map"),
                {
                    zoom: 13,
                    center: new google.maps.LatLng(this.model.get('lat'), this.model.get('lng')),
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                });

            new google.maps.Marker({
                position: new google.maps.LatLng(this.model.get('lat'), this.model.get('lng')),
                map: viewMap,
                animation: google.maps.Animation.DROP,
                mapTypeId: google.maps.MapTypeId.TERRAIN
            });

            $('#building-title').editable({
                success: function(response, newValue) {
                    that.model.set('title', newValue);
                }
            });

            $('#building-description').editable({
                success: function(response, newValue) {
                    that.model.set('description', newValue);
                }
            });

            $('#building-location').on('click', function(e){
                e.preventDefault();

                var editHotelMap = new $.hotel.view.hotelMap(that.model.toJSON());
                var modal = new $.hotel.util.modal(editHotelMap.template(), {
                    title : 'Edit Hotel Latitude / Longitude',
                    buttons : [
                        {
                            title : 'Save',
                            onClick : function(){
                                that.model.set(editHotelMap.values());
                                modal.hide();
                            }
                        }
                    ],
                    onShowInit : function(){

                        $('#hotelLatitude').val(that.model.get('lat'));
                        $('#hotelLongitude').val(that.model.get('lng'));

                        var latlng = new google.maps.LatLng(that.model.get('lat'), that.model.get('lng'));
                        var myOptions = {
                            zoom: 13,
                            center: latlng,
                            mapTypeId: google.maps.MapTypeId.ROADMAP
                        };

                        var map = new google.maps.Map(document.getElementById("hotel-map"),
                            myOptions);

                        new google.maps.Marker({
                            position: latlng,
                            map: map,
                            animation: google.maps.Animation.DROP,
                            mapTypeId: google.maps.MapTypeId.TERRAIN
                        });

                        google.maps.event.addListener(map, 'click', function(event) {
                            var marker = new google.maps.Marker({
                                position: event.latLng,
                                map: map,
                                animation: google.maps.Animation.DROP,
                                mapTypeId: google.maps.MapTypeId.TERRAIN
                            });

                            $('#hotelLatitude').val(event.latLng.lat());
                            $('#hotelLongitude').val(event.latLng.lng());

                            map.setCenter(event.latLng);
                        });
                    }
                });

                modal.show();
            });

            this.refreshTable();

            return this;
        },

        refreshTable: function () {
            var that = this;
            $('#apartment-list').bootstrapTable({
                url: '/SmartHotel/v1/hotel/'+this.model.id+'/apartment/list',
                pagination: true,
                sidePagination : 'server',
                pageSize: $.hotel.ITEM_ON_PAGE / 2,
                onClickRow: function (row, el) {
                    var apartment = new $.hotel.view.apartment({
                        model : new $.hotel.model.apartment(row),
                        el : $('#apartment-view')
                    });
                    apartment.render();
                },
                showRefresh: true,
                showToggle: true,
                showColumns: true,
                responseHandler : function(res){
                    return res.data.apartment;
                },
                columns: [
                    { field: 'number', title: '#' },
                    { field: 'title', title: 'title'},
                    { field: 'description', title: 'description' },
                    { field: 'current_price.price', title: 'current_price' },
                    { field: 'type', title: 'type' },
                    { field: 'status', title: 'status' },
                    {
                        align: 'center',
                        valign: 'middle',
                        //events: operateEvents,
                        formatter: function(value, row, index) {
                            return that.actionsHotelList(value, row, index);
                        }
                    }
                ]
            });
        },

        actionsHotelList : function(){
            return ['<a class="remove" href="javascript:void(0)" title="remove">',
                    '<i style="color: #FF0000;" class="glyphicon glyphicon-remove"></i>',
                    '</a>'
                ].join('')
        }
    });
});