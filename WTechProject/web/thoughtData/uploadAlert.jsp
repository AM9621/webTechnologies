<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<c:if test="${not empty param.Exists}">
    <c:import url="${param.Redirect}"></c:import>
    <c:import url="uploadExistsMess.html"></c:import>
    
    
</c:if>
