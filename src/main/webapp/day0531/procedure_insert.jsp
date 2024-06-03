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
<input type="hidden" name="link" value="day0531/procedure_insert"/><!-- include할 파라메터 설정 -->
<h2>Procedure 사원정보 추가 </h2>
<label>사원번호</label>
<input type="text" name="empno"><br>
<label>사원명</label>
<input type="text" name="ename"><br>
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
<input type="submit" value="프로시저를 사용한 추가" class="btn btn-success btn-sm"/>
</form>
<div>
	<c:if test="${ not empty param.empno }">
			<strong><c:out value="${ param.empno }" /></strong>사원 정보가<br> 
		<c:catch var="errmsg"><!-- java의 try/catch 비슷한 거. 에러가 발생할 수 있는 부분 -->
		<jsp:useBean id="empVO" class="kr.co.sist.vo.EmployeeVO" scope="page"/>
		<jsp:setProperty property="*" name="empVO"/>
			<%
			ExamMapper7DAO emp7DAO = ExamMapper7DAO.getInstance();
			emp7DAO.procedureInsert(empVO);//추가될 값을 getter가 호출, 반환값은 setter가 호출된다.
			pageContext.setAttribute("cnt", empVO.getCnt());
			pageContext.setAttribute("errMsg", empVO.getErrMsg());
			%>
			<c:choose>
			<c:when test="${ cnt eq 0 }">
			사원정보가 추가되지 않았습니다.<br><c:out value="${ errMsg }"/>
			</c:when>
			<c:otherwise>
			<c:out value="${ param.empno }"/> 사원 정보가 추가되었습니다.<br>
			<ul>
			<li>사원명 : <strong><c:out value="${ param.ename }"/></strong></li>
			<li>연봉 : <strong><c:out value="${ param.sal }"/></strong></li>
			<li>직무 : <strong><c:out value="${ param.job }"/></strong></li>
			</ul>
			</c:otherwise>
			</c:choose>
		</c:catch>
		<c:if test="${ not empty errmsg }"><!-- 에러가 발생헸을 때 출력할 내용 작성 -->
			사원번호는 숫자로만 구성됩니다.
		</c:if>
	</c:if>
</div>
