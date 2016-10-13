<%--
  Created by IntelliJ IDEA.
  User: volodymyrmordas
  Date: 6/7/16
  Time: 4:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script id="app-hotel-users-tmpl" type="text/template">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Users</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="table-responsive" id="user-list">

            </div>
        </div>
    </div>
</script>

<script id="app-hotel-user-tmpl" type="text/template">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <@= user.first_name @> <@= user.last_name @>
            </h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel-body table-responsive" id="user-view">
                <table class="table table-striped table-hover">
                    <tbody>
                    <tr>
                        <th class="col-lg-3">First name</th>
                        <td>
                            <a href="#" id="first-name" data-type="text" data-pk="<@= user.id @>" data-mode="inline"
                               data-original-title="Enter First Name">
                                <@= user.first_name @>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <th class="col-lg-3">Last name</th>
                        <td>
                            <a href="#" id="last-name" data-type="text" data-pk="<@= user.id @>" data-mode="inline"
                               data-original-title="Enter Last Name">
                                <@= user.last_name @>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <th class="col-lg-3">Phone #.</th>
                        <td>

                            <a href="#" id="phone" data-type="text" data-pk="<@= user.id @>" data-mode="inline"
                               data-original-title="Enter phone number">
                                <@= user.phone @>
                            </a> &nbsp;
                            <@ if(!user.phone_verified && user.phone != '' && user.phone != null) { @>
                            <a href="#" id="phone-verification" class="btn btn-info">
                                Send confirmation sms
                            </a>
                            <@ } @>
                        </td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td>
                            <a href="#" id="email" data-type="text" data-pk="<@= user.id @>" data-mode="inline"
                               data-original-title="Enter phone number">
                                <@= user.email @>
                            </a> &nbsp;
                            <@ if(!user.email_verified && user.email != '' && user.email != null) { @>
                            <a href="#" id="email-verification" class="btn btn-info">
                                Send confirmation email
                            </a>
                            <@ } @>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="table-responsive" id="user-order-list">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</script>

<script id="app-hotel-orders-tmpl" type="text/template">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Orders</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="btn-group" role="group" aria-label="test">
                <button type="button" class="btn btn-default" id="hotel-create-order">Create Order</button>
            </div>
        </div>
        <div class="col-lg-12">

            <div class="table-responsive" id="order-list">

            </div>
        </div>
    </div>
</script>



<script id="app-hotel-order-create-tmpl" type="text/template">
    <div class="row">
        <div class="col-lg-12 order-create">
            <form>
                <div class="form-group">
                    <label for="exampleInputEmail1">Email address</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Email">
                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">Password</label>
                    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                </div>
                <div class="form-group">
                    <label for="exampleInputFile">File input</label>
                    <input type="file" id="exampleInputFile">
                    <p class="help-block">Example block-level help text here.</p>
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox"> Check me out
                    </label>
                </div>
                <button type="submit" class="btn btn-default">Submit</button>
            </form>
        </div>
    </div>
</script>

<script id="app-hotel-order-tmpl" type="text/template">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <@= order.title @>
            </h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel-body table-responsive" id="order-view">
                <table class="table table-striped table-hover">
                    <tbody>
                    <tr>
                        <th class="col-lg-3">title</th>
                        <td>
                            <a href="#" id="order-title" data-type="text" data-pk="<@= order.id @>" data-mode="inline"
                               data-original-title="Enter Title">
                                <@= order.title @>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <th class="col-lg-3">user</th>
                        <td>
                            <@= order.user.first_name @> <@= order.user.last_name @>
                        </td>
                    </tr>
                    <tr>
                        <th class="col-lg-3">building</th>
                        <td>
                            <a href="#" id="order-building" data-type="select2" data-pk="<@= order.id @>">
                                <@= order.building.title @>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <th>apartment</th>
                        <td>

                            <a href="#" id="order-apartment" data-type="select2" data-pk="<@= order.id @>">
                                <@= order.apartment.title @>
                            </a>
                        </td>
                    </tr>

                    <tr>
                        <th>period</th>
                        <td>
                            <a href="#" id="order-start-at" data-type="datetime" data-pk="<@= order.id @>">
                                <@= order.start_at @>
                            </a> - <a href="#" id="order-end-at" data-type="datetime" data-pk="<@= order.id @>">
                            <@= order.end_at @>
                        </a></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="table-responsive">
                    <div class="table-responsive" id="billing-list">

                    </div>
                </div>
            </div>
        </div>
    </div>
