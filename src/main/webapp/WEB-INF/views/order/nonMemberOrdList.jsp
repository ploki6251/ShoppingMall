<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비회원 주문조회</title>
	
	<style>
		.container ul {list-style: none;}
		.container ul {border:5px solid #eee; padding:10px 20px; margin-bottom:20px;}
		.container ul li {border:1px solid #eee; padding:10px 20px; margin-bottom:20px;}
		.container .orderList 	   {border: 5px solid #eee; padding:10px 20px; margin-bottom:20px;}
		.container .orderList span {font-size:20px; font-weight:bold; display:inline-block;
		width:90px; margin-right:10px;}
		
		.orderlist {border: 5px solid #eee; padding:10px 20px; margin:20px 0;}
		.orderlist span {font-size:20px; font-weight:bold; display:inline-block; width:90px;}
		
		.orderView li {margin-bottom:20px; padding-bottom:20px; border-bottom:1px solid #999; }
		.orderView li::after {content:""; display:block; clear:both;}
		
		.imgView {float:left; width:200px;}
		.imgView img {width:200px; height:200px;}
		
		.info{float:right; width:calc(100% - 220px); line-height:2;}
		.info span {font-size:20px; font-weight:bold; display:inline-block; width:100px;
					margin-right:10px;}
	</style>
</head>
<!-- 헤더 -->
<header>
<%@ include file="../include/header.jsp" %>
</header>

<body>
<br><br><br><br><br><br><br><br><br><br><br>
<div class="container">

	<h1 style="font-family: sans-serif; font-weight: bold; font-size: 35px">비회원 주문조회</h1>
		
		<hr><br>
		
		<!-- 비회원 주문조회 -->
		<ul class="orderView">
			<c:forEach items="${nonMemberOrdList}" var="nonMemberOrdList">
			<li>
				<div class="imgView">
					<img src="${nonMemberOrdList.img_view}" alt="이미지"/>
				</div>
			<div class="info">
				<p>
					<span>상품명</span>${nonMemberOrdList.product_name}<br/>
					<span>상품가격</span><fmt:formatNumber pattern="###,###,###" value="${nonMemberOrdList.product_price}"/>원<br/>
					<span>구입수량</span>${nonMemberOrdList.order_count}개<br/>
					<span>총합</span><fmt:formatNumber pattern="###,###,###" value="${nonMemberOrdList.total_price}"/>원<br/>
				</p>
			</div>
			</li>
			</c:forEach>

		</ul>
		
		<div class="orderList">
			<c:forEach items="${nonMemberOrdList}" var="nonMemberOrdList">
				<p><span>주문번호</span>${nonMemberOrdList.order_code}</p>
				<p><span>주문일자</span>${nonMemberOrdList.order_date}</p>
				<p><span>수령인</span>${nonMemberOrdList.delivery_name}</p>
				<p><span>주소</span>${nonMemberOrdList.roadFullAddr}</p>
				<p><span>번호</span>${nonMemberOrdList.delivery_tel}</p>
				<p><span>상태</span>${nonMemberOrdList.order_status}</p>
			</c:forEach>
		</div>
</div>


</body>
<br><br><br><br><br><br><br><br>
<br><br><br><br>

<!-- footer -->
<footer>
<%@ include file="../include/footer.jsp" %>
</footer>

</html>