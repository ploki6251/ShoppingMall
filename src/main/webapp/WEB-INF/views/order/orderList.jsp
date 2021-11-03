<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문관리</title>
	
	<style>
		.container .nav {list-style: none;}
		.container .nav span {font-size:20px; font-weight:bold; color: black; display:inline-block;}
		.container .nav li {border:1px solid #eee; padding:10px 20px; margin-bottom:10px;}
	</style>
</head>
<!-- 헤더 -->
<header>
<%@ include file="../include/header.jsp" %>
</header>

<!-- body -->
<body>
<br><br><br><br><br><br><br><br><br><br><br>
<div class="container">
		
	<h1 style="font-family: sans-serif; font-weight: bold; font-size: 35px">주문관리</h1>
		
		<hr><br>
		
		<ul class="nav">
			<li>
				<a href="/order/orderList"><span>회원</span></a>
			</li>
			<li>
				<a href="/order/nonOrderList"><span>비회원</span></a>
			</li>
		</ul>
			
			<c:choose>
				<c:when test="${!empty orderList}">
				<table class="table table-hover">
					<thead>
						<tr style="font-family: sans-serif; font-weight: bold; font-size: 17px">
							<th>주문일자</th>
							<th>주문번호</th>
							<th>주문고객</th>
							<th>상품정보</th>
							<th>수량</th>
							<th>상품구매금액</th>
							<th>주문처리상태</th>
						</tr>
					</thead>
					<tbody>
					
					<!-- 관리자 -->
					<c:if test="${member.mlevel == 0}">
						<c:forEach items="${orderList}" var="orderList">
							<tr>
								<td>${orderList.order_date}</td>
								<td><p><a href="/order/orderView?order_code=${orderList.order_code}">${orderList.order_code}</a></p></td>
								<td>${orderList.member_id}[${orderList.member_name}]</td>
								<td>${orderList.product_name}</td>
								<td>${orderList.order_count}</td>
								<td><fmt:formatNumber pattern="###,###,###" value="${orderList.total_price}"/>원</td>
								<td>${orderList.order_status}</td>
							</tr>
						</c:forEach>	
					</c:if>
					</tbody>
				</table>
				</c:when>
			</c:choose>
			
</div>

</body>
<br><br><br><br><br><br><br><br>
<br><br><br><br>
<!-- footer -->
<footer>
<%@ include file="../include/footer.jsp" %>
</footer>

</html>