$(function() {

    _.templateSettings = {
        interpolate: /\<\@\=(.+?)\@\>/gim,
        evaluate: /\<\@([\s\S]+?)\@\>/gim,
        escape: /\<\@\-(.+?)\@\>/gim
    };

    $.hotel = {
        ITEM_ON_PAGE : 10,
        BASE_URL : '/SmartHotel/v1/',
        order : {
            status : {
                0 : 'new order',
                1 : 'in process',
                2 : 'completed',
                3 : 'rejected'
            }
        }
    };

    $.hotel.view = {};
    $.hotel.model = {};


    $(window).bind("load resize", function() {
        topOffset = 50;
        width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
        if (width < 768) {
            $('div.navbar-collapse').addClass('collapse');
            topOffset = 100; // 2-row-menu
        } else {
            $('div.navbar-collapse').removeClass('collapse');
        }

        height = ((this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height) - 1;
        height = height - topOffset;
        if (height < 1) height = 1;
        if (height > topOffset) {
            $("#page-wrapper").css("min-height", (height) + "px");
        }
    });

    var url = window.location;
    var element = $('ul.nav a').filter(function() {
        return this.href == url || url.href.indexOf(this.href) == 0;
    }).addClass('active').parent().parent().addClass('in').parent();
    if (element.is('li')) {
        element.addClass('active');
    }

    // Context Side Filter *********************************************************************************************
    $.hotel.view.Filter = Backbone.View.extend({
        filter : {},
        initialize: function(options) {
            if(typeof options.filter == 'undefined'){
                throw new Error('couldn\'t init filter');
            }
            this.initFilter(options);
        },
        render : function(){
            return this;
        },
        prepareDom : function(val){
            var that = this;
            var element = this.$el;

            var divRow = $('<div/>')
                .addClass("row");
            var divCol = $('<div/>')
                .addClass('col-lg-12');

            if(val.type == 'select'){
                var input = $('<select />')
                    .addClass(val.field+'_il_view_filter')
                    .addClass('filter-element w100p');

                if((typeof val.multiple != 'undefined')
                    && val.multiple){
                    input.prop('multiple','multiple');
                }

                divCol.append(input);
                divRow.html(divCol);
                element.append(divRow);

                $('.' + val.field+'_il_view_filter').select2({
                    data : val.data,
                    placeholder : val.placeholder
                });

                $('.' + val.field+'_il_view_filter').on('select2:select', function () {
                    that.filter[val.field] = $(this).val();
                    val.onChange();
                });
                $('.' + val.field+'_il_view_filter').on('select2:unselect', function () {
                    that.filter[val.field] = $(this).val();
                    val.onChange();
                });
            }
            else if (val.type == 'input') {
                var input = $('<input type="text" placeholder="' + val.placeholder + '"/>')
                    .addClass(val.field + '_il_view_filter').addClass('filter-element form-control');
                input.on('change', function () {
                    that.filter[val.field] = $(this).val();
                    val.onChange();
                });
                divCol.append(input);
                divRow.html(divCol);
                element.append(divRow);
            }
            else if (val.type == 'hidden') {
                that.filter[val.field] = val.value;
                // var input = $('<input type="hidden" value="' + val.value + '" />')
                //     .addClass(val.field + '_il_view_filter').addClass('filter-element form-control');
                // divCol.append(input);
                // divRow.html(divCol);
                // element.append(divRow);
            }
            else if (val.type == 'daterange') {
                var datepickerOptions = {autoclose: true, format: 'yyyy-mm-dd'};
                var contName = val.field + '_il_view_filter';
                var tmpl = $(_.template($('#il-daterange').html())());
                tmpl.addClass(contName);

                divCol.append(tmpl);
                divRow.html(divCol);
                element.append(divRow);

                var elem = $('.' + contName);
                elem.find('.date-from').datepicker(datepickerOptions)
                    .on('changeDate clearDate', function (e) {
                        that.filter['date-from'] = e.date == undefined ? '' : new Date(e.date.valueOf());
                        val.onChange();
                    });
                elem.find('.date-to').datepicker(datepickerOptions)
                    .on('changeDate clearDate', function (e) {
                        that.filter['date-to'] = e.date == undefined ? '' : new Date(e.date.valueOf());
                        val.onChange();
                    });
            }
        },
        initFilter: function (options) {
            var that = this;
            that.filter = {}; // Some inheritance from first object occurs :(
            _.each(options.filter, function (val) {
                that.filter[val.field] = null;
                that.prepareDom(val);
            });
        },
        filterValues: function () {
            var params = {};
            _.each(this.filter, function (value, key) {
                if (value != null) {
                    params[key] = value;
                }
            });
            return params;
        }
    });

});