</script>

<script id="app-hotel-buildings-tmpl" type="text/template">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Hotels</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="btn-group" role="group" aria-label="test">
                <button type="button" class="btn btn-default" id="hotel-create-hotel">Create Hotel</button>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="table-responsive">
                <div class="table-responsive" id="building-list">

                </div>
            </div>
        </div>
    </div>
</script>

<script id="app-hotel-create-tmpl" type="text/template">
    <div class="row">
        <div class="col-lg-12">
            <form id="app-hotel-form-create-hotel">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="form-group">
                            <label for="hotelTitle">Title</label>
                            <input data-form-field="hotel-title" type="text" name="title" class="form-control" id="hotelTitle" placeholder="Title">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="form-group">
                            <label for="hotelDescription">Description</label>
                            <textarea data-form-field="hotel-description" name="description" class="form-control" id="hotelDescription" placeholder="Description" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div id="map"></div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="hotelLatitude">Latitude</label>
                            <input disabled data-form-field="hotel-latitude" name="lat" type="text" class="form-control" id="hotelLatitude" placeholder="Latitude">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="hotelLongitude">Longitude</label>
                            <input disabled data-form-field="hotel-longitude" name="lng" type="text" class="form-control" id="hotelLongitude" placeholder="Longitude">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="hotelStatus">Status</label>
                            <input data-form-field="hotel-status" name="status" type="number" class="form-control" id="hotelStatus" placeholder="Status">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="hotelType">Type</label>
                            <input data-form-field="hotel-type" name="type" type="number" class="form-control" id="hotelType" placeholder="Type">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</script>

<script id="app-hotel-create-apartment-tmpl" type="text/template">
    <div class="row">
        <div class="col-lg-12">
            <form id="app-hotel-form-create-apartment">
                <input data-form-field="hotel-building-id" type="hidden" name="building_id" class="form-control" id="buildingId" value="<@- building.id @>">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="form-group">
                            <label for="hotelTitle">Title</label>
                            <input data-form-field="hotel-apartment-title" type="text" name="title" class="form-control" id="apartmentTitle" placeholder="Title">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="form-group">
                            <label for="apartmentDescription">Description</label>
                            <textarea data-form-field="hotel-apartment-description" name="description" class="form-control" id="apartmentDescription" placeholder="Description" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3">
                        <div class="form-group">
                            <label for="apartmentNumber">Number</label>
                            <input data-form-field="hotel-apartment-number" name="number" type="text" class="form-control" id="apartmentNumber" placeholder="Number">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="apartmentStatus">Status</label>
                            <input data-form-field="hotel-apartment-status" name="status" type="number" class="form-control" id="apartmentStatus" placeholder="Status">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="apartmentType">Type</label>
                            <input data-form-field="hotel-apartment-type" name="type" type="number" class="form-control" id="apartmentType" placeholder="Type">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</script>

<script id="app-hotel-map-tmpl" type="text/template">
    <div class="row">
        <div class="col-lg-12">
            <form id="app-hotel-form-map-hotel">

                <div class="row">
                    <div class="col-lg-12">
                        <div id="hotel-map"></div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="hotelLatitude">Latitude</label>
                            <input disabled data-form-field="hotel-latitude" name="lat" type="text" class="form-control" id="hotelLatitude" placeholder="Latitude">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label for="hotelLongitude">Longitude</label>
                            <input disabled data-form-field="hotel-longitude" name="lng" type="text" class="form-control" id="hotelLongitude" placeholder="Longitude">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</script>

