$(function() {

    $.hotel.util = {};

    $.hotel.util.modal = Backbone.View.extend({
        initialize : function(text, opt){
            $.hotel.util.modal.defaults = {
            }

            if(typeof opt == 'undefined'){
                opt = {};
            }

            $.extend(opt, $.hotel.util.modal.defaults);

            var divModal = $('<div />').addClass('modal fade')
                .attr('role', 'dialog').attr('tabindex', '-1')
                .attr('aria-labelledby', 'gridSystemModalLabel');
            var divModelDialog = $('<div />').addClass('modal-dialog');
            var divModalContent = $('<div/>').addClass('modal-content');
            var divModalBody = $('<div />').addClass('modal-body')
                .html(text);

            if (opt.title != null) {
                var divModalHeader = $('<div />')
                    .addClass('modal-header');
                var h4ModalTitle = $('<h4/>').addClass('modal-title').html(opt.title);
                divModalHeader.append(h4ModalTitle);
                divModalContent.append(divModalHeader);
            }

            divModalContent
                .append(divModalBody);

            if(opt.buttons != null){
                var divModalFooter = $('<div />').addClass('modal-footer');
                $.each(opt.buttons, function(key, value){
                    var button = $('<button/>');

                    $.extend(value,{
                        class : 'btn btn-default',
                    });

                    button.addClass(value.class).html(value.title);
                    if(typeof value.onClick != 'undefined'){
                        button.on('click', value.onClick);
                    }

                    divModalFooter.append(button);
                });
                divModalContent.append(divModalFooter);
            }

            divModelDialog
                .append(divModalContent);
            divModal
                .append(divModelDialog);

            //divModal.modal('show');
            this.modal = divModal;

            divModal.on('shown.bs.modal', opt.onShowInit);
            return this;
        },
        modal : null,
        show : function(){
            this.modal.modal('show');

            //var latlng = new google.maps.LatLng(-34.397, 150.644);
            //var myOptions = {
            //    zoom: 8,
            //    center: latlng,
            //    mapTypeId: google.maps.MapTypeId.ROADMAP
            //};
            //
            //var map = new google.maps.Map(document.getElementById("map"),
            //    myOptions);
        },
        hide : function(){
            this.modal.modal('hide');
        },
    });

    $.hotel.util.loader = Backbone.View.extend({
        ldr : null,
        show : function(){
            this.ldr.modal('show')
        },
        initialize: function () {
        },
        hide : function(){
            this.ldr.modal('hide')
        },
        initialize: function () {
            var divModal = $('<div />').addClass('modal fade modal-white')
                .attr('role', 'dialog').attr('tabindex', '-1')
                .attr('aria-labelledby', 'gridSystemModalLabel');
            var divModalContent = $('<div />').addClass('loader');
            divModal
                .append(divModalContent);

            this.ldr = divModal;
            return this;
        }
    });

    $.hotel.util.uploadWidget = Backbone.View.extend({
        template: _.template($('#app-hotel-upload-widget-tmpl').html()),

        opt : {
            data : [
                {
                    url : 'http://localhost:8080/SmartHotel/resources/frontend/images/hotel-1-apartmant-2.jpg'
                },{
                    url : 'http://localhost:8080/SmartHotel/resources/frontend/images/hotel-1-apartmant-1.jpg'
                }
            ]
        },
        events : {
            "click #app-hotel-upload-widget": 'openUploader'
        },

        openUploader : function(){
            $('[name="apartment-files"]')
                .trigger("click");
        },
        initialize : function(opt){
            console.log('initialize upload widget');
            $.extend(this.opt, opt);
            this.render();
        },
        render : function(){

            this.$el.html(
                this.template(this.opt)
            );

            return this;
        }
    });

});