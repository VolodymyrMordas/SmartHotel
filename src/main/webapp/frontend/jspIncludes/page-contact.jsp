<%--
  Created by IntelliJ IDEA.
  User: volodymyrmordas
  Date: 6/28/16
  Time: 3:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
  <div class="row">
    <div class="col-xs-12 col-sm-12 col-md-5 wow fadeInUp">
      <div class="block text-left">

        <address class="address">
          <h2>Контакты</h2>
          <br />
          <hr>
          <p>ул.Горького 32,<br> п.Каролино-Бугаз,<br> Украина</p>
          <hr>
          <p><strong>E:</strong>&nbsp;info@karolino.com.ua<br>
            <strong>P:</strong>&nbsp;+38 097 975 0753</p>
        </address>
      </div>
    </div>

    <div class="col-xs-12 col-sm-12 col-md-5 col-md-offset-1 wow fadeInUp" data-wow-delay="0.3s">
      <div class="form-group">
        <form action="#" method="post" id="contact-form">
          <div class="input-field">
            <input type="text" class="form-control" placeholder="Your Name" name="name">
          </div>
          <div class="input-field">
            <input type="email" class="form-control" placeholder="Email Address" name="email">
          </div>
          <div class="input-field">
            <textarea class="form-control" placeholder="Your Message" rows="3" name="message"></textarea>
          </div>
          <button class="btn btn-send" type="submit">Отправить письмо</button>
        </form>

        <div id="success">
          <p>Your Message was sent successfully</p>
        </div>
        <div id="error">
          <p>Your Message was not sent successfully</p>
        </div>
      </div>
    </div>
  </div>
</div>
