<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>UTH</title>
        <meta charset="UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <meta name="description" content="RepoCourse" />
        <meta name="keywords" content="jquery, Repository, Course" />
	<meta name="author" content="Codrops" />
	<link rel="shortcut icon" href="../favicon.ico"> 
        <link rel="stylesheet" type="text/css" href="carousel/css/demo.css" />
	<link rel="stylesheet" type="text/css" href="carousel/css/style.css" />
	<link rel="stylesheet" type="text/css" href="carousel/css/jquery.jscrollpane.css" media="all" />
	<link href='http://fonts.googleapis.com/css?family=PT+Sans+Narrow&v1' rel='stylesheet' type='text/css' />
	<link href='http://fonts.googleapis.com/css?family=Coustard:900' rel='stylesheet' type='text/css' />
	<link href='http://fonts.googleapis.com/css?family=Rochester' rel='stylesheet' type='text/css' />
        <link rel="shortcut icon" href="http://designshack.net/favicon.ico">
        <link rel="icon" href="http://designshack.net/favicon.ico">
        <link rel="stylesheet" type="text/css" media="all" href="loginstuff/stylelogin.css">
        <script type="text/javascript" src="charts/canvasjs.min.js"></script>
    </head>
    <body>
        <div class="container11">
           <div class="header">
		<c:choose>
                    <c:when test="${not empty sessionScope.email}">
                        <span class="left_ab">
                            <a> Logged in as ${sessionScope.email}</a>
                        </span>
                        <span class="right_ab">
                            <a href="javascript: submitform()"><strong>Logout</strong></a>
                        </span>
                    </c:when>
                    <c:otherwise>
                    <span class="right_ab">
                        <a href="#loginmodal" id="modaltrigger"><strong>Login</strong></a>
                            <a href="#registermodal" id="regmodaltrigger"><strong>Register</strong></a>
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>
            <div align="center">
                <div id="ca-container11" class="ca-container11">
                    <div class="ca-content">
                        <h6 align="center">Fall Semester</h6>
                        <div class="ca-content-text">
                            <p>In this section you can find projects for the Fall Semester courses of First Year. You can see some statistics below.</p>
			</div>
                        <div id="chartContainer" style="height: 300px; width: 70%;"></div>
                    </div>
                    <h5><strong>RepoCourse</strong> created by omlout</h5>
                </div>
            </div>
       
              
            <div id="loginmodal" style="display:none;">
                <h7>User Login</h7>
                <form id="loginform" action="../Login" method="post">
                    <label for="email">Username:</label>
                    <input type="email" name="email" required autocomplete="off" class="txtfield" placeholder="me@mail.com" tabindex="1"/>
                 
                    <label for="password">Password:</label>
                    <input type="password" name="pass" required autocomplete="off" class="txtfield" placeholder="Password" tabindex="2"/>
                    <input type="hidden" name="url" value="4notification.jsp"/>
                    <div class="center"><input type="submit" name="loginbtn" id="loginbtn" class="flatbtn-blu hidemodal" value="Login" tabindex="3"></div>
                </form>
            </div>
            
            <div id="registermodal" style="display:none;">
                <h7>User Register</h7>
                <form id="registerform" action="../Register" method="post">
                    <label for="email">Username:</label>
                    <input type="email" name="email" required autocomplete="off" class="txtfield" placeholder="me@mail.com" />
                 
                    <label for="password">Password:</label>
                    <input type="password" name="pass" required autocomplete="off" class="txtfield" placeholder="Password" />
                    <input type="hidden" name="url" value="4notification.jsp"/>
                    <div class="center"><input type="submit" name="registerbtn" id="regbutton" class="flatbtn-blu hidemodal" value="register" tabindex="3"></div>
                </form>
            </div>
            
        </div>
        
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
        <script type="text/javascript" src="carousel/js/jquery.easing.1.3.js"></script>
        <!-- the jScrollPane script -->
        <script type="text/javascript" src="carousel/js/jquery.mousewheel.js"></script>
        <script type="text/javascript" src="carousel/js/jquery.contentcarousel.js"></script>
        <script type="text/javascript" src="loginstuff/js/jquery-1.9.1.min.js"></script>
        <script type="text/javascript" charset="utf-8" src="loginstuff/js/jquery.leanModal.min.js"></script>

        <script type="text/javascript">
                $('#ca-container').contentcarousel();
        </script>

        <script type="text/javascript">
            function submitform()
            {
                document.forms["mylogout"].submit();
            }
        </script>

        <script type="text/javascript">
            $(function(){
                $('#regmodaltrigger').leanModal({ top: 10, overlay: 0.45, closeButton: ".hidemodal" });
                $('#modaltrigger').leanModal({ top: 10, overlay: 0.45, closeButton: ".hidemodal" });

            });


        </script>
        
        <form action="../Logout" method="get" id="mylogout">
            <input type="hidden" name="url" value="4notification.jsp"/>
        </form>
        
        <sql:setDataSource var="ds" dataSource="jdbc/fist" />
        <sql:query dataSource="${ds}" sql="select * from courseMaterials where course='LinearAlgebra'" var="algebra" />
        
        <script type="text/javascript">
            window.onload = function () {
            var chart = new CanvasJS.Chart("chartContainer", {
		theme: "theme2",//theme1
		title:{
			text: "Projects"              
		},
		animationEnabled: true,   // change to true
		data: [              
		{
			// Change type to "bar", "splineArea", "area", "spline", "pie",etc.
			type: "column",
			dataPoints: [
				{ label: "Linear Algebra",  y: ${algebra.getRowCount()}  }
				
			]
		}
		]
            });
            chart.render();
        };
        </script>              
    </body>
</html>
