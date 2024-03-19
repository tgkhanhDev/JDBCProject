<%-- 
    Document   : index
    Created on : Mar 19, 2024, 2:19:09 AM
    Author     : ACER
--%>

<%@page import="mylibs.UtilsFunc"%>
<%@page import="DTO.Request"%>
<%@page import="controllers.CONSTANTS"%>
<%@page import="DTO.StatusType"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <!--TABLE--> 
        <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
            <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-center">
                            Request ID
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Request Name
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Register Date
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Contact Phone
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Contact Gmail
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Admin Name
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Admin Role
                        </th>
                        <th scope="col" class="px-6 py-3 text-center">
                            Status
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Request Type 
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Sản Phẩm
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Price
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Description
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Payment ID
                        </th>
                    </tr>
                </thead>
                <tbody>

                    <%
                        String sec = request.getParameter("sec");
                        if (sec == null || sec.trim().equals(""))
                        {
                            sec = "1";
                        }

                        ArrayList<Request> listReq = (ArrayList<Request>) session.getAttribute("list");
                        String currentPage = (String) request.getParameter("page");
                        currentPage = (currentPage == null || currentPage.trim().equals("null")) ? "1" : currentPage;
                        if (listReq != null)
                        {

                            ArrayList<ArrayList> pagingList = (new UtilsFunc().pagination(listReq, CONSTANTS.MAXPAGE_ADMIN));
//                            out.print("<div class='font-bold text-2xl'>currPage: "+ currentPage +"</div>");
                            ArrayList<Request> currList = pagingList.get(Integer.parseInt(currentPage) - 1);
//                            for (Request item : currList)
                            for (Request item : currList)
                            {
                    %>


                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white text-center">
                            <%=             item.getReqID()%>
                        </th>
                        <td class="px-6 py-4 capitalize">
                            <%=          item.getContact().getService().getServiceName()%>
                        </td>
                        <td class="px-6 py-4">
                            <%=          (item.getContact().getTransaction().getDate() == null) ? "NULL" : item.getContact().getTransaction().getDate().toLocaleString()%>
                        </td>
                        <td class="px-6 py-4">
                            <%=          item.getAcc().getPhone()%>
                        </td>
                        <td class="px-6 py-4">
                            <%=          item.getAcc().getGmail()%>
                        </td>

                        <td class="px-6 py-4">
                            <%=          (item.getAdminAcc() != null) ? (item.getAdminAcc().getFirstName() + " " + item.getAdminAcc().getLastName()) : item.getAdminAcc()%>
                        </td>
                        <td class="px-6 py-4">
                            <%=         (item.getAdminAcc().getRole() != null) ? item.getAdminAcc().getRole().getRoleName() : item.getAdminAcc().getRole()%>
                        </td>

                        <td class="px-6 py-4 text-center ">
                            <!-- 148 --> 
                            <details class="dropdown w-[150px]">
                                <summary class="m-1 btn rounded  py-1 text-[20px] text-white
                                         <%
                                             if (item.getStatusType().getStatusID() == 1)
                                             {
                                                 out.print("bg-gray-500");
                                             } else if (item.getStatusType().getStatusID() == 3)
                                             {
                                                 out.print("bg-cyan-500");
                                             } else if (item.getStatusType().getStatusID() == 4)
                                             {
                                                 out.print("bg-green-500");
                                             } else if (item.getStatusType().getStatusID() == 5)
                                             {
                                                 out.print("bg-red-500");
                                             } else
                                             {
                                                 out.print("bg-yellow-500");
                                             }
                                         %>
                                         "><%=      item.getStatusType().getStatusName()%></summary>
                                <ul class="menu dropdown-content z-[1] rounded  absolute w-[150px]  bg-gray-100">
                                    <form action="mainController">
                                        <input type="hidden" name="sec" value="<%= sec%>"/>
                                        <input type="hidden" name="action" value="<%= CONSTANTS.UPDATE_TECHNICIAN%>"/>
                                        <input type="hidden" name="reqID" value="<%=   item.getReqID()%>"/>
                                        <input type="hidden" name="search" value="${search}" />
                                        <input type="hidden" name="date" value="<%=          request.getParameter("date")%>" />
                                        <input type="hidden" name="status" value="<%=          request.getParameter("status")%>" />
                                        <input type="hidden" name="page" value="<%=          currentPage%>" />


                                        <%
                                            ArrayList<StatusType> sttType = (ArrayList<StatusType>) session.getAttribute("statusList");
                                            if (sttType != null)
                                            {

                                                for (StatusType stt : sttType)
                                                {
                                                    if (stt.getStatusID() >= 4)
                                                    {
                                        %>
                                        <li class="">
                                            <button class="py-2 h-full w-full <%=(stt.getStatusID() == item.getStatusType().getStatusID()) ? "bg-gray-200" : "bg-gray-100"%>   
                                                    <%
                                                        if (item.getStatusType().getStatusID() >= 3 && stt.getStatusID() <= 2)
                                                        {
                                                            out.print("opacity-30 ");
                                                        } else
                                                        {
                                                            out.print("hover:bg-gray-200 cursor-pointer");
                                                        }
                                                    %>
                                                    " 
                                                    type="submit" name="sttType" value="<%=stt.getStatusID()%>" 
                                                    <%
                                                        //Neu id dang >3 thi kh the ve chua xu ly
                                                        if (item.getStatusType().getStatusID() >= 3 && stt.getStatusID() <= 2)
                                                        {
                                                            out.print("disabled");
                                                        }
                                                    %>
                                                    >
                                                <%=      stt.getStatusName()%>
                                            </button>
                                        </li>
                                        <%
                                                    }
                                                }
                                            }%>
                                    </form>
                                </ul>
                            </details>

                        </td>
                        <td class="px-6 py-4">
                            <%=          item.getRequestType().getRqTyName()%>
                        </td>
                        <td class="px-6 py-4">
                            <%=          item.getContact().getTransaction().getProduct().getName()%>
                        </td>
                        <td class="px-6 py-4">
                            <%=          item.getContact().getService().getServicePrice() + item.getContact().getTransaction().getMoney()%>
                        </td>
                        <td class="px-6 py-4">
                            <%=          item.getDescription()%>
                        </td>
                        <td class="px-6 py-4">
                            <%=          item.getContact().getTransaction().getTranID()%>
                        </td>
                    </tr>
                    <%                            }
                        }
                    %>

                </tbody>
            </table>
        </div>
    </body>
</html>
