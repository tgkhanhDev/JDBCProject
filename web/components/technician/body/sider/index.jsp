<%-- 
    Document   : index
    Created on : Mar 19, 2024, 2:15:02 AM
    Author     : ACER
--%>

<%@page import="controllers.CONSTANTS"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="jstl" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%

            String param = (String) request.getParameter("sec");
            if (param == null)
            {
                param = "1";
            }
        %>
        <div class="flex">
            <form id="sider" class="fixed w-[200px] text-white h-[calc(100vh-56px)] top-[56px] left-0 bg-[#323232]" action="mainController" method="GET">
                <input type="hidden" name="action" value="<%= CONSTANTS.GETTASK_TECHNICIAN%>"/> 
                <!-- Quan Ly --> 
                <div>
                    <div class="text-2xl border-b-2 mr-2">Quản Lý</div>
                    <div class="flex flex-col">
                        <div>Page: <%=param%></div>
                        <jstl:set var="loginUser" value="${sessionScope.loginUser}"/>
                        <div><jstl:out value="${loginUser.lastName} ${loginUser.firstName}" /></div>
                        <div><jstl:out value="${loginUser.role.roleName}" /></div>
                        <div class="px-5 py-2 bg-transparent hover:bg-gray-700 cursor-pointer <%=(param.equals("1")) ? "!bg-gray-800 !cursor-default" : ""%> ">
                            <button type="submit" name="sec" class="text-xl capitalize" value="1" data-sider>Xem Task</button>
                        </div>
                    </div>
                </div>
            </form>
            <div class="absolute bottom-10">
                <form action="mainController" >
                    <input type="hidden" name="action" value="<%=  CONSTANTS.VIEWHOME%>"/>
                    <button
                        class="rounded-full py-4 w-full max-w-[280px]  flex items-center  justify-center transition-all duration-500 hover:bg-indigo-100">
                        <div class="rotate-[180deg]">
                            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 22 22" fill="none">
                            <path d="M8.25324 5.49609L13.7535 10.9963L8.25 16.4998" stroke="#4F46E5" stroke-width="1.6"
                                  stroke-linecap="round" stroke-linejoin="round" />
                            </svg>
                        </div>
                        <span class="px-2 font-semibold text-lg leading-8 text-indigo-600">Back to Home</span>
                    </button>
                </form>
            </div>
        </div>



    </body>
</html>
