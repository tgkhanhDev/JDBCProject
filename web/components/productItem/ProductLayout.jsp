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

            <div class="flex justify-between relative">
                <div class="pageTitle">Sản phẩm</div>
                <div class="absolute right-0">
                    <form action="mainController" >
                        <button
                            class="rounded-full w-full max-w-[280px]  flex items-center  justify-center transition-all duration-500 hover:bg-indigo-400 ">
                            <div class="rotate-[180deg] text-indigo-100">
                                <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 22 22" fill="none">
                                <path d="M8.25324 5.49609L13.7535 10.9963L8.25 16.4998" stroke="#4F46E5" stroke-width="1.6"
                                      stroke-linecap="round" stroke-linejoin="round" />
                                </svg>
                            </div>
                            <span class="px-2 font-semibold text-lg leading-8 text-indigo-100">Back to Home</span>
                        </button>
                    </form>
                </div>
            </div>


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
                            <th scope="col" class="px-6 py-3 text-center">
                                Action
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
                                    total += (entry.getValue() * prd.getPrice());
                        %>
                        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                            <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                <%= no%>
                            </th>
                            <td class="px-6 py-4">
                                <img src="<%=  prd.getThumbnail()%>" alt="<%= prd.getName()%>" class="w-[200px]" />
                            </td>
                            <td class="px-6 py-4">
                                <%=  prd.getName()%>
                            </td>
                            <td class="px-6 py-4">
                                <%=   prd.getSpeed()%>
                            </td>
                            <td class="px-6 py-4">
                                <%= prd.getPrice()%>$
                            </td>
                    <form action="mainController" >
                        <input type="hidden" name="action" value="<%=  CONSTANTS.UPDATECART%>"/>
                        <input type="hidden" name="prdID" value="<%=  prd.getPrd_ID()%>"/>
                        <td class="px-6 py-4 text-center">
                            <input class="rounded-xl text-center mx-auto block" type="number" name="quantity" value="<%= entry.getValue()%>"/>
                        </td>
                        <td class="px-6 py-4 text-center">
                            <button class="px-6 py-3 rounded bg-yellow-500">Update</button>
                        </td>
                    </form>

                    </tr>
                    <%
                        }
                    %>

                    <%
                        }
                    %>
                    </tbody>
                </table>
                <div class="flex justify-between px-10 text-xl mt-5">
                    <div></div>
                    <div><span class="font-bold">Total: </span><%=total%>$</div>
                </div>
                <div class="">
                    <form action="mainController" class="flex justify-between px-10">
                        <input type="hidden" name="action" value="<%=   CONSTANTS.VIEWPAYMENT%>" />
                        <div></div>
                        <button class="px-6 py-3 rounded bg-green-500">Go to Payment</button>
                    </form>
                </div>
            </div>

        </div>

        <%
            String mess = (String) request.getAttribute("message");
            if (mess != null)
            {
        %>
        <script>
            alert("<%=  mess%>");
        </script>
        <%
            }
        %>

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
