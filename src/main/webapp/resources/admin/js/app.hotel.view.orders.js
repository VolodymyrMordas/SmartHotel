$(function () {

    //$.hotel.view = {};

    $.hotel.view.orderCreate = Backbone.View.extend({
        template: _.template($('#app-hotel-order-create-tmpl').html()),
        render: function () {
            return this;
        },
    });

    $.hotel.view.orders = Backbone.View.extend({
        template: _.template($('#app-hotel-orders-tmpl').html()),
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
            var that = this;
            var $pageWrapper = $('#page-wrapper');
            $pageWrapper.html(this.template());

            this.refreshTable();

            $('#hotel-create-order').on('click', function(e){
                alert('hola :)');
                //var newOrder = new $.hotel.view.orderCreate();
                //$.hotel.util.modal(newOrder.template());
                //that.refreshTable();
            });

            return this;
        },

        refreshTable: function () {
            $('#order-list').bootstrapTable({
                url: '/SmartHotel/v1/order/list',
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
                        field: 'user',
                        title: 'user',
                        formatter: function(value, row, index) {
                            return value.first_name + ' ' + value.last_name;
                        }
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
                        title: 'title'
                    }, {
                        field: 'start_at',
                        title: 'start_at'
                    }, {
                        field: 'end_at',
                        title: 'end_at'
                    }, /*{
                        field: 'type',
                        title: 'type'
                    }, */{
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

    $.hotel.view.order = Backbone.View.extend({
        template: _.template($('#app-hotel-order-tmpl').html()),
        tagName: "div",
        className: "row",
        orderId : null,
        events: {
            "click .icon": "open",
            "click .button.edit": "openEditDialog",
            "click .button.delete": "destroy"
        },

        initialize: function (id) {
            //this.listenTo(this.model, "change", this.render);
            this.orderId = id;
        },

        render: function () {
            var that = this;
            var tmpl = this.template;
            var $pageWrapper = $('#page-wrapper');

            var p = new $.hotel.model.order({id : this.orderId});
            p.fetch({
                success: function (response) {
                    var data = response.toJSON();
                    $pageWrapper.html(tmpl({order : data}));

                    that.renderTable(data.billing);

                    $('#order-title').editable({
                        type: 'text',
                        title: 'Enter order title',
                        success: function(response, newValue) {
                            p.set('title', newValue); //update backbone model
                            p.save({'title': newValue});
                        }
                    });

                    $('#order-start-at').editable({
                        format: 'yyyy-mm-dd hh:ii',
                        viewformat: 'yyyy-mm-dd hh:ii',
                        success: function(response, newValue) {
                            console.log(moment(newValue).format('YYYY-MM-DD HH:mm'));
                            p.set('start_at', moment(newValue).format('YYYY-MM-DD HH:mm')); //update backbone model
                            p.save({'start_at': moment(newValue).format('YYYY-MM-DD HH:mm')});
                        }
                    });

                    $('#order-end-at').editable({
                        format: 'yyyy-mm-dd hh:ii',
                        viewformat: 'yyyy-mm-dd hh:ii',
                        success: function(response, newValue) {
                            console.log(moment(newValue).format('YYYY-MM-DD HH:mm'));
                            p.set('end_at', moment(newValue).format('YYYY-MM-DD HH:mm')); //update backbone model
                            p.save({'end_at': moment(newValue).format('YYYY-MM-DD HH:mm')});
                        }
                    });

                    $('#order-building').editable({
                        select2: {
                            minimumResultsForSearch: -1,
                            ajax: {
                                dataType: 'json',
                                url: $.hotel.BASE_URL + 'hotel/list',
                                processResults: function (data, page) {
                                    var preparedData = [];
                                    $.each(data.data.building.rows, function(key,val){
                                        preparedData.push({id : val.id, text : val.title});
                                    });

                                    return {
                                        results: preparedData
                                    };
                                }
                            }
                        },
                        tpl: '<select style="width:150px;">',
                        type: 'select2',
                        success: function(response, newValue) {
                            var editable = $(this).data('editable');
                            var option = editable.input
                                .$input.find('option[value="VALUE"]'.replace('VALUE',newValue));
                            var newText = option.text();
                            $(this).attr('data-value', newValue);
                            $(this).text(newText);
                        },
                        display: function(value, sourceData ) {
                            console.log(sourceData);
                            console.log(value);
                            //set new text for xeditable field from php response
                            $(this).text(sourceData);
                        }
                    });

                    $('#order-apartment').editable({
                        select2: {
                            minimumResultsForSearch: -1,
                            ajax: {
                                dataType: 'json',
                                url: $.hotel.BASE_URL + 'apartment/list',
                                processResults: function (data, page) {
                                    var preparedData = [];
                                    $.each(data.data.apartment.rows, function(key,val){
                                        preparedData.push({id : val.id, text : val.title});
                                    });

                                    return {
                                        results: preparedData
                                    };
                                }
                            }
                        },
                        tpl: '<select style="width:150px;">',
                        type: 'select2',
                        success: function(response, newValue) {
                            var editable = $(this).data('editable');
                            var option = editable.input
                                .$input.find('option[value="VALUE"]'.replace('VALUE',newValue));
                            var newText = option.text();
                            $(this).attr('data-value', newValue);
                            $(this).text(newText);
                        },
                        display: function(value, sourceData ) {
                            console.log(sourceData);
                            console.log(value);
                            //set new text for xeditable field from php response
                            $(this).text(sourceData);
                        }
                    });
                }
            });

            return this;
        },
        renderTable : function(dataJson){
            $('#billing-list').bootstrapTable({
                data : dataJson,
                pagination: true,
                sidePagination : 'client',
                pageSize: $.hotel.ITEM_ON_PAGE,
                showRefresh: true,
                showToggle: true,
                showColumns: true,
                showFooter: true,
                columns: [
                    {
                        field: 'order_id',
                        title: 'order_id',
                        footerFormatter: function(data) {
                            return "";
                        }
                    }, {
                        field: 'amount',
                        title: 'amount',
                        footerFormatter: function(data) {
                            var moneyAmount = 0;
                            $.each( data, function( key, value ) {
                                moneyAmount += value.amount;
                            });
                            return '<nobr> ' + moneyAmount.toFixed(2) + '</nobr>';
                        }
                    },{
                        field: 'currency_code',
                        title: 'currency',
                        footerFormatter: function(data) {
                            return "";
                        }
                    }, {
                        field: 'payment_date',
                        title: 'Payment Date',
                        footerFormatter: function(data) {
                            return "";
                        }
                    }]
            });
        }
    });
});