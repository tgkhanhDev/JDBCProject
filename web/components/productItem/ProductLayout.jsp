<%-- 
    Document   : ProductLayout
    Created on : Mar 15, 2024, 6:06:37 PM
    Author     : ACER
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
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
        <title>JSP Page</title>
    </head>
    <body>
        <div class="max-w-[var(--maxWidth)] w-[95vw] m-auto overflow-x-hidden transition-all ease-in-out duration-500">

            <div class="pageTitle">Sản phẩm</div>

            <!-- Section -->
            <div class="flex justify-center gap-10 bg-gray-100 py-8">

                <%
                    ArrayList<ProductCategories> cateList = new ProductDAO().getAllCategories();
                    if (cateList != null)
                    {
                        for (ProductCategories item : cateList)
                        {
                %>
                <form action="mainController">
                    <input type="hidden" name="action" value=<%=            CONSTANTS.GETPRODUCTS%>>
                    <input type="hidden" name="cateID" value=<%=item.getCate_ID()%>> <!--  Lấy ID bỏ vào param  -->
                    <button type="submit" class="flex items-center flex-col cursor-pointer"> 
                        <div class="bg-gray-300 rounded-[50%] p-2"> 
                            <img class="w-[50px] text-white" src= <%=        item.getIcon()%>  alt=<%=        item.getName()%>  />
                        </div> 
                        <%
                            if (request.getParameter("cateID") != null)
                            {
                        %>
                        <div class="font-bold text-xl <%=(request.getParameter("cateID").equals(item.getCate_ID())) ? "text-blue-500" : ""%>"> <%=        item.getName()%>   </div> 
                        <%
                            }
                        %>
                    </button>
                </form>
                <%
                        }
                    }
                %>


            </div>

            <!--ITEM FRAME--> 
            <div class="grid grid-cols-6 p-2 gap-10">

                <%
                    ArrayList<Product> list = (ArrayList<Product>) request.getAttribute("productList");
                    if (list != null)
                    {
                        for (Product item : list)
                        {
                            //Status hd moi render
                            if (item.getStatus().equals("1"))
                            {

                %>
                <div style="box-shadow: rgba(50, 50, 93, 0.25) 0px 6px 12px -2px, rgba(0, 0, 0, 0.3) 0px 3px 7px -3px;"
                     class="rounded-2xl text-sm xl:col-span-2 md:col-span-3 col-span-6 py-4 px-8 text-center flex flex-col justify-center items-center gap-3">
                    <div class="text-green-500 text-2xl font-bold italic"> <%=       item.getName()%> </div>
                    <img src=<%=     item.getThumbnail()%> class="w-1/2" alt=<%=       item.getName()%> />


                    <!-- speed -->
                    <span class="px-4 py-2 rounded-xl bg-blue-500 "> <%=       item.getSpeed()%> Mbps </span>

                    <!-- Speed commerce -->
                    <div class="">
                        <p class="">Tốc độ Download <%=       item.getSpeed()%>  Mbps</p>
                        <p class="">Tốc độ Upload <%=       item.getSpeed()%>  Mbps</p>
                    </div>

                    <!-- linebreak -->
                    <div class="bg-black h-[1px] rounded-2xl my-2 w-[70%]"></div>

                    <!-- description -->
                    <div class=""><%=       item.getDescription()%> </div>

                    <!-- linebreak -->
                    <div class="bg-black h-[1px] rounded-2xl my-2 w-[70%]"></div>

                    <!-- commer -->
                    <div class="">
                        <p class="">Giảm ngay 90.000đ (áp dụng đến 31/12)</p>
                        <p class="">Tặng thêm đến 2 tháng (áp dụng theo khu vực)</p>
                        <p class="">Ưu tiên lắp đặt trong 12h - 36h</p>
                    </div>

                    <form action="mainController">
                        <input type="hidden" name="action" value="<%=  CONSTANTS.TABLECART%>" />
                        <input type="hidden" name="prdID" value="<%=  item.getPrd_ID()%>" />
                        <button class="text-white px-4 py-2 bg-green-500 rounded-lg">Đăng ký ngay</button>
                    </form>
                    <!-- Policy -->
                    <div class="text-xs text-gray-300 italic">
                        Mức giá trên đã bao gồm VAT. Giá này sẽ thay đổi theo khu vực, theo từng thời điểm, chưa bao gồm
                        tiền thuê thiết bị đầu cuối, phí thu tiền dịch vụ tại nhà và các dịch vụ gia tăng đi kèm khác
                    </div>
                </div>
                <%
                            }

                        }

                    }

                %>
            </div>
            <!--END ITEM FRAME--> 
        </div>

        <!--CART -->
        <jstl:set var="toItem" value="${sessionScope.totalCartItems}" />

        <div class="fixed bottom-10 right-10 ">
            <div class="absolute top-[-5px] right-0">
                <jstl:choose>
                    <jstl:when test="${toItem != null}">${toItem}</jstl:when>
                    <jstl:otherwise>0</jstl:otherwise>
                </jstl:choose>
            </div>
            <button id="viewCartListBtn" class=" p-3 rounded-2xl bg-gray-400">View</button>
        </div>

        <!--Table Cart--> 
        <div id="tableCart" class="fixed top-0 left-0 h-screen w-[60vw] bg-gray-100 z-50 transition-all ease-in-out duration-700 !left-[-65vw] overflow-scroll">
            <div class="text-2xl font-bold flex justify-center my-20">Giỏ hàng</div>
            <div>
                <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400 overflow-scroll">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                        <tr>
                            <th scope="col" class="px-6 py-3">
                                No
                            </th>
                            <th scope="col" class="px-6 py-3">
                                Thumbnail
                            </th>
                            <th scope="col" class="px-6 py-3">
                                Name
                            </th>
                            <th scope="col" class="px-6 py-3">
                                Speed
                            </th>
                            <th scope="col" class="px-6 py-3">
                                Price
                            </th>
                            <th scope="col" class="px-6 py-3 text-center">
                                Quantity
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <jsp:useBean id="prdDAO" class="DAO.ProductDAO" scope="page" />
                        <%--<jstl:set var="cartList" value="${sessionScope.cartList}" />--%>

                        <%HashMap<String, Integer> cart = (HashMap<String, Integer>) session.getAttribute("cartList");
                            int total = 0;
                            int no = 0;
                            if (cart != null)
                            {
                                for (Map.Entry<String, Integer> entry : cart.entrySet())
                                {
                                    no++;
                                    Product prd = new ProductDAO().getProductByID(entry.getKey());
                                      total += (entry.getValue()* prd.getPrice());
                        %>
                        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                            <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                <%= no%>
                            </th>
                            <td class="px-6 py-4">
                                <%=  prd.getThumbnail()%>
                            </td>
                            <td class="px-6 py-4">
                                <%=  prd.getName()%>
                            </td>
                            <td class="px-6 py-4">
                                <%=   prd.getSpeed()%>
                            </td>
                            <td class="px-6 py-4">
                                <%= prd.getPrice() %>$
                            </td>
                            <td class="px-6 py-4 text-center">
                                <%= entry.getValue() %>
                            </td>
                        </tr>
                        <%
                            }
                        %>

                        <%
                            }
                        %>


                        <jstl:if test="${cartList != null}">
                            <jstl:forEach var="item" items="cartList" >

                            </jstl:forEach>
                        </jstl:if>
                    </tbody>
                </table>
                <div>Total: <%=total%>$</div>
            </div>

        </div>
        <script>
            console.log("Hello Cart JS");


            let viewCartBtn = document.querySelector("#viewCartListBtn");
            let tableCartLayout = document.querySelector("#tableCart");
            viewCartBtn.addEventListener("click", () => {
                tableCartLayout.classList.toggle("!left-[-65vw]");
            })
        </script>
    </body>
</html>
