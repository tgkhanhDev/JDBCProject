<%-- 
    Document   : index
    Created on : Mar 19, 2024, 2:43:06 PM
    Author     : ACER
--%>

<%@page import="mylibs.UtilsFunc"%>
<%@page import="DTO.Service"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DTO.Role"%>
<%@page import="DAO.AccountDAO"%>
<%@page import="DTO.Account"%>
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
        <jstl:set var='sec' value="${param.sec}" />
        <jstl:set var='page' value="${param.page}" />
        <!--abc--> 

        <!--Dropdown--> 
        <div class="flex gap-2" >
            <div class="">Danh mục đang hiển thị: </div>
            <select class="rounded" id="cars">
                <option value="allProduct">Toàn bộ sản phẩm</option>
                <option value="cate">Danh mục sản phẩm</option>
                <option value="service">Dịch vụ</option>
            </select>
        </div>
        <!--endDropdown-->


        <!--Search--> 
        <div class="my-5">
            <form action="mainController" class="flex items-center gap-2">
                <input type="hidden" name="action" value=<%=    CONSTANTS.GETPRODUCT_ADMIN%> />
                <input type="hidden" name="sec" value=<%= request.getParameter("sec")%>  />
                <div class="mr-2">Tìm kiếm: </div>
                <input class="border-2" name="search" value="<%=(request.getParameter("search") != null) ? request.getParameter("search") : ""%>" placeholder="Enter phone numbers..." />
                <button type="submit" class="px-4 py-2  rounded bg-yellow-600">Search</button>
            </form
        </div>

        <div class="relative overflow-x-auto shadow-md sm:rounded-lg my-5">
            <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-center">
                            ID
                        </th>
                        <th scope="col" class="px-6 py-3 text-center">
                            Service Name
                        </th>
                        <th scope="col" class="px-6 py-3 text-center">
                            Status
                        </th>
                        <th scope="col" class="px-6 py-3 text-center">
                            Price
                        </th>
                        <th scope="col" class="px-6 py-3 text-center">
                            <span class="">Other</span>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ArrayList<Service> list = (ArrayList<Service>) session.getAttribute("list");
                        if (list != null)
                        {
                            String currentPage = (String) request.getParameter("page");
                            if (currentPage == null)
                            {
                                currentPage = "1";
                            }
                            ArrayList<ArrayList> pagingList = (new UtilsFunc().pagination(list, CONSTANTS.MAXPAGE_ADMIN));
                            ArrayList<Service> currList = pagingList.get(Integer.parseInt(currentPage) - 1);
                            for (Service item : currList)
                            {
                    %>
                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">

                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white text-center">
                            <%= item.getId()%>
                        </th>
                        <td class="px-6 py-4 text-center">
                            <%= item.getServiceName()%>

                        </td>
                        <td class="px-6 py-4 text-center">
                            <form action="mainController" >
                                <input type="hidden" name="action" value="<%=  CONSTANTS.BLOCK_ADMIN%>" />
                                <input type="hidden" name="sec" value="<%=  request.getParameter("sec")%>" />
                                <input type="hidden" name="itemID" value="<%=   item.getId()%>" />
                                <%
                                    if (item.getStatus().equals("1"))
                                    {
                                %>
                                <button class="bg-green-500 rounded py-1 px-2 text-white ">Active</button>
                                <%
                                } else
                                {
                                %>
                                <button class="bg-red-500 rounded py-1 px-2 text-white">Inactive</button>
                                <%
                                    }

                                %>                           
                            </form>
                        </td>
                        <td class="px-6 py-4 text-center">
                            <%= item.getServicePrice()%>
                        </td>
                        <td class="px-6 py-4 text-center ">
                            <form class="mainController">
                                <input type="hidden" name="action" value="<%= CONSTANTS.GETFORMINFOPRODUCT_ADMIN%>" />
                                <input type="hidden" name="sec" value="<%=  request.getParameter("sec")%>" />
                                <input type="hidden" name="serID" value="<%=  item.getId()%>" />
                                <button class="px-4 py-2 rounded bg-yellow-500">Update</button>
                            </form>

                        </td>

                    </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
        <!--Add btn--> 
        <button class="px-4 py-2 bg-green-500 rounded text-white capitalize" id="toggleFormDetail">Thêm Contract</button>
        <!--===========-->

        <!--Form Detail--> 
        <jstl:set var="formList"  value="${requestScope.formList}" />

        <div id="formDetail" class="transition-all ease-in-out <jstl:choose><jstl:when test="${formList == null}">hidden</jstl:when><jstl:otherwise></jstl:otherwise></jstl:choose>   ">
                    <div id="formLayer" class="absolute top-0 left-0 w-screen h-screen bg-black bg-opacity-70 z-10"></div>
                    <div class="bg-[#f6f6f6] absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 px-20 py-10 z-10 rounded-xl">
                        <!--quit button--> 
                        <form action="mainController" class="z-100 cursor-pointer">
                            <div>
                                    <input type="hidden" name="action" value="<%=          CONSTANTS.GETPRODUCT_ADMIN%>" />
                        <input type="hidden" name="sec" value="${sec}" />
                        <input type="hidden" name="page" value="${page}" />

                    </div>
                    <button id="toggleFormDetail" class="absolute top-3 right-3">
                        <svg width="20px" height="20px" viewBox="0 0 1024 1024" class="icon"  version="1.1" xmlns="http://www.w3.org/2000/svg"><path d="M512 457.6L905.6 64l54.336 54.336-393.6 393.6L960 905.6l-54.4 54.4L512 566.336 118.4 960 64 905.6 457.6 512 64 118.336 118.336 64l393.6 393.6z" fill="#000000" /></svg>
                    </button>
                </form>
                <form action="mainController" class="max-w-md mx-auto" method="get" accept-charset="UTF-8"> 
                    <input type="hidden" name="sec" value="${sec}" />
                    <input type="hidden" name="page" value="${page}" />
                    <jstl:choose>
                        <jstl:when test="${formList == null}">
                            <input type="hidden" name="action" value="<%=  CONSTANTS.ADDINFO_ADMIN%>"  />
                        </jstl:when>
                        <jstl:otherwise>
                            <input type="hidden" name="action" value="<%=  CONSTANTS.UPDATEINFO_ADMIN%>"  />
                        </jstl:otherwise>
                    </jstl:choose>
                    <div class="text-2xl mb-10  flex justify-center underline">Service Infomation</div>
                    <jstl:choose>
                        <jstl:when test="${formList == null}">
                        </jstl:when>
                        <jstl:otherwise>
                            <div class="relative z-0 w-full mb-5 group">
                                <input value="${formList.id}" type="number" name="serID" class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder=" " readonly />
                                <label class="text-xl peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">ID:</label>
                            </div>
                        </jstl:otherwise>
                    </jstl:choose>

                    <div class="relative z-0 w-full mb-5 group">
                        <input value="${formList.serviceName}" type="text" name="serName" class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder=" "  />
                        <label class="text-xl peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Service Name:</label>
                    </div>
                    <jstl:choose>
                        <jstl:when test="${formList == null}">
                        </jstl:when>
                        <jstl:otherwise>
                            <div class="relative z-0 w-full mb-5 group">
                                <input value="${formList.status}" type="text" name="status" class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder=" " readonly />
                                <label class="text-xl peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Status:</label>
                            </div>
                        </jstl:otherwise>
                    </jstl:choose>
                    <div class="relative z-0 w-full mb-5 group">
                        <input value="${formList.servicePrice}" type="number" name="price" class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder=" "  />
                        <label class="text-xl peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Price: </label>
                    </div>
                    <jstl:choose>
                        <jstl:when test="${formList == null}">
                            <button class="px-4 py-2 rounded-xl bg-yellow-500 text-white">Add</button>
                        </jstl:when>
                        <jstl:otherwise>
                            <button class="px-4 py-2 rounded-xl bg-blue-500 text-white">Update</button>
                        </jstl:otherwise>
                    </jstl:choose>

                </form>
            </div>
        </div>

        <script>
            //    on&off formUpdate:
            const toggleList = document.querySelectorAll("#toggleForm");
            toggleList.forEach(btn => {
                btn.addEventListener("click", () => {
                    document.getElementById("formUpdate").classList.toggle("hidden");
                });
            });

            //    on&off formDetail:
            const toggleFromDetail = document.querySelector("#toggleFormDetail");
            toggleFromDetail.addEventListener("click", () => {
                document.getElementById("formDetail").classList.toggle("hidden");
            });


        </script>


    </body>
</html>
