<%@page import="kr.co.sist.domain.JoinDomain"%>
<%@page import="day0529.ExamMapper5DAO"%>
<%@page import="kr.co.sist.domain.EmpDomain"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="join 조회"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form name="frm" action="index.jsp">
<input type="hidden" name="link" value="day0529/join"/><!-- include할 파라메터 설정 -->
<h2>부서에 해당하는 사원과 부서정보 조회 </h2>
<label>부서번호</label>
<input type="text" name="deptno"/>
<input type="text" style="display:none"/><!-- input type="button"일때 엔터쳐도 안 넘어가게 방지 지금은 submit이라 있든없든 상관없음-->
<input type="submit" value="검색" class="btn btn-success btn-sm"/>
</form>
<div>
	<c:if test="${ not empty param.deptno }">
			입력하신 부서번호 [<strong><c:out value="${ param.deptno }" /></strong>]의 사원, 부서정보 결과<br>
		<c:catch var="e">
			<%
			int deptno = Integer.parseInt( request.getParameter("deptno"));
			ExamMapper5DAO emp5DAO = ExamMapper5DAO.getInstance();
			List<JoinDomain> list = emp5DAO.join(deptno);
			pageContext.setAttribute("list", list);
			%>
				<table class="table table-hover">
					<tr>
						<th style="width: 80px">사원번호</th>
						<th style="width: 200px">사원명</th>
						<th style="width: 120px">연봉</th>
						<th style="width: 80px">부서번호</th>
						<th style="width: 200px">부서명</th>
						<th style="width: 200px">위치</th>
					</tr>
				<c:if test="${ empty list }">
					<tr><td colspan="6" style="text-align: center">
					부서에 사원이 존재하지 않음
					</td>
					</tr>
				</c:if>
				<c:forEach var="jd" items="${list}" varStatus="i">
				<tr>
				<td><c:out value="${ jd.empno }"/></td>
				<td><c:out value="${ jd.ename }"/></td>
				<td><c:out value="${ jd.sal }"/></td>
				<td><c:out value="${ jd.deptno }"/></td>
				<td><c:out value="${ jd.dname }"/></td>
				<td><c:out value="${ jd.loc }"/></td>
				</tr>
				</c:forEach>
				</table>
		</c:catch>
		<c:if test="${ not empty e }">
			사원번호는 숫자로만 구성됩니다.
		</c:if>
	</c:if>
</div>
