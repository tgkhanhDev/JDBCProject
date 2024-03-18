<%-- 
    Document   : index
    Created on : Mar 14, 2024, 3:19:33 AM
    Author     : ACER
--%>
<%@page import="DTO.Account"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DTO.Role"%>
<%@page import="DAO.AccountDAO"%>
<%@page import="controllers.CONSTANTS"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="jstl" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Contract</h1>
        <jstl:set var='sec' value="${param.sec}" />
        <jstl:set var='page' value="${(param.page == null)?'1': param.page }" />
        <jstl:set var="transID" value="${param.transID}" />
        <jstl:set var="status" value="${param.status}" scope="page" />
        <jstl:set var="list" value="${sessionScope.list }"  />
        <jstl:set var="size" value="${sessionScope.size }"  />

        <div class="my-5 flex flex-col">
            <form action="mainController" class="flex items-center gap-2">
                <input type="hidden" name="action" value=<%=    CONSTANTS.GETPRODUCT_ADMIN%> />
                <input type="hidden" name="sec" value=<%= request.getParameter("sec")%>  />

                <div>
                    <label>Theo trạng thái: </label>
                    <select class="rounded" name="status">
                        <option value="">Tất cả</option>
                        <jstl:choose>
                            <jstl:when test="${status eq '1'}" >
                                <option value="1" selected>Đang hoạt động</option>
                            </jstl:when>
                            <jstl:otherwise>
                                <option value="1">Đang hoạt động</option>
                            </jstl:otherwise>
                        </jstl:choose>

                        <jstl:choose>
                            <jstl:when test="${status eq '0'}" >
                                <option value="0" selected="">Ngưng hoạt động</option>
                            </jstl:when>
                            <jstl:otherwise>
                                <option value="0">Ngưng hoạt động</option>
                            </jstl:otherwise>
                        </jstl:choose>
                    </select>
                </div>

                <div class="relative max-w-sm flex items-center gap-2">
                    <label>Theo Transaction:  </label>
                    <input type="text" name="transID"  value="${transID}"/>
                </div>


                <button type="submit" class="px-4 py-2  rounded bg-yellow-600">Search</button>

            </form>
        </div>


        <!--table--> 
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
                            Giá phụ thu
                        </th>
                        <th scope="col" class="px-6 py-3 text-center">
                            Status
                        </th>
                        <th scope="col" class="px-6 py-3 text-center">
                            Transaction ID
                        </th>
                        <th scope="col" class="px-6 py-3 text-center">
                            <span class="">Other</span>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <jstl:forEach items="${list}" var="item">
                        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                            <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white text-center">
                                ${item.contactID}
                            </th>
                            <td class="px-6 py-4 text-center">
                                ${item.service.serviceName}
                            </td>
                            <td class="px-6 py-4 text-center">
                                ${item.service.servicePrice}
                            </td>
                            <td class="px-6 py-4 text-center">
                                <form action="mainController">
                                    <input type="hidden" name="action" value="<%=  CONSTANTS.UPDATEINFO_ADMIN%>" />
                                    <input type="hidden" name="sec" value="${sec}" />
                                    <input type="hidden" name="page" value="${page}" />
                                    <input type="hidden" name="status" value="${status}" />
                                    <input type="hidden" name="contractID" value="${item.contactID}" />
                                    <jstl:choose > 
                                        <jstl:when test="${item.status eq '1'}">
                                            <button class="px-4 py-2 bg-green-500 hover:bg-green-600 rounded text-white">Active</button>
                                        </jstl:when>
                                        <jstl:otherwise>
                                            <button class="px-4 py-2 bg-red-500 hover:bg-red-600 rounded text-white">InActive</button>
                                        </jstl:otherwise>
                                    </jstl:choose>
                                </form>
                            </td>
                            <td class="px-6 py-4 text-center">
                                ${item.transaction.tranID}
                            </td>
                            <td class="px-6 py-4 text-center">
                                <form>
                                    <input type="hidden" name="action" value="<%=  CONSTANTS.GETFORMINFOPRODUCT_ADMIN%>" />
                                    <input type="hidden" name="sec" value="${sec}" />
                                    <input type="hidden" name="page" value="${page}" />
                                    <input type="hidden" name="transID" value="${item.transaction.tranID}" />

                                    <button class="px-4 py-2 rounded bg-yellow-500 text-white">View Transaction Detail</button>
                                </form>
                            </td>

                        </tr>
                    </jstl:forEach>

                </tbody>
            </table>
        </div>

        <!--Add btn--> 
        <button class="px-4 py-2 bg-green-500 rounded text-white capitalize" id="toggleForm">Thêm Contract</button>
        <!--===========-->

        <!--form update--> 
        <!--layer-->
        <jstl:set var="transList"  value="${sessionScope.formTransList}" />
        <jstl:set var="serviceList"  value="${sessionScope.formServiceList}" />

        <div id="formUpdate" class="transition-all ease-in-out hidden">
            <div id="formLayer" class="absolute top-0 left-0 w-screen h-screen bg-black bg-opacity-70 z-10"></div>
            <div class="bg-[#f6f6f6] absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 px-20 py-10 z-10 rounded-xl">
                <!--quit button--> 
                <form action="mainController" class="z-100 cursor-pointer">
                    <div>
                        <input type="hidden" name="action" value="<%=          CONSTANTS.GETPRODUCT_ADMIN%>" />
                        <input type="hidden" name="sec" value="${sec}" />
                        <input type="hidden" name="page" value="${page}" />

                    </div>
                    <button id="toggleForm" class="absolute top-3 right-3">
                        <svg width="20px" height="20px" viewBox="0 0 1024 1024" class="icon"  version="1.1" xmlns="http://www.w3.org/2000/svg"><path d="M512 457.6L905.6 64l54.336 54.336-393.6 393.6L960 905.6l-54.4 54.4L512 566.336 118.4 960 64 905.6 457.6 512 64 118.336 118.336 64l393.6 393.6z" fill="#000000" /></svg>
                    </button>
                </form>
                <form action="mainController" class="max-w-md mx-auto" method="get" accept-charset="UTF-8"> 
                    <input type="hidden" name="action" value="<%=     CONSTANTS.ADDINFO_ADMIN%>" />
                    <input type="hidden" name="sec" value="${sec}" />

                    <div class="text-3xl flex justify-center mb-10 underline">Create Contract</div>
                    <div class="relative z-0 w-full mb-5 group">
                        <label class="text-xl peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Select transactions...</label>
                        <select required name="transactionForm" class="capitalize block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer">
                            <option class="capitalize" value="" selected=""></option>
                            <jstl:if test="${transList != null }" >
                                <jstl:forEach var="trans" items="${transList}">
                                    <jstl:if test="${trans.status eq '1'}" >
                                        <option class="capitalize" value="${trans.tranID}">ID:${trans.tranID} --- Date:${trans.getDateForRendering()} --- Product:${trans.product.name}</option>
                                    </jstl:if>
                                </jstl:forEach>
                            </jstl:if>
                        </select>
                    </div>

                    <div class="relative z-0 w-full mb-5 group">
                        <label class="text-xl peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Select service...</label>
                        <select required name="serviceForm" class="capitalize block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer">
                            <option class="capitalize" value="" selected=""></option>
                            <jstl:if test="${serviceList != null }" >
                                <jstl:forEach var="serv" items="${serviceList}">
                                    <jstl:if test="${serv.status eq '1'}" >
                                        <option class="capitalize" value="${serv.id}"> Name:${serv.serviceName} --- Additional Price:${serv.servicePrice}</option>
                                    </jstl:if>
                                </jstl:forEach>
                            </jstl:if>
                        </select>
                    </div>


                    <!--=============--> 
                    <div class="flex justify-between">
                        <div></div>
                        <div class="flex gap-2">                        
                            <button type="submit" class="text-white bg-blue-700 hover:bg-blue-800 rounded  px-5 py-2 text-center">Submit</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>


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
                    <div class="text-2xl mb-10  flex justify-center underline">Transaction Infomation</div>
                    <jstl:choose>
                        <jstl:when test="${formList != null}">
                            <div class="relative z-0 w-full mb-5 group">
                                <input value="${formList.tranID}" type="number" name="TransID" class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder=" " readonly />
                                <label class="text-xl peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">ID:</label>
                            </div>
                            <div class="relative z-0 w-full mb-5 group">
                                <input value="${formList.getDateForRendering()}" type="text" name="date" class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder=" " readonly/>
                                <label class="text-xl peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Create time:</label>
                            </div>
                            <div class="relative z-0 w-full mb-5 group">
                                <input value="${formList.quantity}" type="number" name="quantity" class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder=" " readonly/>
                                <label class="text-xl peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Quantity:</label>
                            </div>
                            <div class="relative z-0 w-full mb-5 group">
                                <input value="${formList.money * formList.quantity}" type="number" name="money" class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder=" " readonly/>
                                <label class="text-xl peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Price:</label>
                            </div>
                        </jstl:when>
                        <jstl:otherwise><div>Nothing to display...</div></jstl:otherwise>
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
