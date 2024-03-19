<%-- 
    Document   : payment
    Created on : Mar 18, 2024, 11:25:25 PM
    Author     : ACER
--%>

<%@page import="DTO.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="jstl" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- FontAwesome  -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
              integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />

        <!-- googlefont  -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Rubik&display=swap" rel="stylesheet">

        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />

        <!-- css  -->
        <link rel="stylesheet" href="utils.css"/>
    </head>
    <body>

        <%
            Account acc = (Account) session.getAttribute("loginUser");
            if(acc != null){
                %>
                        <jsp:include page="/components/navbarsignin/navbarSignin.jsp" />
                <%
            }else{
                %>
                        <jsp:include page="/components/navbar/navbar.jsp" />
                <%
            }

            %>



        <jsp:include page="/components/payment/index.jsp" />

        <script type="text/javascript" src="Javascript/Navbar/index.js"></script> <!-- For Navbar -->
    </body>
</html>
