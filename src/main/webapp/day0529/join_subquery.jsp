<%@page import="kr.co.sist.domain.CarDomain"%>
<%@page import="day0529.ExamMapper5Service"%>
<%@page import="kr.co.sist.domain.JoinDomain"%>
<%@page import="day0529.ExamMapper5DAO"%>
<%@page import="kr.co.sist.domain.EmpDomain"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="join subquery 조회"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<form name="frm" action="index.jsp">
<input type="hidden" name="link" value="day0529/join_subquery"/><!-- include할 파라메터 설정 -->
<h2>제조국에 대한 차량정보 조회 </h2>
<label>제조국</label>
<% String country = request.getParameter("country"); %>
<select name="country">
<option value="국산"<%= "국산".equals(country)?" selected='selected'":"" %>>국산</option>
<option value="수입"<%= "수입".equals(country)?" selected='selected'":"" %>>수입</option>
</select>
<input type="submit" value="검색" class="btn btn-success btn-sm"/>
</form>
<div>
	<c:if test="${ not empty param.country }">
			입력하신 제조국 [<strong><c:out value="${ param.country }" /></strong>]으로 검색 결과<br>
		<c:catch var="e">
			<%
			
			ExamMapper5Service emp5Service = ExamMapper5Service.getInstance();
			List<CarDomain> list = emp5Service.searchCar(country);
			pageContext.setAttribute("list", list);
			%>
				<table class="table table-hover">
					<tr>
						<th style="width: 120px">이미지</th>
						<th style="width: 100px">제조사</th>
						<th style="width: 100px">모델명</th>
						<th style="width: 80px">년식</th>
						<th style="width: 300px">옵션</th>
						<th style="width: 100px">가격</th>
						<th style="width: 150px">입력일</th>
					</tr>
				<c:if test="${ empty list }">
					<tr><td colspan="7" style="text-align: center">
					제조국에 차량이 존재하지 않습니다.
					</td>
					</tr>
				</c:if>
				<c:forEach var="cd" items="${list}" varStatus="i">
				<tr>
				<td><img src="http://192.168.10.218/mybatis_prj/day0529/car_img/${ cd.car_img }" style="width: 100px; height: 100px"></td>
				<c:set var="linkStart" value=""/>
				<c:set var="linkEnd" value=""/>
				<c:if test="${ cd.maker eq 'BMW' }">
					<c:set var="linkStart" value="<a href='https://www.bavarian.co.kr/'>"/><!-- 태그를 그대로 출력하지 말고 해석해서 출력하려면(a태그 활성화할려면) escapeXml="false" -->
					<c:set var="linkEnd" value="</a>"/>
				</c:if>
				<td><c:out value="${ linkStart }" escapeXml="false"/><c:out value="${ cd.maker }"/><c:out value="${ linkEnd }" escapeXml="false"/></td>
				<td><c:out value="${ cd.model }"/></td>
				<td><c:out value="${ cd.car_year }"/></td>
				<td><c:out value="${ cd.car_option }"/></td>
				<td><fmt:formatNumber pattern="#,###,###" value="${ cd.price }"/>만원</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${ cd.hiredate }"/></td>
				</tr>
				</c:forEach>
				</table>
		</c:catch>
		<c:if test="${ not empty e }">
			사원번호는 숫자로만 구성됩니다.
		</c:if>
	</c:if>
</div>
