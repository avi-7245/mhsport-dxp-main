<%@page import="com.liferay.portal.kernel.util.Validator"%>
<%@ include file="/init.jsp" %>

<%
long todaysCount = Validator.isNotNull(request.getAttribute("todaysCount")) ? (long) request.getAttribute("todaysCount") : 0;
long totalCount = Validator.isNotNull(request.getAttribute("totalCount")) ? (long) request.getAttribute("totalCount") : 0;
%>

<p class="counter-label vc">
<i class="bi bi-eye"></i>
 <span class="count-values"><%=totalCount%></span>
 <span class="visit"><liferay-ui:message key="Visitors"/></span>
 </p>
 
