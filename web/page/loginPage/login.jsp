<%-- 
    Document   : login
    Created on : Feb 13, 2024, 3:55:22 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Title</title>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />


    <!-- FontAwesome  -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
        integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />

    <!-- google font  -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Rubik&display=swap" rel="stylesheet">

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />

    <!-- Css  -->
    <link rel="stylesheet" href="page/loginPage/login.css">
    <link rel="stylesheet" href="utils.css">
</head>

<body style="background-image: url('img/login/login_background.png');
    background-repeat: no-repeat;
    background-size: cover ;
">
    <!-- Laptop  -->
    <div class="max-w-[var(--maxWidth)]  m-auto h-[100vh] hidden md:flex justify-center items-center ">
        <div class="relative w-[80%] bg-gray-500 rounded-xl flex container_login" style="border-radius: 20px 20px 20px 20px">
            <!-- cover page -->
            <div id="coverLayer"
                class="z-10 absolute w-[50%] h-[80vh] bg-[var(--secblue)] p-10 hidden md:flex items-center brLeft coverBg left:0 ">
                <div class="layerBackground"></div>
                <div class="w-full z-[1] ">
                    <img src="img/logo.png" alt="logo" class="h-64 w-64 m-auto">
                    <div class="flex flex-col items-center">
                        <div class="hidden lg:block text-3xl font-bold text-[var(--maingreen)]">
                            Welcome to F-Lightning
                        </div>
                        <div class="hidden lg:block text-gray-300">
                            Fast as Lightning-Light as hell
                        </div>
                    </div>
                    <!-- button  -->
                    <div class="flex flex-col mt-5">
                        <button
                            class="py-2 bg-[var(--maingreen)] text-xl w-[80%] m-auto rounded transition ease-in-all hover:bg-green-400 blink"
                            id="qtvBtn">Tôi là QTV</button>
                        <button
                            class="py-2 bg-yellow-500 text-xl w-[80%] m-auto rounded transition ease-in-all hover:bg-yellow-400 blink"
                            id="guestBtn">Tôi là Guest</button>
                    </div>
                </div>
            </div>

            <!-- QTV  -->
            <div class="w-[50%] h-[80vh]  p-10 flex items-center brLeft mainBgLeft relative overflow-hidden">
                <div class="qtvBg">
                    <img src="img/login/admin.png" alt="">
                </div>
                <div class="flex flex-col gap-7 w-full text-white z-[1]">
                    <div class="text-[2rem] font-bold m-auto">Chào mừng quản trị...</div>
                    <!-- form  -->
                    <form action="">
                        <div class="w-[70%] m-auto">
                            <div class="">Username:</div>
                            <input type="text" class="text-black w-full m-auto rounded-xl">
                        </div>
                        <div class="w-[70%] m-auto">
                            <div class="">Password:</div>
                            <input type="password" class="text-black w-full m-auto rounded-xl">
                            <div class="w-full flex justify-end"> <button
                                    class="px-4 py-2 rounded bg-yellow-500 blink">Login</button></div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Client  -->
            <div
                class="relative w-[50%] h-[80vh] text-[#ffffffe2] flex items-center brRight mainBgRight overflow-hidden">

                <!-- RegisterPage -->
                <div id="regPage" class="regPage brRight">
                    <div class="cusbg">
                        <img src="img/login/customer.png" alt="">
                    </div>
                    <div class="absolute top-3 right-5 z-[1]">
                        <button class="underline italic" id="swapLoginBtn">Quay về đăng nhập?</button>
                    </div>
                    <div class="flex flex-col gap-7 my-2 w-[90%] m-auto">
                        <div class="text-[2rem] font-bold m-auto">Đăng ký</div>
                        <!-- form  -->
                        <form action="">
                            <div class="lg:w-[70%] m-auto">
                                <div class="">Phone number (Username):</div>
                                <input type="text" class="text-black w-full m-auto rounded-xl">
                            </div>
                            <div class="lg:w-[70%] m-auto">
                                <div class="">Email:</div>
                                <input type="email" class="text-black w-full m-auto rounded-xl">
                            </div>
                            <div class="lg:w-[70%] m-auto">
                                <div class="">Password:</div>
                                <input type="password" class="text-black w-full m-auto rounded-xl">
                            </div>
                            <div class="lg:w-[70%] m-auto">
                                <div class="">Confirm Password:</div>
                                <input type="password" class="text-black w-full m-auto rounded-xl">
                                <div class="w-full flex justify-end"> <button
                                        class="px-4 py-2 rounded bg-yellow-500 blink">Sign up</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>


                <!-- login Page  -->
                <div class="w-full m-auto flex justify-center">
                    <div class="cusbg">
                        <img src="img/login/customer.png" alt="">
                    </div>
                    <div class="absolute top-3 right-5 ">
                        <button class="underline italic" id="swapRegBtn">Chưa có tài khoản?</button>
                    </div>
                    <div class="flex flex-col gap-7 w-[90%]">
                        <div class="text-[2rem] font-bold m-auto">Đăng nhập</div>
                        <!-- form  -->
                        <form action="">
                            <div class="lg:w-[70%] m-auto">
                                <div class="">Username:</div>
                                <input type="text" class="text-black w-full m-auto rounded-xl">
                            </div>
                            <div class="lg:w-[70%] m-auto">
                                <div class="">Password:</div>
                                <input type="password" class="text-black w-full m-auto rounded-xl">
                                <div class="flex justify-end text-xs mt-1 italic underline">Quên mật khẩu</div>
                                <div class="w-full flex justify-end"> <button
                                        class="px-4 py-2 rounded bg-yellow-500 blink">Login</button></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>


        </div>
    </div>

    <!-- Phone -->
    <div class="max-w-[var(--maxWidth)]  m-auto h-[100vh] flex md:hidden justify-center items-center ">
        <div class="relative w-[80%] h-[100vh] bg-gray-500 rounded-xl flex flex-col container_login"  style="border-radius: 20px 20px 20px 20px;">
            <!-- cover page -->
            <div id="coverLayer"
                class="z-10 absolute w-[100%] h-[50vh] bg-[var(--secblue)] p-10 flex items-center brTop coverBg left:0 ">
                <div class="layerBackground"></div>
                <div class="w-full z-[1]">
                    <img src="img/logo.png" alt="logo" class="h-36 w-36 m-auto">
                    <div class="flex flex-col items-center">
                        <div class="hidden lg:block text-3xl font-bold text-[var(--maingreen)]">
                            Welcome to F-Lightning
                        </div>
                        <div class="hidden lg:block text-gray-300">
                            Fast as Lightning-Light as hell
                        </div>
                    </div>
                    <!-- button  -->
                    <div class="flex flex-col mt-5">
                        <button
                            class="py-2 bg-[var(--maingreen)] text-xl w-[80%] m-auto rounded transition ease-in-all hover:bg-green-400 blink"
                            id="qtvBtn">Tôi là QTV</button>
                        <button
                            class="py-2 bg-yellow-500 text-xl w-[80%] m-auto rounded transition ease-in-all hover:bg-yellow-400 blink"
                            id="guestBtn">Tôi là Guest</button>
                    </div>
                </div>
            </div>

            <!-- QTV  -->
            <div class="w-[100%] h-[50vh] p-10 flex items-center brTop mainBgLeft relative overflow-hidden">
                <div class="qtvBg">
                    <img class="" src="img/login/admin.png" alt="">
                </div>
                <div class="flex flex-col gap-7 w-full text-white z-[1]">
                    <div class="text-[1.5rem] font-bold m-auto">Chào mừng quản trị...</div>
                    <!-- form  -->
                    <form action="">
                        <div class="w-[70%] m-auto">
                            <div class="">Username:</div>
                            <input type="text" class="text-black w-full m-auto rounded-xl">
                        </div>
                        <div class="w-[70%] m-auto">
                            <div class="">Password:</div>
                            <input type="password" class="text-black w-full m-auto rounded-xl">
                            <div class="w-full flex justify-end"> <button
                                    class="px-4 py-2 rounded bg-yellow-500 blink">Login</button></div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Client  -->
            <div
                class="relative w-[100%] h-[50vh] text-[#ffffffe2] flex items-center brBot mainBgRight overflow-hidden">

                <!-- RegisterPage -->
                <div id="regPage" class="regPage brBot swapPage">
                    <div class="cusbg">
                        <img src="img/login/customer.png" alt="">
                    </div>
                    <div class="absolute top-3 right-5 z-[1]">
                        <button class="underline italic z-[2]" id="swapLoginBtn">Quay về đăng nhập?</button>
                    </div>
                    <div class="flex flex-col gap-7 my-2 w-[90%] m-auto z-[1]">
                        <!-- form  -->
                        <form action="">
                            <div class="text-[1.25rem] font-bold m-auto">Đăng ký</div>

                            <div class="lg:w-[70%] m-auto">
                                <div class="">Phone number (Username):</div>
                                <input type="text" class="text-black w-full m-auto rounded-xl">
                            </div>
                            <div class="lg:w-[70%] m-auto">
                                <div class="">Email:</div>
                                <input type="email" class="text-black w-full m-auto rounded-xl">
                            </div>
                            <div class="lg:w-[70%] m-auto">
                                <div class="">Password:</div>
                                <input type="password" class="text-black w-full m-auto rounded-xl">
                            </div>
                            <div class="lg:w-[70%] m-auto">
                                <div class="">Confirm Password:</div>
                                <input type="password" class="text-black w-full m-auto rounded-xl">
                                <div class="w-full flex justify-end"> <button
                                        class="px-4 py-2 rounded bg-yellow-500 blink">Sign up</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>


                <!-- login Page  -->
                <div class="w-full m-auto flex justify-center">
                    <div class="cusbg">
                        <img src="img/login/customer.png" alt="">
                    </div>
                    <div class="absolute top-3 right-5 ">
                        <button class="underline italic" id="swapRegBtn">Chưa có tài khoản?</button>
                    </div>
                    <div class="flex flex-col gap-7 w-[90%]">
                        <div class="text-[1.25rem] font-bold m-auto">Đăng nhập</div>
                        <!-- form  -->
                        <form action="">
                            <div class="lg:w-[70%] m-auto">
                                <div class="">Username:</div>
                                <input type="text" class="text-black w-full m-auto rounded-xl">
                            </div>
                            <div class="lg:w-[70%] m-auto">
                                <div class="">Password:</div>
                                <input type="password" class="text-black w-full m-auto rounded-xl">
                                <div class="flex justify-end text-xs mt-1 italic underline">Quên mật khẩu</div>
                                <div class="w-full flex justify-end"> <button
                                        class="px-4 py-2 rounded bg-yellow-500 blink">Login</button></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>


        </div>
    </div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
    <script src="Javascript/Login/index.js"></script>
</body>

</html>
