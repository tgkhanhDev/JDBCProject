<%-- 
    Document   : index
    Created on : Mar 18, 2024, 11:26:58 PM
    Author     : ACER
--%>

<%@page import="controllers.CONSTANTS"%>
<%@page import="DAO.ProductDAO"%>
<%@page import="DTO.Product"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <section class="py-24 relative">
            <div class="w-full max-w-7xl px-4 md:px-5 lg-6 mx-auto">

                <h2 class="title font-manrope font-bold text-4xl leading-10 mb-8 text-center text-black">Payment
                </h2>
                <div class="hidden lg:grid grid-cols-2 py-6">
                    <div class="font-normal text-xl leading-8 text-gray-500">Product</div>
                    <p class="font-normal text-xl leading-8 text-gray-500 flex items-center justify-between">
                        <span class="w-full max-w-[200px] text-center">Delivery Charge</span>
                        <span class="w-full max-w-[260px] text-center">Quantity</span>
                        <span class="w-full max-w-[200px] text-center">Total</span>
                    </p>
                </div>

                <!--row--> 
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
                <div class="grid grid-cols-1 lg:grid-cols-2 min-[550px]:gap-6 border-t border-gray-200 py-6">
                    <div
                        class="flex items-center flex-col min-[550px]:flex-row gap-3 min-[550px]:gap-6 w-full max-xl:justify-center max-xl:max-w-xl max-xl:mx-auto">
                        <div class="img-box"><img src="<%= prd.getThumbnail()%>" alt="perfume bottle image" class="xl:w-[140px]"></div>
                        <div class="pro-data w-full max-w-sm ">
                            <h5 class="font-semibold text-xl leading-8 text-black max-[550px]:text-center"><%=   prd.getName()%></h5>
                            <p
                                class="font-normal text-lg leading-8 text-gray-500 my-2 min-[550px]:my-3 max-[550px]:text-center">
                                Speed: <%=   prd.getSpeed()%></p>
                            <h6 class="font-medium text-lg leading-8 text-indigo-600  max-[550px]:text-center">$<%= prd.getPrice()%></h6>
                        </div>
                    </div>
                    <div
                        class="flex items-center flex-col min-[550px]:flex-row w-full max-xl:max-w-xl max-xl:mx-auto gap-2">
                        <h6 class="font-manrope font-bold text-2xl leading-9 text-black w-full max-w-[176px] text-center">
                            $0.00 <span class="text-sm text-gray-300 ml-3 lg:hidden whitespace-nowrap">(Delivery
                                Charge)</span></h6>
                        <div class="flex items-center w-full mx-auto justify-center">

                            <input type="text"
                                   class="border-y border-gray-200 outline-none text-gray-900 font-semibold text-lg w-full max-w-[118px] min-w-[80px] placeholder:text-gray-900 py-[15px] text-center bg-transparent"
                                   placeholder="<%=  entry.getValue()%>" readonly>

                        </div>
                        <h6
                            class="text-indigo-600 font-manrope font-bold text-2xl leading-9 w-full max-w-[176px] text-center">
                            $<%= prd.getPrice() * entry.getValue()%></h6>
                    </div>
                </div>
                <%
                        }
                    }
                %>
                <!--//END--> 

                <div class="bg-gray-50 rounded-xl p-6 w-full mb-8 max-lg:max-w-xl max-lg:mx-auto">
                    <div class="flex items-center justify-between w-full mb-6">
                        <p class="font-normal text-xl leading-8 text-gray-400">Sub Total</p>
                        <h6 class="font-semibold text-xl leading-8 text-gray-900">$<%= total%></h6>
                    </div>
                    <div class="flex items-center justify-between w-full pb-6 border-b border-gray-200">
                        <p class="font-normal text-xl leading-8 text-gray-400">Delivery Charge</p>
                        <h6 class="font-semibold text-xl leading-8 text-gray-900">$0.00</h6>
                    </div>
                    <div class="flex items-center justify-between w-full py-6">
                        <p class="font-manrope font-medium text-2xl leading-9 text-gray-900">Total</p>
                        <h6 class="font-manrope font-medium text-2xl leading-9 text-indigo-500">$<%= total%></h6>
                    </div>
                </div>
                <div class="flex items-center flex-col sm:flex-row justify-center gap-3 mt-8">
                    <form action="mainController" >
                        <input type="hidden" name="action" value="<%=  CONSTANTS.GETPRODUCTS  %>"/>
                        <button
                            class="rounded-full py-4 w-full max-w-[280px]  flex items-center bg-indigo-50 justify-center transition-all duration-500 hover:bg-indigo-100">
                            <div class="rotate-[180deg]">
                                <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 22 22" fill="none">
                                <path d="M8.25324 5.49609L13.7535 10.9963L8.25 16.4998" stroke="#4F46E5" stroke-width="1.6"
                                      stroke-linecap="round" stroke-linejoin="round" />
                                </svg>
                            </div>
                            <span class="px-2 font-semibold text-lg leading-8 text-indigo-600">Back to Cart</span>
                        </button>
                    </form>

                    <form action="mainController" >
                        <input type="hidden" name="action" value="<%=  CONSTANTS.PAYALLPRODUCTS %>"/>
                        <button
                            class="rounded-full w-full max-w-[280px] py-4 text-center justify-center items-center bg-indigo-600 font-semibold text-lg text-white flex transition-all duration-500 hover:bg-indigo-700 px-8">Pay All
                            <svg class="ml-2" xmlns="http://www.w3.org/2000/svg" width="23" height="22" viewBox="0 0 23 22"
                                 fill="none">
                            <path d="M8.75324 5.49609L14.2535 10.9963L8.75 16.4998" stroke="white" stroke-width="1.6"
                                  stroke-linecap="round" stroke-linejoin="round" />
                            </svg>
                        </button>
                    </form
                </div>
            </div>
        </section>
    </body>
</html>
