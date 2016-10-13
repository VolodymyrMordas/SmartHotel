$(function () {

    //$.hotel.view = {};

    $.hotel.view.apartments = Backbone.View.extend({
        template: _.template($('#app-hotel-apartments-tmpl').html()),
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
            $('#apartment-list').bootstrapTable({
                url: '/SmartHotel/v1/apartment/list',
                pagination: true,
                sidePagination : 'server',
                pageSize: $.hotel.ITEM_ON_PAGE,
                onClickRow: function (row, el) {
                    $.il.Router.navigate('apartment/' + row.id, {trigger: true});
                },
                showRefresh: true,
                showToggle: true,
                showColumns: true,
                responseHandler : function(res){
                    return res.data.apartment;
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
                        field: 'email',
                        title: 'email'
                    }, {
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
                    }]
            });
        }
    });

    $.hotel.view.apartment = Backbone.View.extend({
        template: _.template($('#app-hotel-apartment-tmpl').html()),

        render: function () {
            var that = this;

            this.$el.html(
                this.template({
                    apartment : this.model.toJSON()
                })
            );
            $('#apartment-title').editable({
                success: function(response, newValue) {
                    that.model.set('title', newValue); //update backbone model
                    that.model.save({'title': newValue});
                }
            });

            $('#apartment-description').editable({
                success: function(response, newValue) {
                    that.model.set('description', newValue); //update backbone model
                    that.model.save({'description': newValue});
                }
            });


            this.refreshTable();
                //}
            //});

            return this;
        },

        refreshTable: function () {
            $('#apartment-list').bootstrapTable({
                url: '/SmartHotel/v1/hotel/'+this.buildingId+'/apartment/list',
                pagination: true,
                sidePagination : 'server',
                pageSize: $.hotel.ITEM_ON_PAGE,
                onClickRow: function (row, el) {
                    $.il.Router.navigate('apartment/' + row.id, {trigger: true});
                },
                showRefresh: true,
                showToggle: true,
                showColumns: true,
                responseHandler : function(res){
                    return res.data.apartment;
                },
                columns: [
                    { field: 'id', title: 'id' },
                    { field: 'title', title: 'title' },
                    { field: 'description', title: 'description' },
                    { field: 'current_price.price', title: 'current_price' },
                    { field: 'type', title: 'type' },
                    { field: 'status', title: 'status' }]
            });
        }
    });

});