<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'takePhoto.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<script>     
  //判断浏览器是否支持HTML5 Canvas     
  console.log("hahah");      
window.onload = function () {          
     try {                   
//动态创建一个canvas元 ，并获取他2Dcontext。如果出现异常则表示不支持                   document.createElement("canvas").getContext("2d");        
           document.getElementById("support").innerHTML = "浏览器支持HTML5 CANVAS";    
           console.log("浏览器支持HTML5");     
      }          
     catch (e) {           
        document.getElementById("support").innerHTML = "浏览器不支持HTML5 CANVAS";  
         console.log("浏览器不支持HTML5");      
        }                
     };                
     //这段代 主要是获取摄像头的视频流并显示在Video 签中           
window.addEventListener("DOMContentLoaded", function () {            
   var canvas = document.getElementById("canvas"),              
     context = canvas.getContext("2d"),                
   video = document.getElementById("video"),          
         videoObj = { "video": true },             
      errBack = function (error) {           
            console.log("Video capture error: ", error);    
               };               
    //navigator.getUserMedia这个写法在Opera中好像是navigator.getUserMedianow       
        if (navigator.getUserMedia) {     
              navigator.getUserMedia(videoObj, function (stream) {
                       video.src = stream;                
       video.play();      
             }, errBack);           
    } else if (navigator.webkitGetUserMedia) {        
           navigator.webkitGetUserMedia(videoObj, function (stream) {          
             video.src = window.URL.createObjectURL(stream);           
            video.play();           
        }, errBack);           
    }         
      //这个是拍照按钮的事件，          
     document.getElementById("snap").onclick=function () {          
         var snagshot=context.drawImage(video, 0, 0, 320, 320);     
               document.getElementById("canvas").innerHTML=snagshot;     
    };           
          }, false);           
          //定时器         
 // var interval = setInterval(CatchCode, "300");      
                         //这个是 刷新上 图像的        
   function CatchCode() {        
       $("#snap").click();
//实际运用可不写，测试代 ， 为单击拍照按钮就获取了当前图像，有其他用途    
           var canvans = document.getElementById("canvas"); 
//获取浏览器页面的画布对象                       
   //以下开始编 数据   
                                  var imgData = canvans.toDataURL(); 
//将图像转换为base64数据
               var base64Data = imgData.substr(22); 
//在前端截取22位之后的字符串作为图像数据       
                            //开始异步上             
   $.post("uploadImgCode.html", { "img": base64Data }, function (data, status) {      
             if (status == "success") {                 
      if (data == "OK") {                
           alert("二维 已经解析");                   
    }                    
   else {              
             // alert(data);          
             }          
         }     
              else {   
                    alert("数据上 失败");                 
  }               }, "text");           
          }      
 </script> 

  </head>
  
  <body>
    <div id="contentHolder">       
    <a id="support"></a>
 <video id="video" width="320" height="320" autoplay>
</video>       
 <button id="snap"> 拍照</button>        
<canvas style="border:1px solid #ccc;" id="canvas" width="320" height="320">
</canvas> 
   </div>
  </body>
</html>
