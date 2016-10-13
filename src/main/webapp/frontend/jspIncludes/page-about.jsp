<%--
  Created by IntelliJ IDEA.
  User: volodymyrmordas
  Date: 6/28/16
  Time: 3:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
  <div class="row">
    <div class="col-md-7 col-sm-12 wow fadeInLeft">
      <div class="sub-heading">
        <h2>Сдаётся</h2>
      </div>
      <%--<div class="sub-heading">--%>
        <%--<h3>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Magnam ipsa recusandae consequatur veniam, reiciendis odit quia eaque vel eius a.</h3>--%>
      <%--</div>--%>
      <div class="block">
        <p>Просторный коттедж в черте города, вдали от шума автострады. На Ваш выбор однокомнатные и двухкомнатные апартаменты класса “Люкс”.
          Перед каждым номером – терраса и беседка.</p>
      </div>
    </div>
    <div class="col-md-5 col-sm-12 wow fadeInLeft" data-wow-delay="0.3s">
      <div class="about-slider">
        <div class="init-slider">
          <div class="about-item">
            <img src="<c:url value="/resources/frontend/images/101_enl.JPG"/>" alt="" class="img-responsive">
          </div>
          <div class="about-item">
            <img src="<c:url value="/resources/frontend/images/108._enl.JPG"/>" alt="" class="img-responsive">
          </div>
        </div>
      </div>
    </div>
  </div>
</div>