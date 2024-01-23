const guestBtn = document.querySelectorAll("#guestBtn");
const qtvBtn = document.querySelectorAll("#qtvBtn");
const coverLayer = document.querySelectorAll("#coverLayer");

//flag
let isGuest = true;
let isQtv = false;
qtvBtn.forEach((btn) => {
  btn.addEventListener("click", () => {
    isQtv = true;
    isGuest = !isQtv;
  });
});

// qtvBtn.addEventListener("click", () => {
//   console.log("lo");
//   isQtv = true;
//   isGuest = !isQtv;
// });

// guestBtn.addEventListener("click", () => {
//   isGuest = true;
//   isQtv = !isGuest;
// });

guestBtn.forEach((btn) => {
  btn.addEventListener("click", () => {
    isGuest = true;
    isQtv = !isGuest;
  });
});

document.addEventListener("click", (e) => {
  coverLayer[0].classList.toggle("toTheRight", isQtv);
  coverLayer[1].classList.toggle("toTheBot", isQtv);
  //   coverLayer.classList.toggle("toTheRight", isQtv);
  regPage.forEach(btn=>{
    btn.classList.toggle("swapPage", isReg);
  })
  // regPage.classList.toggle("swapPage", isLogin);
});

//Login-Signup
// const goToLog = document.getElementById("goToLog")
const goToRegBtn = document.querySelectorAll("#swapRegBtn");
const goToLoginBtn = document.querySelectorAll("#swapLoginBtn");
var isLogin = true;
var isReg = false;
var regPage = document.querySelectorAll("#regPage");

// goToRegBtn.addEventListener("click", (e) => {
//   isReg = true;
//   isLogin = !isReg;
// });
goToRegBtn.forEach((btn) => {
  btn.addEventListener("click", () => {
    isReg = true;
    isLogin = !isReg;
  });
});

// goToLoginBtn.addEventListener("click", (e) => {
//   isLogin = true;
//   isReg = !isLogin;
// });

goToLoginBtn.forEach((btn) => {
  btn.addEventListener("click", () => {
    isLogin = true;
    isReg = !isLogin;
  });
});
