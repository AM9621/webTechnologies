<%-- 
    Document   : index
    Created on : Dec 27, 2014, 9:43:16 PM
    Author     : root_
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>RepoCourse</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <script type="text/javascript" language="javascript" src="theBrain/BrainPlexApp.nocache.js"></script>
    <script>
      var plexSettings = {
        "plexFontSize": 12,
        "maxChildColumns": 4,
        "animationType": "auto", // [auto | frames | none | webkit]
        "contentType": "frame", // [frame | div | none] (if frame or div you can specify a custom id -- default id is "plexContent")
        "contentId": "plexContent",
        "animateAppearingResize": false,
        "animateDisappearingResize": false,
        "highlightThoughtLines": false,
        "dynamicInstantSearch": false,
        "enableFullSearch": false,
        "pageTitle": "UTH",
        "thoughtPrefix": "thoughtData/",
        "thoughtSuffix": ".xml",
        "pinPrefix": "pins.xml",
        "instantSearchPrefix": "instantSearch/",
        "instantSearchSuffix": ".xml",
        "startThought": 1,
        "wallpaper": "",
        "licenseKey": "personalbrain",
        "showSearchButton": false,  // full searching not implemented yet
        "showGates": false 
      };
      
      onAjaxPlexLoaded = function(){ showAjaxPlex(plexSettings); };
    </script>
  </head>
  
  <body style="border: 0px; padding: 0px; margin: 0px; text-align: center; font-family: Arial; cursor: default;">
    <div id="plex" style="width: 100%; height: 50%; position: relative; overflow: hidden;"></div>
    <iframe id="plexContent" width="100%" height="50%" frameborder="0"></iframe>
    
    <!-- do not remove -->
    <iframe src="javascript:''" id="__gwt_historyFrame" style="width:0;height:0;border:0"></iframe>
    <!-- do not remove -->
  </body>
</html>
