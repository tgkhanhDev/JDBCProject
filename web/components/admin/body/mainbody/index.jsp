<%-- 
    Document   : index.jsp
    Created on : Feb 12, 2024, 3:54:15 PM
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
            %> <jsp:include page="/components/admin/body/mainbody/ProductBody/index.jsp" /><%
                    break;
                case "2":
            %> <jsp:include page="/components/admin/body/mainbody/AccountBody/index.jsp" /><%
                    break;
                case "3":
            %> <jsp:include page="/components/admin/body/mainbody/RequestBody/index.jsp" /><%
                    break;
                case "4":
            %> <jsp:include page="/components/admin/body/mainbody/TaskBody/index.jsp" /><%
                    break;
                case "5":
            %> <jsp:include page="/components/admin/body/mainbody/Transaction/index.jsp" /><%
                    flag = "alter";
                    break;
                case "6":
            %> <jsp:include page="/components/admin/body/mainbody/Contract/index.jsp" /><%
                    flag = "alter";
                    break;
                case "7":
            %> <jsp:include page="/components/admin/body/mainbody/Services/index.jsp" /><%
                        break;

                }


            %>

            <!--Pagination--> 
            <%                if (flag == null)
                {
            %>
            <jsp:include page="/components/admin/body/pagination/index.jsp" />
            
            <%
            } else
            {
            %>
            <jsp:include page="/components/admin/body/pagination/jstlPagination.jsp" />

            <%
                }
            %>


        </div>
    </body>
</html>
