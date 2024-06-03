<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="day0531.ExamMapper7DAO"%>
<%@page import="kr.co.sist.domain.CarDomain"%>
<%@page import="kr.co.sist.domain.JoinDomain"%>
<%@page import="kr.co.sist.domain.EmpDomain"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="choose 조회"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<form name="frm" action="index.jsp">
<input type="hidden" name="link" value="day0531/set"/><!-- include할 파라메터 설정 -->
<h2>사원정보 변경 </h2>
<label>사원번호</label>
<input type="text" name="empno" value="7654"><br>
<label>사원명</label>
<input type="text" name="ename" value="MARTIN"><br>
<label>연봉</label>
<input type="text" name="sal"><br>
<label>직무</label>
<% String empno = request.getParameter("empno"); 
	String[] jobs="SALESMAN,MANAGER,ANALYST,PRESIDENT,CLERK".split(",");
	pageContext.setAttribute("jobs", jobs);
%>
<label>직무</label>
<select name="job">
<c:forEach var="job" items="${jobs}">
<option value="${job}"/><c:out value="${ job }"/></option>
</c:forEach>
</select>
<br>
<input type="submit" value="변경" class="btn btn-success btn-sm"/>
</form>
<div>
	<c:if test="${ not empty param.empno }">
			<strong><c:out value="${ param.empno }" /></strong>사원 정보가<br> 
		<c:catch var="errmsg"><!-- java의 try/catch 비슷한 거. 에러가 발생할 수 있는 부분 -->
		<jsp:useBean id="ceVO" class="kr.co.sist.vo.CpEmpVO" scope="page"/>
		<jsp:setProperty property="*" name="ceVO"/>
			<%
			ExamMapper7DAO emp7DAO = ExamMapper7DAO.getInstance();
			int cnt = emp7DAO.dynamicSet(ceVO);
			pageContext.setAttribute("cnt", cnt);
			%>
			<c:choose>
			<c:when test="${ cnt eq 0 }">
			변경되지 않았습니다.<br>사원번호를 확인해주세요
			</c:when>
			<c:otherwise>
			변경되었습니다.
			</c:otherwise>
			</c:choose>
		</c:catch>
		<c:if test="${ not empty errmsg }"><!-- 에러가 발생헸을 때 출력할 내용 작성 -->
			사원번호는 숫자로만 구성됩니다.
		</c:if>
	</c:if>
</div>
