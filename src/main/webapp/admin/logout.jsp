<%--
  Created by IntelliJ IDEA.
  User: volodymyrmordas
  Date: 6/6/16
  Time: 11:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.invalidate();
    response.sendRedirect(request.getContextPath() + "/admin");
%>
