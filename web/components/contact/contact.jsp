<%-- 
    Document   : contact
    Created on : Mar 11, 2024, 8:48:52 PM
    Author     : Lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://cdn.tailwindcss.com"></script>

        <style>
            .popup {
                background-color: rgb(0, 0, 0, 0.7);
                width: 100%;
                height: 100%;
                position: fixed;
                top: 0;
                left: 0;
                bottom: 0;
                display: none;
                justify-content: center;
                align-items: center;
            }

            /* Chưa xác nhận */
            .option-false {
                background-color: #EF4444;
                /* Màu đỏ */
                color: white;
                /* Màu chữ trắng */
            }

            /* Xác nhận */
            .option-true {
                background-color: #6ade38;
                /* Màu xanh lá cây */
                color: black;
                /* Màu chữ đen */
            }

            .popup-content {
                height: auto;
                width: auto;
                background-color: white;
                padding: 10px;
                border-radius: 5px;
                position: relative;
            }

            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
            }



            .pagination-item-active .pagination-item_link {
                color: white;
                background-color: rgb(3, 105, 161);

            }

            .pagination-item_link {
                display: block;
                text-align: center;
                text-decoration: none;
                font-size: 1rem;

                min-width: 20px;
                height: 27px;
                border-radius: 2px;
            }

        </style>
    </head>
    <body class=" max-w-[var(--maxWidth)] w-[100vw] m-auto overflow-x-hidden transition-all ease-in-out duration-500 ">


        <div class=" m-[10px] bg-sky-700 p-[5px] text-white">

            <p class="font-semibold text-2xl">TRANSACTION INFORMATION</p>


        </div>

        <form class=" content  m-[10px]  p-[10px]  pb-[15px] border-2 rounded-lg     border-gray-400">
            <div class="grid grid-cols-12">
                <div class="col-span-9 grid grid-cols-10 ">
                    <div class=" col-span-10 flex justify-start font-bold pl-[10px]">
                        <p>Tìm kiếm trạng thái hợp đồng</p>
                    </div>
                    <div class="col-span-3 flex border-2 border-gray-400 rounded-md ">
                        <button class=" cursor-pointer bg-gray-100  rounded-l-md   border-2 border-r-gray-400 "><img
                                class="w-[29px] h-[22px]" src="/PrjProject/img/contact/sreach.png" alt=""></button>
                        <input class=" pr-[10px] pl-[10px] text-base w-full outline-none  bg-slate-200 " type="search"
                               name="searchheadertxt" placeholder="nhập id hoặc ngày giao dịch">
                    </div>
                    <div class="col-span-7">

                    </div>
                </div>
                <div class=" col-span-3   w-full ">
                    <div class="flex justify-center font-bold">
                        <p>Tìm kiếm trạng thái hợp đồng</p>
                    </div>
                    <div class="flex justify-end w-full border-2 border-gray-400 rounded-md ">
                        <button class=" cursor-pointer bg-gray-100  rounded-l-md   border-2 border-r-gray-400 "><img
                                class="w-[29px] h-[22px]" src="/PrjProject/img/contact/sreach.png" alt=""></button>
                        <select class="bg-gray-100 p-[8px] w-full hover:selection:backdrop:bg-none  outline-none"
                                name="statustxt">
                            <option value="" selected>tất cả</option>
                            <option value="false">Chưa xác nhận</option>
                            <option value="true">xác nhận</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="m-[10px] ">
                <hr>
            </div>
            <table class="w-full border-2  rounded-l-md    border-gray-400 ">

                <tr class="  grid grid-cols-12  text-white bg-slate-500        ">
                    <th class="col-span-2 flex justify-center border-2     border-gray-400">ID giao dịch</th>
                    <th class="col-span-3 flex justify-center border-2   border-gray-400">Tên giao dịch</th>
                    <th class="col-span-4 flex justify-center border-2     border-gray-400">Ngày giao dịch</th>
                    <th class="col-span-2 flex justify-center border-2     border-gray-400">Trạng thái</th>
                    <th class="col-span-1 flex justify-center border-2    border-gray-400">Chi tiết</th>
                </tr>
                <tr class="  grid grid-cols-12 border-1 rounded-md   ">
                    <td class="col-span-2 flex justify-center border-2        border-gray-400">id</td>
                    <td class="col-span-3 flex justify-center border-2   border-gray-400">Sản phẩm</td>
                    <td class="col-span-4 flex justify-center border-2     border-gray-400">ngày mua</td>
                    <td class="col-span-2 flex justify-center border-2      border-gray-400">
                        <select class="bg-red-500 w-full  outline-none cursor-pointer" name="statustxt">
                            <option value="false" selected class="option-false ">Chưa xác nhận</option>
                            <option value="true" class="option-true">Xác nhận</option>
                        </select>

                    </td>
                    <td id=""
                        class="butonMore col-span-1 flex justify-center border-2 text-green-400 hover:text-green-500 cursor-pointer      border-gray-400"
                        data-popup-id="popup1">
                        xem thêm</td>
                </tr>

                <tr class="  grid grid-cols-12 border-1 rounded-md   ">
                    <td class="col-span-2 flex justify-center border-2         border-gray-400">id</td>
                    <td class="col-span-3 flex justify-center border-2   border-gray-400">Sản phẩm</td>
                    <td class="col-span-4 flex justify-center border-2     border-gray-400">ngày mua</td>
                    <td class="col-span-2 flex justify-center border-2      border-gray-400" data-popup-id="popup2">
                        <select class="bg-green-500 w-full  outline-none cursor-pointer " name="statustxt">
                            <option value="false" class="option-false">Chưa xác nhận</option>
                            <option value="true" selected class="option-true">Xác nhận</option>
                        </select>

                    </td>
                    <td id=""
                        class="butonMore col-span-1 flex justify-center border-2 text-green-400 hover:text-green-500 cursor-pointer      border-gray-400"
                        data-popup-id="popup2">
                        xem thêm</td>
                </tr>

                <div class="popup" id="popup2">
                    <div class="popup-content relative border-[17px] rounded-md border-white  bg-sky-400">
                        <img class="closePopup absolute pt-[2px] pr-[2px] top-[-18px] right-[-18px]  w-[20px] h-[20px] cursor-pointer "
                             src="/PrjProject/img/contact/closeButton.png" alt="">
                        <div class="flex gap-2 mb-[10px] border-2  bg-white border-gray-300 rounded-lg ">
                            <img class="w-[250px] h-auto   " src="/PrjProject/img/contact/closeButton.png" alt="">
                            <div class="flex flex-col w-[240px] border-l-2 border-l-gray-300 text-start gap-0">
                                <p class="font-bold flex justify-center text-xl pl-[5px] bg-gray-400">Thông tin giao dịch</p>
                                <hr class="border-2 border-gray-400">
                                <div class="flex flex-col gap-1">
                                    <p><span class="font-bold pl-[5px] ">Người Giao dịch:</span>
                                    </p>
                                    <p><span class="font-bold pl-[5px]">Dịch vụ:</span>
                                    </p>
                                    <p><span class="font-bold pl-[5px] ">Tiền dịch vụ:</span>
                                    </p>
                                    <p> <span class="font-bold pl-[5px] ">Tên sản phẩm:</span>thg lone
                                    </p>
                                    <p> <span class="font-bold pl-[5px] ">Giá tiền sản phẩm:</span>190000
                                    </p>
                                    <p> <span class="font-bold pl-[5px] ">Ngày giao dịch:</span>
                                        19/9/2003
                                    </p>
                                    <p> <span class="font-bold pl-[5px] ">Số lượng:</span>3
                                    </p>
                                    <p> <span class="font-bold pl-[5px] ">Tổng tiền:</span>300
                                    </p>
                                    <hr class="mt-[5px]">
                                </div>
                            </div>
                        </div>
                        <div class="  w-auto h-auto grid grid-cols-12  gap-0  border-2  border-gray-300 rounded-lg bg-white ">
                            <div class="col-span-12 bg-gray-400">
                                <p class="text-center font-bold text-2xl  mb-[5px]  ">Thông tin thêm</p>
                                <hr>

                            </div>
                            <div class=" flex flex-col col-span-6 border-r-2 border-r-gray-300 p-[5px] ">

                                <p> <span class="font-bold">Tên sản phẩm:</span> da </p>

                                <p> <span class="font-bold">Loại Sản phẩm:</span> thg lone</p>
                                <p> <span class="font-bold">Mô tả:</span> das </p>
                                <p> <span class="font-bold">tốc độ:</span> 2000</p>
                                <p><span class="font-bold">ID hợp đồng:</span> 1234</p>
                            </div>
                            <div class="col-span-6 flex flex-col gap-2 pl-[2px]">
                                <p> <span class="font-bold">Tên người dùng:</span> da
                                </p>
                                <p> <span class="font-bold">Gmail:</span> da
                                </p>
                                <p> <span class="font-bold">Số điện thoại:</span> da
                                </p>
                                <p> <span class="font-bold">Vai trò:</span> da
                                </p>

                            </div>

                        </div>
                    </div>
                </div>
            </table>


            <ul class="pagination mt-[10px] gap-3 text-gray-500 ">
                <li class="pagination-item-active hover:bg-cyan-600 hover:text-white">
                    <input type="submit"class="cursor-pointer pagination-item_link" name ="index" value="1">  
                </li>

                <li class="pagination-item hover:bg-cyan-600 hover:text-white">
                    <input type="submit"class="cursor-pointer pagination-item_link" name ="index" value="2">  
                </li>


                <li class="pagination-item hover:bg-cyan-600 hover:text-white">
                    <input type="submit"class="cursor-pointer pagination-item_link" name ="index" value="3">  
                </li>

                <li class="pagination-item hover:bg-cyan-600 hover:text-white">
                    <input type="submit"class="cursor-pointer pagination-item_link" name ="index" value="4">  
                </li>

            </ul>

        </form>



    </body>
    <script>
        const buttons = document.querySelectorAll(".butonMore");

        buttons.forEach(function (button) {
            button.addEventListener("click", function () {
                const popupId = button.getAttribute("data-popup-id");
                const popup = document.getElementById(popupId);
                if (popup) {
                    popup.style.display = "flex";
                }
            });
        });

        document.querySelectorAll(".closePopup").forEach(function (closeButton) {
            closeButton.addEventListener("click", function () {
                const popup = closeButton.closest('.popup');
                if (popup) {
                    popup.style.display = "none";
                }
            });
        });

    </script>

</html>
