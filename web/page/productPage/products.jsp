<%-- 
    Document   : products
    Created on : Feb 3, 2024, 11:40:34 AM
    Author     : ACER
--%>

<%@page import="controllers.CONSTANTS"%>
<%@page import="DTO.ProductCategories"%>
<%@page import="DAO.ProductDAO"%>
<%@page import="DTO.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Products</title>
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
        <jsp:include page="/components/navbar/navbar.jsp" />
        <jsp:include page="/components/productItem/ProductLayout.jsp" />

        <script src="./productJS.js"></script>
        <script type="text/javascript" src="Javascript/Navbar/index.js"></script> <!-- For Navbar -->
        
    </body>
</html>
