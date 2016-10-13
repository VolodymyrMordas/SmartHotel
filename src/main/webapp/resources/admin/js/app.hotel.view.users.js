$(function () {

    //$.hotel.view = {};

    $.hotel.view.users = Backbone.View.extend({
        template: _.template($('#app-hotel-users-tmpl').html()),
        tagName: "div",
        className: "row",

        events: {
            "click .icon": "open",
            "click .button.edit": "openEditDialog",
            "click .button.delete": "destroy"
        },

        initialize: function () {
            this.listenTo(this.model, "change", this.render);
        },

        render: function () {
            var $pageWrapper = $('#page-wrapper');
            $pageWrapper.html(this.template());
            this.refreshTable();
            return this;
        },

        refreshTable: function () {
            $('#user-list').bootstrapTable({
                url: $.hotel.BASE_URL + 'user/list',
                pagination: true,
                sidePagination : 'server',
                pageSize: $.hotel.ITEM_ON_PAGE,
                onClickRow: function (row, el) {
                    $.hotel.Router.navigate('user/' + row.id, {trigger: true});
                },
                showRefresh: true,
                showToggle: true,
                showColumns: true,
                responseHandler : function(res){
                    return res.data.user;
                },
                columns: [
                    {
                        field: 'id',
                        title: 'id'
                    }, {
                        field: 'first_name',
                        title: 'first_name'
                    }, {
                        field: 'last_name',
                        title: 'last_name'
                    }, {
                        field: 'phone',
                        title: 'phone',
                    }, {
                        field: 'phone_verified',
                        title: 'phone_verified',
                        align: 'center',
                        valign: 'middle',
                        //events: operateEvents,
                        formatter: function(value, row, index) {
                            return validatePhone(value, row, index);
                        }
                    }, {
                        field: 'email',
                        title: 'email'
                    }, {
                        field: 'email_verified',
                        title: 'email_verified',
                        align: 'center',
                        valign: 'middle',
                        formatter: function(value, row, index) {
                            return validateEmail(value, row, index);
                        }
                    }, /*{
                        field: 'type',
                        title: 'type'
                    }, {
                        field: 'status',
                        title: 'status'
                    },*/ {
                        field: 'created_at',
                        title: 'created_at'
                    }, {
                        field: 'updated_at',
                        title: 'updated_at'
                    }]
            });
        }
    });

    function validatePhone(val){
        var iconClass = 'glyphicon-check';
        var iconColor = '#3f903f';

        if(!val){
            iconClass = 'glyphicon-unchecked';
            iconColor = '#f00';
        }

        var tmpl = [
            '<i style="color: '+iconColor+';" class="glyphicon '+iconClass+'"></i>'
        ].join('');

        return tmpl;
    }

    function validateEmail(val){
        var iconClass = 'glyphicon-check';
        var iconColor = '#3f903f';

        if(!val){
            iconClass = 'glyphicon-unchecked';
            iconColor = '#f00';
        }

        var tmpl = [
            '<i style="color: '+iconColor+';" class="glyphicon '+iconClass+'"></i>'
        ].join('');

        return tmpl;
    }

    $.hotel.view.user = Backbone.View.extend({
        template: _.template($('#app-hotel-user-tmpl').html()),
        tagName: "div",
        className: "row",
        userId : null,
        events: {
            "click .icon": "open",
            "click .button.edit": "openEditDialog",
            "click .button.delete": "destroy"
        },

        initialize: function (id) {
            //this.listenTo(this.model, "change", this.render);
            this.userId = id;
        },

        render: function () {
            var that = this;
            var tmpl = this.template;
            var $pageWrapper = $('#page-wrapper');

            var p = new $.hotel.model.user({id : this.userId});
            p.fetch({
                success: function (response) {
                    var data = response.toJSON();
                    $pageWrapper.html(tmpl({'user' : data}));

                    that.refreshTable(that.userId);

                    $('#first-name').editable({
                        type: 'text',
                        title: 'Enter username',
                        success: function(response, newValue) {
                            p.set('first_name', newValue); //update backbone model
                            p.save({'first_name': newValue});
                        }
                    });
                    $('#last-name').editable({
                        type: 'text',
                        title: 'Enter username',
                        success: function(response, newValue) {
                            p.set('last_name', newValue); //update backbone model
                            p.save({'last_name': newValue});
                        }
                    });
                    $('#phone').editable({
                        type: 'text',
                        title: 'Enter phone number',
                        success: function(response, newValue) {
                            p.set('phone', newValue); //update backbone model
                            p.save({'phone': newValue});
                        }
                    });
                    $('#email').editable({
                        type: 'text',
                        title: 'Enter email',
                        success: function(response, newValue) {
                            p.set('email', newValue); //update backbone model
                            p.save({'email': newValue});
                        }
                    });

                    $('#phone-verification').on('click', function(e){
                        e.preventDefault();
                        var pp = new $.hotel.model.userPhone({id : that.userId});
                        var loader = new $.hotel.util.loader();
                        loader.show();
                        pp.fetch({
                            success: function (response) {
                                loader.hide();
                                $.hotel.util.modal("success");
                            },
                            processData: true,
                            error: function(){
                                loader.hide();
                                $.hotel.util.modal("error");
                            }
                        });
                    });

                    $('#email-verification').on('click', function(e){
                        e.preventDefault();
                        var pp = new $.hotel.model.userEmail({id : that.userId});
                        var loader = new $.hotel.util.loader();
                        loader.show();
                        pp.fetch({
                            success: function (response) {
                                loader.hide();
                                $.hotel.util.modal("success");
                            }
                        });
                    });
                }
            });


            return this;
        },

        refreshTable: function (userId) {
            $('#user-order-list').bootstrapTable({
                url: '/SmartHotel/v1/order/user/' + userId,
                pagination: true,
                sidePagination : 'server',
                pageSize: $.hotel.ITEM_ON_PAGE,
                onClickRow: function (row, el) {
                    $.hotel.Router.navigate('order/' + row.id, {trigger: true});
                },
                showRefresh: true,
                showToggle: true,
                showColumns: true,
                responseHandler : function(res){
                    return res.data.order;
                },
                columns: [
                    {
                        field: 'id',
                        title: 'id'
                    }, {
                        field: 'building',
                        title: 'building',
                        formatter: function(value, row, index) {
                            return value.title;
                        }
                    }, {
                        field: 'apartment',
                        title: 'apartment',
                        formatter: function(value, row, index) {
                            if(typeof value == 'undefined'){
                                return '';
                            }
                            return value.title;
                        }
                    }, {
                        field: 'title',
                        title: 'title',
                    }, {
                        field: 'start_at',
                        title: 'start_at'
                    }, {
                        field: 'end_at',
                        title: 'end_at'
                    }, {
                        field: 'status',
                        title: 'status',
                        formatter: function(value, row, index) {
                            return $.hotel.order.status[value];
                        }
                    }, {
                        field: 'created_at',
                        title: 'created_at'
                    }, {
                        field: 'updated_at',
                        title: 'updated_at'
                    }]
            });
        }
    });
});