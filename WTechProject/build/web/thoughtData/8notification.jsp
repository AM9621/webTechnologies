<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<!DOCTYPE html>
  
<c:choose>
    <c:when test="${not empty sessionScope.email}">
        <c:import url="8projects.jsp"></c:import>
        <c:if test="${not empty sessionScope.Login}">
            <c:import url="loginMess.html"></c:import>
            <c:remove var="Login" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.Upload}">
            <c:import url="uploadMess.html"></c:import>
            <c:remove var="Upload" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.Rate}">
            <c:import url="rateMess.html"></c:import>
            <c:remove var="Rate" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.Alert}">
            <c:import url="uploadExistsMess.html"></c:import>
            <c:remove var="Alert" scope="session" />
        </c:if>
        
    </c:when>
    <c:otherwise>
        <c:if test="${not empty sessionScope.regSuccess}">
            <c:import url="registersuccess.html"></c:import>
            <c:remove var="regSuccess" scope="session" />
        </c:if>
        
        <c:import url="8.jsp"></c:import>
        
        <c:if test="${not empty sessionScope.Loginfail}">
            <c:import url="Loginfail.html"></c:import>
            <c:remove var="Loginfail" scope="session" />
        </c:if>
         
        <c:if test="${not empty sessionScope.alreadyReg}">
            <c:import url="allreadyRegister.html"></c:import>
            <c:remove var="alreadyReg" scope="session" />
        </c:if>
        
        
    </c:otherwise>
</c:choose>
