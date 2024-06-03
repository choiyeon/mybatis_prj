<%@page import="kr.co.sist.domain.EmpDomain"%>
<%@page import="java.util.List"%>
<%@page import="day0527.ExamMapper4DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="like 조회"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form name="frm" action="index.jsp">
<input type="hidden" name="link" value="day0528/like"/><!-- include할 파라메터 설정 -->
<h2>입력되는 문자가 들어있는 사원명 조회 </h2>
<label>키워드</label>
<input type="text" name="ename"/>
<input type="text" style="display:none"/><!-- input type="button"일때 엔터쳐도 안 넘어가게 방지 지금은 submit이라 있든없든 상관없음-->
<input type="submit" value="검색" class="btn btn-success btn-sm"/>
</form>
<div>
	<c:if test="${ not empty param.ename }">
			입력하신 문자 [<strong><c:out value="${ param.ename }" /></strong>가 포함된 사원명 검색결과<br>
		<c:catch var="e">
			<%
			String ename = request.getParameter("ename");
			ExamMapper4DAO emp4DAO = ExamMapper4DAO.getInstance();
			List<EmpDomain> list = emp4DAO.like(ename);
			pageContext.setAttribute("list", list);
			%>
				<table class="table table-hover">
					<tr>
						<th style="width: 80px">사원번호</th>
						<th style="width: 200px">사원명</th>
						<th style="width: 120px">사원직무</th>
						<th style="width: 120px">연봉</th>
						<th style="width: 200px">입사일</th>
					</tr>
				<c:if test="${ empty list }">
					<tr><td colspan="5" style="text-align: center">
					문자를 포함하는 사원명 없음
					</td>
					</tr>
				</c:if>
				<c:forEach var="ed" items="${list}" varStatus="i">
				<tr>
				<td><c:out value="${ ed.empno }"/></td>
				<td><c:out value="${ ed.ename }"/></td>
				<td><c:out value="${ ed.job }"/></td>
				<td><c:out value="${ ed.sal }"/></td>
				<td><c:out value="${ ed.hiredateStr }"/></td>
				</tr>
				</c:forEach>
				</table>
		</c:catch>
		<c:if test="${ not empty e }">
			사원번호는 숫자로만 구성됩니다.
		</c:if>
	</c:if>
</div>
