<%-- 
    Document   : SIDER/index
    Created on : Feb 7, 2024, 11:29:22 AM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SIDER COMP</title>
    </head>
    <body>
        <% String param = request.getParameter("sec"); %>
        <form id="sider" class="fixed w-[200px] text-white h-[calc(100vh-56px)] top-[56px] left-0 bg-[#323232]">
            <input id="siderInput" type="hidden" name="sec" value="" />
            <!--Quan Ly--> 
            <div>
                <div class="text-2xl border-b-2 mr-2">Quản Lý</div>
                <div class="flex flex-col">
                    <div class="text-xl py-2 pl-5 capitalize bg-transparent hover:bg-gray-800 cursor-pointer <%=           (param.equals("1")) ? "!bg-gray-800 !cursor-default" : ""          %>" value="1" data-sider >Sản phẩm</div>
                    <div class="text-xl py-2 pl-5 capitalize bg-transparent hover:bg-gray-700 cursor-pointer <%=           (param.equals("2")) ? "!bg-gray-800 !cursor-default" : ""          %>" value="2" data-sider >Người dùng</div>
                </div>
            </div>

            <!--Giao viec--> 
            <div class="mt-5">
                <div class="text-2xl border-b-2 mr-2">Task Manager</div>
                <div class="flex flex-col">
                    <div class="text-xl py-2 pl-5 capitalize bg-transparent hover:bg-gray-700 cursor-pointer <%=           (param.equals("3")) ? "!bg-gray-800 !cursor-default" : ""          %>" value="3" data-sider >Xem yêu cầu</div>
                    <div class="text-xl py-2 pl-5 capitalize bg-transparent hover:bg-gray-700 cursor-pointer <%=           (param.equals("4")) ? "!bg-gray-800 !cursor-default" : ""          %>" value="4" data-sider >Giao Task</div>
                </div>
            </div>
        </form>


    </body>
</html>
