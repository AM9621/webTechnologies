<%-- 
    Document   : index
    Created on : Oct 25, 2014, 12:04:24 AM
    Author     : root_
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<!DOCTYPE html>

<html>
<body>
    <h1 align="center">Coffee Recommandation JSP View</h1>
    <p>

    <%
        List styles = (List) request.getAttribute("styles");
        Iterator it = styles.iterator();
        while(it.hasNext()) {
            out.print("<br>try: " + it.next());
        }
    %>
</body>
</html>
