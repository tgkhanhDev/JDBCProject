<%-- 
    Document   : index
    Created on : Mar 14, 2024, 3:34:47 AM
    Author     : ACER
--%>

<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DTO.Account"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DTO.Role"%>
<%@page import="DAO.AccountDAO"%>
<%@page import="controllers.CONSTANTS"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="jstl" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <h1>Transaction</h1>
        <jstl:set var='sec' value="${param.sec}" />
        <jstl:set var='page' value="${(param.page == null)?'1': param.page }" />
        <jstl:set var="date" value="${param.date}" />
        <jstl:set var="status" value="${param.status}" scope="page" />
        <jstl:set var="list" value="${sessionScope.list }"  />

        <!--Search--> 
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
                    <label for="dateofbirth">Theo ngày: </label>
                    <input type="date" name="date" id="dateofbirth" value="${date}"/>
                </div>


                <button type="submit" class="px-4 py-2  rounded bg-yellow-600">Search</button>

            </form>
        </div>

        <div class="relative overflow-x-auto shadow-md sm:rounded-lg my-5">
            <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-center">
                            TransID
                        </th>
                        <th scope="col" class="px-6 py-3 text-center">
                            Date
                        </th>
                        <th scope="col" class="px-6 py-3 text-center">
                            Quantity
                        </th>
                        <th scope="col" class="px-6 py-3 text-center">
                            Money
                        </th>
                        <th scope="col" class="px-6 py-3 text-center">
                            Product Name
                        </th>
                        <th scope="col" class="px-6 py-3 text-center">
                            Category
                        </th>
                        <th scope="col" class="px-6 py-3 text-center">
                            Status
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
                                ${item.tranID}
                            </th>
                            <td class="px-6 py-4 text-center">
                                ${item.getDateForRendering()}
                            </td>
                            <td class="px-6 py-4 text-center">
                                ${item.quantity}
                            </td>
                            <td class="px-6 py-4 text-center">
                                ${(item.money*item.quantity)+ item.product.price}
                            </td>
                            <td class="px-6 py-4 text-center">
                                ${item.product.name}
                            </td>
                            <td class="px-6 py-4 text-center">
                                ${item.product.getCategory().name}
                            </td>
                            <td class="px-6 py-4 text-center">
                                <form action="mainController">
                                    <input type="hidden" name="action" value="<%=  CONSTANTS.UPDATEINFO_ADMIN%>" />
                                    <input type="hidden" name="sec" value="${sec}" />
                                    <input type="hidden" name="page" value="${page}" />
                                    <input type="hidden" name="date" value="${date}" />
                                    <input type="hidden" name="status" value="${status}" />
                                    <input type="hidden" name="tranID" value="${item.tranID}" />
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
                                <form action="mainController">
                                    <input type="hidden" name="itemID" value="${item.tranID}" />
                                    <input type="hidden" name="sec" value="${sec}" />
                                    <input type="hidden" name="action" value="<%=   CONSTANTS.GETFORMINFOPRODUCT_ADMIN%>" />
                                    <button class="px-4 py-2 rounded bg-yellow-500 hover:bg-yellow-600 text-white">Edit</button>
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
        <jstl:set var="formList" value="${requestScope.formList}" />
        <div id="formUpdate" class="transition-all ease-in-out <jstl:if test="${formList == null}"><jstl:out value="hidden" /></jstl:if> ">
                <div id="formLayer" class="z-10 absolute top-0 left-0 w-screen h-screen bg-black bg-opacity-70"></div>
                <div class="bg-[#f6f6f6] absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 px-20 py-10 z-10">
                    <!--quit button--> 
                    <form action="mainController" class="z-100 cursor-pointer">
                        <div>
                            <input type="hidden" name="action" value="<%=          CONSTANTS.GETPRODUCT_ADMIN%>" />
                        <input type="hidden" name="sec" value="${sec}" />
                        <input type="hidden" name="page" value="${page}" />
                        <input type="hidden" name="date" value="${date}" />
                        <input type="hidden" name="status" value="${status}" />
                    </div>
                    <button id="toggleForm" class="absolute top-3 right-3">
                        <svg width="20px" height="20px" viewBox="0 0 1024 1024" class="icon"  version="1.1" xmlns="http://www.w3.org/2000/svg"><path d="M512 457.6L905.6 64l54.336 54.336-393.6 393.6L960 905.6l-54.4 54.4L512 566.336 118.4 960 64 905.6 457.6 512 64 118.336 118.336 64l393.6 393.6z" fill="#000000" /></svg>
                    </button>
                </form>

                <form action="mainController" class="max-w-md mx-auto" method="post" accept-charset="UTF-8">
                    
                    <jstl:choose > 
                        <jstl:when test="${formList != null}">
                            <input type="hidden" name="action" value="<%=     CONSTANTS.UPDATEINFO_ADMIN%>" />
                            <input type="hidden" id="tranID" name="tranID" value="${formList.tranID}" />
                        </jstl:when>
                        <jstl:otherwise>
                            <input type="hidden" name="action" value="<%=     CONSTANTS.ADDINFO_ADMIN%>" />
                        </jstl:otherwise>
                    </jstl:choose>
                    <input type="hidden" name="sec" value="${sec}" />

                    <!--date-->
                    <div class="relative z-0 w-full mb-5 group">
                        <jstl:choose > 
                            <jstl:when test="${formList != null}">
                                <input value="${formList.date}" type="text" name="dateForm" class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer cursor-not-allowed" placeholder=" " disabled />
                            </jstl:when>
                            <jstl:otherwise>
                                <input value="<%= new Date()%>" type="text" name="dateForm" class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer cursor-not-allowed" placeholder=" " disabled />
                            </jstl:otherwise>
                        </jstl:choose>
                        <label class="peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Transaction Date:
                    </div>

                    <!--Quantity--> 
                    <div class="relative z-0 w-full mb-5 group">
                        <input id="formQuantity" value="${formList.quantity}" type="number" name="money" class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder=" " required />
                        <label for="" class="peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Quantity
                    </div>



                    <div class="relative z-0 w-full mb-5 group">
                        <jstl:set var="prdList" value="${sessionScope.prdList}" />
                        <label for="floating_password" class="peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Product</label>
                        <select id="formProduct" name="prdID" class="rounded w-full my-2">
                            <option value="">None</option>
                            <jstl:forEach var="prd" items="${prdList}">
                                <jstl:if test="${prd.status eq '1'}">
                                    <jstl:choose > 
                                        <jstl:when test="${prd.prd_ID eq formList.product.prd_ID}">
                                            <option value="${prd.prd_ID}" selected>${prd.name}*</option>
                                        </jstl:when>
                                        <jstl:otherwise>
                                            <option value="${prd.prd_ID}">${prd.name}</option>
                                        </jstl:otherwise>
                                    </jstl:choose>
                                </jstl:if>
                            </jstl:forEach>
                        </select>
                    </div>


                    <!--total--> 
                    <div class="relative z-0 w-full mb-5 group">
                        <div>  <input value="${formList.money+ formList.product.price}" type="text" name="dateForm" class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer " placeholder=" " />
                            <label class="peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6 font-bold italic">Thành tiền
                        </div>
                    </div>

                    <div class="flex justify-between">
                        <jstl:choose > 
                            <jstl:when test="${formList != null}">
                                <button class="px-4 py-2 rounded bg-blue-500 hover:bg-blue-600 rounded text-white">Update</button>
                            </jstl:when>
                            <jstl:otherwise>
                                <button class="px-4 py-2 rounded bg-yellow-500 hover:bg-yellow-600 rounded text-white">Create</button>
                            </jstl:otherwise>
                        </jstl:choose>
                    </div>
                </form>

                <div class="absolute right-5 bottom-5 flex flex-col  items-center">

                    <form id="reloadForm" action="mainController">
                        <input type="hidden" name="action" value="<%=  CONSTANTS.GETFORMINFOPRODUCT_ADMIN%>" />
                        <input type="hidden" name="reload" value="reload" />
                        <input type="hidden" name="sec" value="${sec}" />
                        <input type="hidden" name="page" value="${page}" />
                        <input type="hidden" name="date" value="${date}" />
                        <input type="hidden" name="status" value="${status}" />

                        <!--//xu ly--> 
                        <input id="formTranIDReload" name="formTranIDReload" value="" type="hidden" />
                        <input id="formQuantityReload" name="formQuantityReload" value="" type="hidden" />
                        <input id="formProductReload" name="formProductReload" value="" type="hidden" />
                        <button id="reloadBtn" class="p-1 rounded-2xl  flex justify-center" style="box-shadow: rgba(0, 0, 0, 0.19) 0px 10px 20px, rgba(0, 0, 0, 0.23) 0px 6px 6px">
                            <svg fill="#000000" height="20px" width="20px" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" 
                                 viewBox="0 0 489.533 489.533" xml:space="preserve">
                            <g>
                            <path d="M268.175,488.161c98.2-11,176.9-89.5,188.1-187.7c14.7-128.4-85.1-237.7-210.2-239.1v-57.6c0-3.2-4-4.9-6.7-2.9
                                  l-118.6,87.1c-2,1.5-2,4.4,0,5.9l118.6,87.1c2.7,2,6.7,0.2,6.7-2.9v-57.5c87.9,1.4,158.3,76.2,152.3,165.6
                                  c-5.1,76.9-67.8,139.3-144.7,144.2c-81.5,5.2-150.8-53-163.2-130c-2.3-14.3-14.8-24.7-29.2-24.7c-17.9,0-31.9,15.9-29.1,33.6
                                  C49.575,418.961,150.875,501.261,268.175,488.161z"/>
                            </g>
                            </svg>
                        </button>
                        <p class="italic flex justify-center ">reload</p>
                    </form>

                </div>
            </div>
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


        document.getElementById("reloadBtn").addEventListener("click", () => {
            let formTransID = document.getElementById("tranID").value;
            let formQuan = document.getElementById("formQuantity").value;
            let formPro = document.getElementById("formProduct").value;

            //set Value
            document.getElementById("formTranIDReload").value = formTransID;
            document.getElementById("formQuantityReload").value = formQuan;
            document.getElementById("formProductReload").value = formPro;

        })



    </script>

</body>
</html>
