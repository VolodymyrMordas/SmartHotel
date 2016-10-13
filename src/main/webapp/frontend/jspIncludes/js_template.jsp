<%--
  Created by IntelliJ IDEA.
  User: volodymyrmordas
  Date: 7/1/16
  Time: 4:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script id="app-hotel-list-tmpl" type="text/template">
    <div class="row carousel-holder">

        <div class="col-md-12">
            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                </ol>
                <div class="carousel-inner">
                    <div class="item active">
                        <img class="slide-image" src="<c:url value="/resources/frontend/images/mini-hotel-tmpl.jpg"/>"
                             alt="">
                    </div>
                </div>
                <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left"></span>
                </a>
                <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right"></span>
                </a>
            </div>
        </div>

    </div>

    <div class="row">
        <@ _.each(apartment.rows, function(val, key){ @>
            <div class="col-sm-4 col-lg-4 col-md-4">
                <div class="thumbnail">
                    <@= val.media[0].uri @>
                    <@ if(val.media != 'undefined') {@>
                        <img src="<c:url value="/resources/frontend/images/"/><@= val.media[0].filename @>" alt="">
                    <@ } @>
                    <div class="caption">
                        <h4 class="pull-right">$ <@= val.current_price.price @></h4>
                        <h4>
                            <a href="<c:url value="/order/item?<@= val.id @>"/>"><@= val.title @></a>
                        </h4>

                        <p><@= val.description @></p>
                    </div>
                    <div class="ratings">
                        <p class="pull-right"><@= val.id @> reviews</p>

                        <p>
                            <span class="glyphicon glyphicon-star"></span>
                            <span class="glyphicon glyphicon-star"></span>
                            <span class="glyphicon glyphicon-star"></span>
                            <span class="glyphicon glyphicon-star"></span>
                            <span class="glyphicon glyphicon-star"></span>
                        </p>
                    </div>
                </div>
            </div>
        <@ }); @>
    </div>

</script>
