<%--
  Created by IntelliJ IDEA.
  User: volodymyrmordas
  Date: 6/6/16
  Time: 11:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SmartHotel :: SignIn</title>

    <!-- jQuery -->
    <script src="<c:url value="/resources/bower_components/jquery/dist/jquery.min.js" />"></script>
    <script src="<c:url value="/resources/bower_components/jquery-validation/dist/jquery.validate.min.js" />"></script>
    <script src="<c:url value="/resources/bower_components/jquery-form/jquery.form.js" />"></script>
    <script src="<c:url value="/resources/bower_components/jquery-validation/dist/jquery.validate.min.js" />"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="<c:url value="/resources/bower_components/bootstrap/dist/js/bootstrap.min.js"/>"></script>

    <!-- SmartHotel Application -->
    <script src="<c:url value="/resources/admin/js/app.hotel.login.js" />"></script>

    <link rel="stylesheet" href="<c:url value="/resources/admin/css/signin.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/bower_components/bootstrap/dist/css/bootstrap.css" />">
</head>

<body>
<section id="login">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3">
                <h1>Log in your account</h1>

                <form role="form" action="j_security_check" method="post" id="login-form"
                      autocomplete="off">
                    <div class="form-group">
                        <label for="email" class="sr-only">Email</label>
                        <input type="text" name="j_username" id="email" class="form-control"
                               placeholder="Email">
                    </div>
                    <div class="form-group">
                        <label for="key" class="sr-only">Password</label>
                        <input type="password" name="j_password" id="key" class="form-control" placeholder="Password">
                    </div>
                    <%--<div class="checkbox">--%>
                        <%--<span class="character-checkbox" onclick="showPassword()"></span>--%>
                        <%--<span class="label">Show password</span>--%>
                    <%--</div>--%>
                    <input type="submit" id="btn-login" class="btn btn-custom btn-lg btn-block" value="Log in">
                </form>
                <hr />
                <a href="javascript:;" class="forget" data-toggle="modal" data-target=".forget-modal">Forgot your
                    password?</a>
                <hr/>
            </div>
            <!-- /.col-xs-12 -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /.container -->
</section>

<div class="modal fade forget-modal" tabindex="-1" role="dialog" aria-labelledby="myForgetModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                    <span class="sr-only">Close</span>
                </button>
                <h4 class="modal-title">Recovery password</h4>
            </div>
            <div class="modal-body">
                <p>Type your email account</p>
                <input type="email" name="recovery-email" id="recovery-email" class="form-control" autocomplete="off">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-custom">Recovery</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<footer id="footer">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-md-12">
                <p>Page © - 2016</p>

                <p>Powered by <strong><a href="#smart-hotel" target="_blank">SmartHotel</a></strong></p>
            </div>
        </div>
    </div>
</footer>
</body>
</html>