<script id="app-hotel-building-tmpl" type="text/template">
    <div class="row">
        <div class="col-lg-12">
            <%--<h1 class="page-header">--%>
                <%--<@= building.title @>--%>
                    &nbsp; <br />&nbsp;
            <%--</h1>--%>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-6">
            <table class="table table-striped table-hover">
                <tbody>
                <tr>
                    <th class="col-lg-4">Title</th>
                    <td>
                        <a href="#" id="building-title" data-type="text" data-pk="<@= building.id @>"
                           data-mode="inline" data-original-title="Enter Title">
                            <@= building.title @>
                        </a>
                    </td>
                </tr>
                <tr>
                    <th class="col-lg-4">Description</th>
                    <td>
                        <a href="#" id="building-description" data-type="textarea" data-pk="<@= building.id @>"
                           data-mode="inline" data-original-title="Enter Description"><@= building.description @></a>
                    </td>
                </tr>
                <tr>
                    <th class="col-lg-4">Latitude / Longitude</th>
                    <td>
                        <a href="#" id="building-location" data-type="text" data-pk="<@= building.id @>">
                            <@= building.lat @> / <@= building.lng @>
                        </a>
                        &nbsp;
                        <a target="_blank" href="https://www.google.com/maps?q=<@= building.lat @>,<@= building.lng @>">
                            <i style="color: #FF0000;" class="glyphicon glyphicon-map-marker"></i>
                        </a>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="col-lg-6">
            <div id="hotel-view-map"></div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="btn-group" role="group" aria-label="test">
                <button type="button" class="btn btn-default" id="hotel-create-apartment">Create Apartment</button>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-6">
            <div class="table-responsive" id="apartment-list">

            </div>
        </div>
        <div class="col-lg-6">
            <div class="table-responsive" id="apartment-view">

            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12" id="app-hotel-upload-images">
        </div>
    </div>
</script>

<script id="app-hotel-apartments-tmpl" type="text/template">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Apartments</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="table-responsive">
                <div class="table-responsive" id="apartment-list">

                </div>
            </div>
        </div>
    </div>
</script>

<script id="app-hotel-apartment-tmpl" type="text/template">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel-body table-responsive">
                <table class="table table-striped table-hover">
                    <tbody>
                    <tr>
                        <th class="col-lg-3">Title</th>
                        <td>
                            <a href="#" id="apartment-title" data-type="text" data-pk="<@= apartment.id @>"
                               data-mode="inline" data-original-title="Enter Title">
                                <@= apartment.title @>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <th class="col-lg-3">Description</th>
                        <td>
                            <a href="#" id="apartment-description" data-type="textarea" data-pk="<@= apartment.id @>"
                               data-mode="inline" data-original-title="Enter Description"><@= apartment.description @></a>
                        </td>
                    </tr>
                    <tr>
                        <th class="col-lg-3">Current Price</th>
                        <td>
                            <@= apartment.current_price.price @>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <ul>
                <@ _.each(apartment.media, function(val, key){ @>
                    <li>
                        <img src="<c:url value="/resources/frontend/images/"/><@= val.filename @>" alt="">
                    </li>
                <@ }); @>
            </ul>
        </div>
    </div>
</script>

<script id="app-hotel-billing-tmpl" type="text/template">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Billing</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <!-- The fileinput-button span is used to style the file input field as button -->
            <span class="btn btn-success fileinput-button">
                <i class="glyphicon glyphicon-plus"></i>
                <span>Select files...</span>
                <!-- The file input field used as target for the file upload widget -->
                <input id="billing-upload" type="file" name="files" multiple>
            </span>
            <br>
            <br>
            <!-- The global progress bar -->
            <div id="progress" class="progress">
                <div class="progress-bar progress-bar-success"></div>
            </div>
            <!-- The container for the uploaded files -->
            <div id="files" class="files"></div>

            <div class="table-responsive">
                <div class="table-responsive" id="billing-list">

                </div>
            </div>
        </div>
    </div>
</script>

<script id="app-hotel-test-tmpl" type="text/template">
    <div class="row">
        <div class="col-lg-12" id="app-hotel-test-upload-widget">
        </div>
    </div>
</script>

<script id="app-hotel-upload-widget-tmpl" type="text/template">
    <div class="bs-example" data-example-id="simple-thumbnails">
        <div class="row">
            <div class="col-xs-6 col-md-3 col-lg-1">
                <a href="#" class="thumbnail" id="app-hotel-upload-widget">
                    <img src="<c:url value="/resources/admin/images/upload-icon.png" />" style="width:40px;margin:15px auto;">
                </a>
                <input type="file" name="apartment-files" id="apartment-files" style="display: none;">
            </div>
            <@ _.each(data, function(val, key){ @>
            <div class="col-xs-6 col-md-3 col-lg-1">
                <a href="#" class="thumbnail">
                    <img src="<@- val.url @>" style="height: 70px; width: 70px; display: block;">
                </a>
            </div>
            <@ }); @>
        </div>
    </div>
</script>