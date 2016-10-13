$(function () {

    //$.hotel.view = {};

    $.hotel.view.billing = Backbone.View.extend({
        template: _.template($('#app-hotel-billing-tmpl').html()),
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

            $('#billing-upload').fileupload({
                url: $.hotel.BASE_URL + 'billing/upload',
                dataType: 'json',
                done: function (e, data) {
                    that.refreshTable(data.result.data);
                },
                progressall: function (e, data) {
                    var progress = parseInt(data.loaded / data.total * 100, 10);
                    $('#progress .progress-bar').css(
                        'width',
                        progress + '%'
                    );
                },
                fail: function (e, data) {
                    $.hotel.util.modal(data.jqXHR.responseJSON.message);
                }
            }).prop('disabled', !$.support.fileInput)
                .parent().addClass($.support.fileInput ? undefined : 'disabled');

            return this;
        },

        refreshTable: function (respData) {
            $('#billing-list').bootstrapTable({
                //url: '/SmartHotel/v1/apartment/list',
                data : respData.billing.rows,
                pagination: true,
                sidePagination : 'client',
                pageSize: $.hotel.ITEM_ON_PAGE,
                showRefresh: true,
                showToggle: true,
                showColumns: true,
                columns: [
                    {
                        field: 'order_id',
                        title: 'order_id'
                    }, {
                        field: 'amount',
                        title: 'amount'
                    }, {
                        field: 'currency_code',
                        title: 'currency',
                    }, {
                        field: 'payment_date',
                        title: 'Payment Date',
                    }]
            });
        }
    });
});