<%-- 
    Document   : index
    Created on : Mar 19, 2024, 2:18:37 AM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div id="main" class="w-[calc(100vw-200px)] ml-[200px]">
            <%
                String param = (String) request.getParameter("sec");
                String flag = null;
                if (param == null)
                {
                    param = "1";
                }
                switch (param)
                {
                    case "1":
            %> <jsp:include page="/components/technician/body/mainbody/viewTask/index.jsp" /><%
                    break;
                }
            %>

            <!--Pagination--> 
            <jsp:include page="/components/technician/body/pagination/index.jsp" />

        </div>
    </body>
</html>
