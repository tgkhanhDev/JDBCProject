<%-- 
    Document   : jstlPagination
    Created on : Mar 18, 2024, 11:15:08 AM
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
        <jstl:set var="search" value="${param.search}" />
        <jstl:set var="sec" value="${param.sec}" />
        <jstl:set var="date" value="${param.date}" />
        <jstl:set var="status" value="${param.status}" />

        <!--========-->

        <%
            int size = (int) session.getAttribute("size");
            int maxPage = 0;

            //            String search = (request.getParameter("search") == null)? "": request.getParameter("search");
            maxPage = (int) (Math.ceil((size * 1.0) / CONSTANTS.MAXPAGE_ADMIN));
            String currPage = (String) request.getParameter("page");
            if (currPage == null || (Integer.parseInt(currPage) <= 0))
            {
                currPage = "1";
            } else if (Integer.parseInt(currPage) > maxPage)
            {
                currPage = maxPage + "";
            }

            //Pagination

        %>

        <div class="flex justify-center">
            <nav>
                <ul class="list-style-none flex">
                    <li class= "<%=          (Integer.parseInt(currPage) == 1) ? "hidden" : ""%>">
                        <form action="mainController">
                            <input type="hidden" name="action" value="<%=   CONSTANTS.GETPRODUCT_ADMIN%>" />
                            <input type="hidden" name="sec" value="${sec}" />
                            <input type="hidden" name="search" value="${search}" />
                            <input type="hidden" name="date" value="${date}" />
                            <input type="hidden" name="status" value="${status}" />
                            <button name="page" value="<%=   (Integer.parseInt(currPage) > 1) ? (Integer.parseInt(currPage) - 1) : (Integer.parseInt(currPage))%>"
                                    class="relative block rounded bg-transparent px-3 py-1.5 text-sm text-neutral-500 transition-all duration-300 dark:text-neutral-400">Previous</button>
                        </form>
                    </li>
                    <!--3 button--> 
                    <li>
                        <form action="mainController">
                            <input type="hidden" name="action" value="<%=    CONSTANTS.GETPRODUCT_ADMIN%>" />
                            <input type="hidden" name="sec" value="${sec}" />
                            <input type="hidden" name="search" value="${search}" />
                            <input type="hidden" name="date" value="${date}" />
                            <input type="hidden" name="status" value="${status}" />
                            <button
                                class="relative block rounded bg-transparent px-3 py-1.5 text-sm text-neutral-600 transition-all duration-300 hover:bg-neutral-100  dark:text-white dark:hover:bg-neutral-700 dark:hover:text-white"
                                name="page"
                                name="page" value="<%=        (Integer.parseInt(currPage) - 1)%>"
                                ><%=          (Integer.parseInt(currPage) > 1) ? (Integer.parseInt(currPage) - 1) : ""%>
                            </button>
                        </form>
                    </li>
                    <li aria-current="page">
                        <form action="mainController">
                            <input type="hidden" name="action" value="<%=  CONSTANTS.GETPRODUCT_ADMIN%>" />
                            <input type="hidden" name="sec" value="${sec}" />
                            <input type="hidden" name="search" value="${search}" />
                            <input type="hidden" name="date" value="${date}" />
                            <input type="hidden" name="status" value="${status}" />
                            <button
                                class="relative block rounded bg-blue-100 px-3 py-1.5 text-sm font-medium text-primary-700 transition-all duration-300"
                                name="page" value="<%=        (Integer.parseInt(currPage))%>"
                                ><%=          currPage%>
                                <span
                                    class="absolute -m-px h-px w-px overflow-hidden whitespace-nowrap border-0 p-0 [clip:rect(0,0,0,0)]"
                                    >(current)</span
                                >
                            </button>
                        </form>
                    </li>
                    <li>
                        <form action="mainController">
                            <input type="hidden" name="action" value="<%=    CONSTANTS.GETPRODUCT_ADMIN%>" />
                            <input type="hidden" name="sec" value="${sec}" />
                            <input type="hidden" name="search" value="${search}" />
                            <input type="hidden" name="date" value="${date}" />
                            <input type="hidden" name="status" value="${status}" />
                            <button
                                class="relative block rounded bg-transparent px-3 py-1.5 text-sm text-neutral-600 transition-all duration-300 hover:bg-neutral-100 dark:text-white dark:hover:bg-neutral-700 dark:hover:text-white"
                                name="page" value="<%=        (Integer.parseInt(currPage) + 1)%>"
                                ><%=          (Integer.parseInt(currPage) < maxPage) ? (Integer.parseInt(currPage) + 1) : ""%></button
                            >
                        </form>
                    </li>
                    <!--End 3 Button--> 
                    <li class= "<%=          (Integer.parseInt(currPage) == maxPage) ? "hidden" : ""%>"   >
                        <form action="mainController">
                            <!--    CONSTANTS.VIEWPRODUCT_ADMIN -->    
                            <input type="hidden" name="action" value="<%= CONSTANTS.GETPRODUCT_ADMIN%>" />
                            <input type="hidden" name="sec" value="${sec}" />
                            <input type="hidden" name="search" value="${search}" />
                            <input type="hidden" name="date" value="${date}" />
                            <input type="hidden" name="status" value="${status}" />

                            <button name="page" value="<%=   (Integer.parseInt(currPage) < maxPage) ? (Integer.parseInt(currPage) + 1) : (Integer.parseInt(currPage))%>" 
                                    class="relative block rounded bg-transparent px-3 py-1.5 text-sm text-neutral-500 transition-all duration-300 dark:text-neutral-400">Next</button>
                        </form>

                    </li>
                </ul>
            </nav>
        </div>


    </body>
</html>
