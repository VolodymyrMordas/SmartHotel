$(function () {

    console.log('offer view load');

    $.hotel.view.offer = Backbone.View.extend({
        template: _.template($('#app-hotel-list-tmpl').html()),
        tagName: "div",
        className: "row",
        orderId : null,
        events: {
            "click .icon": "open",
            "click .button.edit": "openEditDialog",
            "click .button.delete": "destroy"
        },

        initialize: function () {
        },

        contextFilter : null,

        render: function () {
            var tmpl = this.template;
            var pageWrapper = $('#offer-page');

            var p = new $.hotel.model.apartment();
            p.fetch({
                success: function (response) {
                    var data = response.toJSON();
                    pageWrapper.html(tmpl({apartment : data}));

                    this.contextFilter = new $.hotel.view.Filter({
                        el : $('#hotel-filter'),
                        filter : [
                            {
                                field : 'type',
                                type : 'select',
                                placeholder : 'Select Hotel',
                                multiple : true,
                                onChange : function(){
                                    //$('#user-table').bootstrapTable('refresh');
                                },
                                data : [
                                    {id : 1, text : 'test 1'},
                                    {id : 2, text : 'test 2'},
                                    {id : 3, text : 'test 3'},
                                    {id : 4, text : 'test 4'},
                                ]
                            }
                        ],
                        onChange : function(){
                            alert('on change');
                        }
                    });
                    this.contextFilter.render();

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

    var o = new $.hotel.view.offer();
    o.render();
});