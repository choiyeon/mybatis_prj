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
<input type="hidden" name="link" value="day0531/foreach"/><!-- include할 파라메터 설정 -->
<h2>사원정보 조회 </h2>
<label>부서번호</label>
<input type="text"  name="deptno"><br>
<% String deptno = request.getParameter("deptno"); 
	String[] jobs="SALESMAN,MANAGER,ANALYST,PRESIDENT,CLERK".split(",");
	pageContext.setAttribute("jobs", jobs);
%>
<label>직무</label>
<c:forEach var="job" items="${jobs}">
<input type="checkbox" name="job" value="${job}"/><c:out value="${ job }"/>
</c:forEach>
<br>
<input type="submit" value="검색" class="btn btn-success btn-sm"/>
</form>
<div>
	<c:if test="${ not empty param.deptno }">
			<strong><c:out value="${ param.deptno }" /></strong>부서에[ 
			<c:if test="${ empty paramValues.job }"><span style="color:#FF0000; font-weight: bold"> 모든 직무 </span></c:if>
			<c:forEach var="job" items="${ paramValues.job }">
			<c:out value="${job}"/>
			</c:forEach>] 검색 결과<br>
		<c:catch var="errmsg"><!-- java의 try/catch 비슷한 거. 에러가 발생할 수 있는 부분 -->
			<%
			ExamMapper7DAO emp7DAO = ExamMapper7DAO.getInstance();
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("deptno", deptno);
			map.put("jobList",request.getParameterValues("job"));//getParameterValues
			List<EmpDomain> list = emp7DAO.dynamicForeach(map);
			pageContext.setAttribute("list", list);
			%>
				<table class="table table-hover">
					<tr>
						<th style="width: 200px">번호</th>
						<th style="width: 100px">사원번호</th>
						<th style="width: 200px">사원명</th>
						<th style="width: 150px">직무</th>
						<th style="width: 100px">연봉</th>
						<th style="width: 150px">입사일</th>
					</tr>
				<c:if test="${ empty list }">
					<tr><td colspan="6" style="text-align: center">
					사원이 존재하지 않습니다.
					</td>
					</tr>
				</c:if>
				<c:forEach var="ed" items="${list}" varStatus="i">
				<tr>
				<td><c:out value="${ i.count }"/></td>
				<td><c:out value="${ ed.empno }"/></td>
				<td><c:out value="${ ed.ename }"/></td>
				<td><c:out value="${ ed.job }"/></td>
				<td><fmt:formatNumber pattern="#,###,###" value="${ ed.sal }"/>만원</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${ ed.hiredate }"/></td>
				</tr>
				</c:forEach>
				</table>
		</c:catch>
		<c:if test="${ not empty errmsg }"><!-- 에러가 발생헸을 때 출력할 내용 작성 -->
			사원번호는 숫자로만 구성됩니다.
		</c:if>
	</c:if>
</div>
