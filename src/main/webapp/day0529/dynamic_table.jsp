<%@page import="kr.co.sist.domain.CarDomain"%>
<%@page import="day0529.ExamMapper5Service"%>
<%@page import="kr.co.sist.domain.JoinDomain"%>
<%@page import="day0529.ExamMapper5DAO"%>
<%@page import="kr.co.sist.domain.EmpDomain"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="$사용 조회"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<form name="frm" action="index.jsp">
<input type="hidden" name="link" value="day0529/dynamic_table"/><!-- include할 파라메터 설정 -->
<h2>회사 사원정보 조회 </h2>
<label>선택</label>
<% String type = request.getParameter("type"); %>
<input type="radio" name="type" value="0"/>본사
<input type="radio" name="type" value="1"/>지사
<input type="submit" value="검색" class="btn btn-success btn-sm"/>
</form>
<div>
	<c:if test="${ not empty param.type }">
			입력하신 회사 [<strong><c:out value="${ param.type eq '0'?'본사':'지사' }" /></strong>]의 사원정보 검색 결과<br>
		<c:catch var="e">
			<%
			String tableName="emp";
			if(!"0".equals(type)){
				type="지사";
				tableName="cp_emp4";
			}
			
			ExamMapper5DAO emp5DAO = ExamMapper5DAO.getInstance();
			List<EmpDomain> list = emp5DAO.dynamicTable(tableName);
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
		<c:if test="${ not empty e }">
			사원번호는 숫자로만 구성됩니다.
		</c:if>
	</c:if>
</div>
