$(function () {

    $.hotel.view.test = Backbone.View.extend({
        template: _.template($('#app-hotel-test-tmpl').html()),
        events: {
            //"click #hotel-create-apartment" : 'createApartment'
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

        render: function () {
            var that = this;

            this.$el.html(
                this.template({
                    building: this.model.toJSON()
                })
            );

            this.initUploadWidget();

            return this;
        }
    });
});