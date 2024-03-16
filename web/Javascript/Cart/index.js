console.log("Hello Cart JS");


let viewCartBtn = document.querySelector("#viewCartListBtn");
let tableCartLayout = document.querySelector("#tableCart");
viewCartBtn.addEventListener("click", () => {
    tableCartLayout.classList.toggle("!left-[-65vw]");
})