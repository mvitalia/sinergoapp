function bodyload() {
   alert("body loaded");

   document.addEventListener("deviceready", dReady, false);
}



function dReady() {

   alert("Device is ready");

}
