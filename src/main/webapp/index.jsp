<%--
  Created by IntelliJ IDEA.
  User: volodymyrmordas
  Date: 5/18/16
  Time: 5:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html class="no-js">
<head>
  <title>SmartHotel :: Main</title>
  <meta name="description" content="">
  <c:import url="/frontend/jspIncludes/header.jsp" />
</head>

<body id="body">

<div id="preloader">
  <div class="book">
    <div class="book__page"></div>
    <div class="book__page"></div>
    <div class="book__page"></div>
  </div>
</div>

<!--
Header start
==================== -->
<div class="navbar-default navbar-fixed-top" id="navigation">
  <div class="container">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <%--<a class="navbar-brand" href="#">--%>
        <%--<img class="logo-1" src="<c:url value="/resources/frontend/images/logo.png"/>" alt="LOGO">--%>
        <%--<img class="logo-2" src="<c:url value="/resources/frontend/images/logo.png"/>" alt="LOGO">--%>
      <%--</a>--%>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <nav class="collapse navbar-collapse" id="navbar">
      <ul class="nav navbar-nav navbar-right" id="top-nav">
        <li class="current"><a href="#body">Главная</a></li>
        <li><a href="#about">Сдаётся</a></li>
        <li><a href="#service">Сервис</a></li>
        <li><a href="#location">Расположение</a></li>
        <li><a href="#how-to-get">Как доехать</a></li>
        <li><a href="#contact">Контакты</a></li>
        <li><a class="btn btn-border" href="<c:url value="/offer" /> " role="button">Бронировать номер</a></li>
      </ul>
    </nav><!-- /.navbar-collapse -->

  </div><!-- /.container-fluid -->
</div>

<section id="hero-area">
  <c:import url="frontend/jspIncludes/page-main.jsp" />
</section><!-- header close -->

<!--
About start
==================== -->
<section id="about" class="section">
  <c:import url="frontend/jspIncludes/page-about.jsp" />
</section><!-- #about close -->
<!--
About start
==================== -->

<!--
Service start
==================== -->
<section id="service" class="section">
  <c:import url="frontend/jspIncludes/page-service.jsp" />
</section><!-- #service close -->

<!--
Contact start
==================== -->
<section id="location" class="section">
  <c:import url="frontend/jspIncludes/page-location.jsp" />
</section>


<section id="how-to-get" class="section">
  <c:import url="frontend/jspIncludes/page-how-to-get.jsp" />
</section><!-- #call-to-action close -->

<!--
Contact start
==================== -->
<section id="contact" class="section">
  <c:import url="frontend/jspIncludes/page-contact.jsp" />
</section>

<section clas="wow fadeInUp">
  <div class="map-wrapper">
  </div>
</section>

<footer>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="block">
          <%--<p>Copyright &copy; <a href="http://www.Themefisher.com">Themefisher</a>| All right reserved.</p>--%>
        </div>
      </div>
    </div>
  </div>
</footer>


<!-- Js -->
<script src="<c:url value="/resources/frontend/js/vendor/modernizr-2.6.2.min.js" />"></script>
<script src="<c:url value="/resources/bower_components/jquery/dist/jquery.min.js" />"></script>
<script src="<c:url value="/resources/bower_components/bootstrap/dist/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/resources/frontend/js/owl.carousel.min.js" />"></script>
<script src="<c:url value="/resources/bower_components/jquery-validation/dist/jquery.validate.js" />"></script>
<script src="<c:url value="/resources/bower_components/jquery-form/jquery.form.js" />"></script>

<script src="<c:url value="/resources/frontend/js/jquery.nav.js" />"></script>
<script src="<c:url value="/resources/frontend/js/jquery.sticky.js" />"></script>
<script src="<c:url value="/resources/frontend/js/plugins.js" />"></script>
<script src="<c:url value="/resources/frontend/js/wow.min.js" />"></script>
<script src="<c:url value="/resources/frontend/js/main.js" />"></script>
<script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>

</body>
</html>