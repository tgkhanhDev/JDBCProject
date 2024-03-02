<%-- 
    Document   : profile
    Created on : Feb 24, 2024, 9:45:11 PM
    Author     : Lenovo
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="DTO.Employee"%>
<%@page import="DTO.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.tailwindcss.com"></script>

        <title>JSP Page</title>
    </head>
    <body class="max-w-[var(--maxWidth)] w-[100vw] m-auto mb-[0px]  overflow-x-hidden transition-all ease-in-out duration-500">

        <%
            Account acc = (Account) session.getAttribute("loginUser");
            Employee em = null;
            if (acc.getRole().getRoleID() != 1) {

                em = (Employee) session.getAttribute("emInfor");

            }

        %>

        <div class="title flex w-[full] bg-sky-700 text-white h-[110px] items-center text-[20px] shadow-sm pl-[103px]">
            HỒ SƠ CỦA TÔI
        </div>

        <div class="content grid grid-cols-12 gap-5 p-[40px]  pb-[0px] ">
            <div
                class="avatar_content   bg-gray-100 radius rounded-lg border-2 border-sky-700 col-span-12 xl:col-span-4 flex flex-col items-center  h-full">
                <div class="img_avatar mt-[64px]">
                    <img src="/PrjProject/img/profile/img_profile.png" alt="">
                </div>
                <div class="tilte_name">
                    <%= acc.getLastName().trim() + " " + acc.getFirstName().trim()%>
                </div>
                <div class="title_role mb-0">
                    <span class="text-cyan-500">Role:</span> <%= acc.getRole().getRoleName()%> 
                </div>
                <% if(acc.getRole().getRoleID()!=1){%>
                
                <div class="title_role mb-[10px] lg:mb-0">
                    <span class="text-cyan-500">Major:</span> <%= em .getMajor().getMajorName() %> 
                </div>
                <%}%>
            </div>
            <!-- phan ben display ne  -->
            <div
                class="infor_content grid md:grid-cols-2 p-[16px] pb-[60px]  bg-sky-700 rounded-lg border-2 border-sky-700  col-span-12 xl:col-span-8 ">
                <div
                    class=" col-span-2 grid grid-cols-2 gap-5  rounded-lg border-2 mt-[10px] mb-[20px] ml-[50px] mr-[50px]  xl:ml-[150px] xl:mr-[150px] bg-white">
                    <div class="h-[20px] col-span-1 flex justify-center  lg:gap-6 mt-[14px] mb-[14px] ml-[20px] mr-[20px] pl-[15px] pr-[15px]">
                        <img src="/PrjProject/img/profile/icon_proflie.png" alt="">
                        <p>Profile</p>
                    </div>
                    <div class="h-[20px] col-span-1 flex justify-center  lg:gap-6 mt-[14px] mb-[14px] ml-[20px] mr-[20px]">
                        <img src="/PrjProject/img/profile/icon_proflie.png" alt="">
                        <p>Profile</p>
                    </div>
                </div>
                <!-- account detail -->

                <div class="col-span-2  grid grid-cols-2 bg-white  rounded-lg border-2 text-slate-500  ">
                    <div class=" hidden  col-span-1 lg:flex items-center pl-[24px]">
                        <p>Account</p>

                    </div>
                    <div
                        class=" flex flex-col gap-3 justify-center lg:block lg:justify-normal lg:gap-0 lg:ml-0 lg:mr-0 col-span-2 lg:col-span-1 email_infor p-[16px] ml-[25px] mr-[25px] md:ml-[150px] md:mr-[150px]   ">
                        <p class="lg:hidden text-lg">Account</p>
                        <p>Email</p>
                        <div class="bg-gray-100 flex  mr-[65px] items-center  border-2  border-gray-200">
                            <img class="h-[20px] pl-[4px]" src="/PrjProject/img/profile/email_icon.png" alt="">
                            <p class="p-[8px] "> <%= acc.getGmail()%> </p>
                        </div>

                    </div>
                    <div class="col-span-2 mt-[24px] mb-[24px]">
                        <hr>
                    </div>

                    <div class=" hidden col-span-1 lg:flex items-center pl-[24px]">
                        <p>Personal informations</p>
                    </div>

                    <div
                        class=" col-span-2 lg:col-span-1   email_infor ml-[25px] mr-[25px] md:ml-[150px] md:mr-[150px]   lg:ml-0 lg:mr-0  p-[16px] mb-[16px]">
                        <p class="lg:hidden text-lg mb-[10px]">Personal informations</p>
                        <p>Full name</p>
                        <div class="bg-gray-100 flex mr-[65px] items-center  border-2  border-gray-200">
                            <img class="h-[22px] pl-[4px]" src="/PrjProject/img/profile/personIcon.png" alt="">
                            <p class="p-[8px] "><%=  acc.getLastName().trim() + " " + acc.getFirstName().trim()%></p>
                        </div>

                        <p class="mt-[20px] ">Phone number</p>
                        <div class="bg-gray-100 flex mr-[65px] items-center  border-2  border-gray-200">
                            <img class="h-[22px] pl-[4px]" src="/PrjProject/img/profile/phone.png" alt="">
                            <p class="p-[8px] "><%= acc.getPhone()%></p>
                        </div>

                        <!--- cua nhan vien ti sua -->
                        <% if (acc.getRole().getRoleID() != 1) {%>
                        <p class="mt-[20px] ">Identify</p>
                        <div class="bg-gray-100 flex mr-[65px] items-center  border-2  border-gray-200">
                            <img class="h-[22px] pl-[4px]" src="/PrjProject/img/profile/identify.png" alt="">
                            <p class="p-[8px] "><%=  em.getIdentify_ID()%></p>
                        </div>
                        <%}%>


                    </div>



                    <div class="col-span-2 mt-[24px] mb-[24px]">
                        <hr>
                    </div>

                    <div class="hidden col-span-1 lg:flex items-center pl-[24px]">
                        <p>Other informations</p>
                    </div>

                    <div
                        class="col-span-2 lg:col-span-1   email_infor ml-[25px] mr-[25px] md:ml-[150px] md:mr-[150px]   lg:ml-0 lg:mr-0  p-[16px] mb-[16px]">
                        <p class="lg:hidden text-lg mb-[10px]">Other informations</p>


                        <% if (acc.getRole().getRoleID() != 1) { %>
                        <%  Date birth = em.getDayOfBirth();
                            Calendar calB = Calendar.getInstance();
                            calB.setTime(birth);
                            calB.clear(Calendar.HOUR);
                            calB.clear(Calendar.MINUTE);
                            calB.clear(Calendar.SECOND);
                            calB.clear(Calendar.MILLISECOND);
                            birth= calB.getTime();
                            String formattedBirth = new SimpleDateFormat("dd-MM-yyyy").format(birth);
                        %>

                        <p>Date of birth</p>
                        <div class="bg-gray-100 flex mr-[65px] items-center  border-2  border-gray-200">
                            <img class="h-[22px] pl-[4px]" src="/PrjProject/img/profile/dayOfbirth.png" alt="">
                            <p class="p-[8px] "><%= formattedBirth %></p>
                        </div>
                            <%
                             Date working = em.getWorkingDay();
                            Calendar calW = Calendar.getInstance();
                            calW.setTime(working);
                            calW.clear(Calendar.HOUR);
                            calW.clear(Calendar.MINUTE);
                            calW.clear(Calendar.SECOND);
                            calW.clear(Calendar.MILLISECOND);
                            working= calW.getTime();
                            String formattedWorking = new SimpleDateFormat("dd-MM-yyyy").format(working);
                            
                            %>
                        <p>Working Day</p>
                        <div class="bg-gray-100 flex mr-[65px] items-center  border-2  border-gray-200">
                            <img class="h-[22px] pl-[4px]" src="/PrjProject/img/profile/dayOfbirth.png" alt="">
                            <p class="p-[8px] "><%= formattedWorking %></p>
                        </div>

                        <%}%>


                        <p class="mt-[20px] ">Sex</p>
                        <div class="bg-gray-100 flex mr-[65px] items-center  border-2  border-gray-200">
                            <img class="h-[22px] pl-[4px]" src="/PrjProject/img/profile/sex.png" alt="">
                            <p class="p-[8px] "><%= acc.getSex()%></p>
                        </div> 

                    </div>

                    <div class="col-span-2 mb-[20px] ">
                        <hr>
                          <div class ="flex justify-center w-full">
                            <!-- msg o day ne !!!!!!!!!!!  -->
                            <%
                                String msg =(String) request.getAttribute("NOTIFYPRO");
                            %>
                            <p class="font-bold text-lg text-blue-500" > <%= (msg!=null)?msg:"" %></p>
                        </div>
                    </div>

                    <div class="col-span-2 mt-[0px] mb-[24px] mr-[32px] flex justify-end">

                        <form action="mainController" method="post">
                            <input type="hidden" name="action" value="viewuppro" >
                            <button 
                                class="statusButton flex items-center bg-green-400 hover:bg-green-600 text-white font-bold py-2 px-4 rounded">
                                <img class="h-[16px] m-[8px]" src="/PrjProject/img/profile/reset.png" alt="">
                                cập nhật
                            </button>
                        </form>




                    </div>

                </div>



            </div>
        </div>



    </body>
</html>
