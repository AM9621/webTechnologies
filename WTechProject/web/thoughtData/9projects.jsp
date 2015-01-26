<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Linear Algebra Projects</title>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <meta name="description" content="Circular Content Carousel with jQuery" />
        <meta name="keywords" content="jquery, conent slider, content carousel, circular, expanding, sliding, css3" />
        <meta name="author" content="Codrops" />
        <link rel="shortcut icon" href="../favicon.ico"> 
        <link rel="stylesheet" type="text/css" href="carousel/css/demo.css" />
        <link rel="stylesheet" type="text/css" href="carousel/css/style.css" />
        <link rel="stylesheet" type="text/css" href="carousel/css/jquery.jscrollpane.css" media="all" />
        <link href='http://fonts.googleapis.com/css?family=PT+Sans+Narrow&v1' rel='stylesheet' type='text/css' />
        <link href='http://fonts.googleapis.com/css?family=Coustard:900' rel='stylesheet' type='text/css' />
        <link href='http://fonts.googleapis.com/css?family=Rochester' rel='stylesheet' type='text/css' />
        <link rel="stylesheet" type="text/css" href="Upload/css/popupForm.css"/>
        <link rel="stylesheet" href="starRating/css/style.css" media="screen" type="text/css" />
        <script type="text/javascript">
                
                function submitrate()
                {
                    document.forms["starRate"].submit();
                }
            </script>
    </head>
    <body>
    <c:choose>
        <c:when test="${empty sessionScope.email}">
            <c:import url="9notification.jsp"></c:import>
        </c:when>
        <c:otherwise>
            <sql:setDataSource var="ds" dataSource="jdbc/fist" />
            <form action="../UploadDownloadFileServlet" id="popupform1" class="popup-form" method="post" enctype="multipart/form-data">
                <div class="steps-popup">
                    <div class="step-one-popup active-step-popup">1</div>
                    <div class="step-two-popup">2</div>
                </div>
                
                <div class="steps-container-popup">
                    <div class="step-one-container-popup">
                        <label for="project-title">Project Title</label>
                        <input id="project-title" type="text" name="projecttitle" autocomplete="off" maxlength="20" tabindex="1" placeholder="Max length 20"> </textarea>
                        
                        <label for="project-description">Project Description </label>
                        <input id="project-description" type="text" name="projectdiscription" autocomplete="off" maxlength="150" tabindex="2" placeholder="Max length 150"> </textarea>
                        
                        <label for="project-overview">Project Overview </label>
                        <input id="project-overview" type="text" name="projectoverview" autocomplete="off" maxlength="420" tabindex="3" placeholder="Max length 420"> </textarea>
                        
                        <button class="button-popup-form normal-button-popup-form next-button-popup" type="button" tabindex="4">Next</button>
                    </div>
                
                    <div class="step-two-container-popup">
                        <label for="upload">Upload</label>
                        <input id="upload" type="file" name="fileName" >
              
                        <!-- query for dublicate files -->
                        
                        
                        <button id="comple" onClick="testResults(this.form)" class="button-popup-form highlight-button-popup-form" >Upload File</button>
                    </div>
                </div>
                <input type="hidden" name="url" value="9notification.jsp"/>
                <input type="hidden" name="course" value="WebTechnologies"/>
            </form>
            
            
            <div class="container">
                <div class="header">
                   <span class="left_ab">
                       <a> Logged in as ${sessionScope.email}</a>
                    </span>
                    <span class="right_ab">
                        <a href="javascript:" id="uploadstart"><strong>Upload</strong></a>
                        <a href="javascript: submitform()"><strong>Logout</strong></a>
                    </span>
                </div>
                
                <sql:query dataSource="${ds}" sql="select * from courseMaterials where course='WebTechnologies' order by rank desc" var="results" />
                <!-- ${ds} is from var="ds" from sql:setDataSource -->
                <div id="ca-container" class="ca-container">
                    <div class="ca-wrapper">
                        
                        <c:if test="${empty results.rows}">
                            <div align="center">
                                <div id="ca-container11" class="ca-container11">
                                    <div class="ca-content">
                                        <h6 align="center">RepoCourse</h6>
                                        <div class="ca-content-text">
                                            <p>Projects not yet uploaded in this section.</p>
                                           
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        
                        <c:forEach var="project" items="${results.rows}" varStatus="row">
                        <!-- ITEM START -->
                        <div class="ca-item ca-item-1">
                            <div class="ca-item-main">

                                <h3>${project.title}</h3>
                                <h4>
                                    <span class="ca-quote">&ldquo;</span>
                                    <span>${project.description}</span>
                                </h4>
                                    <a href="#" class="ca-more">more...</a>
                            </div>

                            <div class="ca-content-wrapper">
                                <div class="ca-content">
                                    <div align="center">
                                        <form action="../Rate" method="post" id="starRate" >  
                                            
                                            <input type="hidden" name="votes" value=${project.votes} />
                                            <input type="hidden" name="averageRate" value=${project.averageRate} />
                                            <input type="hidden" name="fname" value="${project.filename}" />
                                            <input type="hidden" name="url" value="9notification.jsp"/>
                                            
                            
                                                <c:if test="${project.rank le 20.0}">
                                                    <span class="star-rating" >
                                                        <input type="radio" name="rating" value="1" checked /><i></i>
                                                        <input type="radio" name="rating" value="2"/><i></i>
                                                        <input type="radio" name="rating" value="3"/><i></i>
                                                        <input type="radio" name="rating" value="4"/><i></i>
                                                        <input type="radio" name="rating" value="5"/><i></i>
                                                    </span>
                                                </c:if>
                                                <c:if test="${(project.rank gt 20.0) and (project.rank le 40.0)}">
                                                    <span class="star-rating" >
                                                        <input type="radio" name="rating" value="1" /><i></i>
                                                        <input type="radio" name="rating" value="2" checked /><i></i>
                                                        <input type="radio" name="rating" value="3"/><i></i>
                                                        <input type="radio" name="rating" value="4"/><i></i>
                                                        <input type="radio" name="rating" value="5"/><i></i>
                                                    </span>
                                                </c:if>
                                                <c:if test="${(project.rank gt 40.0) and (project.rank le 60.0)}">
                                                    <span class="star-rating" >
                                                        <input type="radio" name="rating" value="1" /><i></i>
                                                        <input type="radio" name="rating" value="2" /><i></i>
                                                        <input type="radio" name="rating" value="3" checked /><i></i>
                                                        <input type="radio" name="rating" value="4"/><i></i>
                                                        <input type="radio" name="rating" value="5"/><i></i>
                                                    </span>
                                                </c:if>
                                              
                                                <c:if test="${(project.rank gt 60.0) and (project.rank le 90.0)}">
                                                    
                                                    <span class="star-rating" >
                                                        <input type="radio" name="rating" value="1" /><i></i>
                                                        <input type="radio" name="rating" value="2"/><i></i>
                                                        <input type="radio" name="rating" value="3" /><i></i>
                                                        <input type="radio" name="rating" value="4" checked /><i></i>
                                                        <input type="radio" name="rating" value="5"/><i></i>
                                                    </span>
                                                </c:if>
                                                <c:if test="${project.rank gt 90.0}">
                                                    <span class="star-rating" >
                                                        <input type="radio" name="rating" value="1"/><i></i>
                                                        <input type="radio" name="rating" value="2"/><i></i>
                                                        <input type="radio" name="rating" value="3"/><i></i>
                                                        <input type="radio" name="rating" value="4"/><i></i>
                                                        <input type="radio" name="rating" value="5" checked /><i></i>
                                                    </span>
                                                </c:if>
                                              <c:out value="(votes: ${project.votes})"></c:out>
                                            
                                            <sql:query dataSource="${ds}" sql="select * from voteStat where user='${sessionScope.email}' and file='${project.filename}'" var="voteResult" />  
                                            <c:if test="${empty voteResult.rows}">
                                                <input type="submit" name="submit" value="Submit Rate" class="button-popup-form">
                                            </c:if>
                                                
                                            </form>  
                                        </div>
                                        <h6></h6>
                                    <a href="#" class="ca-close">close</a>

                                    <div class="ca-content-text">
                                        <p>${project.overview}</p>
                                        
                                    </div>
                                    
                                    <ul>
                                        <li><a href="../UploadDownloadFileServlet?fileName=${project.filename}">Download</a></li>
                             
                                    </ul>
                                        <div align="center"><h5>Uploaded by <strong>${project.user}</strong></h5></div>    
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                        <!-- ITEM END -->
                
                        
                    </div>
                </div>
		
                    <h5><strong>RepoCourse</strong> created by omlout</h5>
            </div>
            
            <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
            <script type="text/javascript" src="carousel/js/jquery.easing.1.3.js"></script>
            <!-- the jScrollPane script -->
            <script type="text/javascript" src="carousel/js/jquery.mousewheel.js"></script>
            <script type="text/javascript" src="carousel/js/jquery.contentcarousel.js"></script>
     
            

            <script type="text/javascript">
                    $('#ca-container').contentcarousel();
            </script>
            <script type="text/javascript">
                function submitform()
                {
                    document.forms["mylogout"].submit();
                }
                
            </script>
            <form action="../Logout" method="get" id="mylogout">
                <input type="hidden" name="url" value="9notification.jsp"/>
            </form>
            <form action="../UploadAlert" method="get" id="exists">
                <input type="hidden" name="url" value="9notification.jsp"/>
            </form>
            
            <script type="text/javascript" src="loginstuff/js/jquery-1.9.1.min.js"></script>
            <script type="text/javascript" src="Upload/js/jquery.popupForm.min.js"></script>
            
            <script type="text/javascript">
                $('#popupform1').PopupForm({
                    openPopupButton: $('#uploadstart')[0],
                    formTitle: 'Upload File',

                    validateStepOne: function (container) {
                        // Or used validation plugin, we recommend: http://jqueryvalidation.org/
                        if($('#project-title').val().length > 0 && $('#project-description').val().length > 0 && $('#project-overview').val().length > 0) {
                            return true;
                        } else {
                            alert('Fields is a required');
                            return false;
                        }
                    },
                    submitted: function() {
                        console.log('Form just submitted.');
                    },
                    submitSuccess: function(data) {
                        alert('Form submitted successfully.');
                    },
                    submitFailed: function(xhr) {
                        console.log('Form submit failed.');
                    },
                    closed: function() {
                        console.log('Form closed.');
                    }
                });
            </script>
            <script type="text/javascript">
                function testResults(form){
                    
                    //alert ("Choice upload file" + TestVar);
                    //alert ("ttt");
                    if(form.fileName.value)
                    {
                        
                        document.forms["popupform1"].submit();
                        
                        
                    }
                    else
                    {
                        alert ("Choose file to start Upload.");
                       
                           //
                    }
                }
            </script>
            
            
        </c:otherwise>
    </c:choose>
    </body>
</html>
