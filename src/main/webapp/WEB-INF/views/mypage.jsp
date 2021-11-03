<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myproject.domain.LikeyVO"%>
<%@ page import="com.myproject.domain.orderVO"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %> 

<!-- 세션 사용여부 옵션 -->
<!-- page 디렉티브의 session 속성의 기본값은 true이므로 false로 지정하지 않으면 자동 생성된다. -->
<%@ page session="false" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지</title>
	
	<style type="text/css">
	body{
	background-color: #F8F8F8;
	padding-top: 180px;
	}
	
	#welcome{
	overflow:hidden;
	padding:20px 10px 10px 90px;
	border: 8px solid #9d9d9d;
	height: 150px;
	color:#353535;
	}
	
	#welcome #p_area{
	font-size: 13px;
	line-height:5px;
	
	}
	
	table tbody tr td img{
		width: 200px;
		height: 200px;
		object-fit: fill;
	}
	
#myshopMain{
margin:20px 20px 40px -20px;
/*border-top:5px solid #333;
border-bottom:5px solid #333;*/
}

/*
#myshopMain .shopMain{
height:90px;
padding:27px 0 0 30px;
border-bottom:1px solid #e9e9e9;
background:url("//img.echosting.cafe24.com/skin/base_ko_KR/myshop/bg_myshop1.gif") no-repeat 100% 0;
}
*/
/*
#myshopMain .shopMain h3{
padding:0 0 5px;
font-size:11px;
color:#333;
font-weight:normal;
}

#myshopMain .shopMain h3 strong{
font-size:18px;
padding:0 5px 0 0;
font-family:'Lucida Sans',serif;
}

#myshopMain .shopMain h3 a:hover{
text-decoration:none;
}

#Main .shopMain p a{
font-size:11px;
line-height:18px;
color:#8f8f8f;
}
*/
/*
#social{
border: 1px solid;
}
*/
#social ul {
list-style:none;
}

#homeBox_my{
position: relative;
float: left;
display:block;
}

#homeBox_my .one_fourth_my{
text-align:center;
overflow: hidden;
border-top:1px solid #E1E1E1;
border-right:1px solid #E1E1E1;
border-bottom:1px solid #E1E1E1;
border-left:1px solid #E1E1E1;
height:270px;
/*width:310px;*/
margin-right:0px;
-moz-box-shadow:0px 1px 0px #ecebeb;
-webkit-box-shadow:0px 1px 0px #ecebeb;
-webkit-transition:background 0.5s linear;
-moz-transition:background 0.5s linear;
-o-transition:background 0.5s linear;
transition:background 0.5s linear;
}

#homeBox_my .one_fourth_my div{
padding:10px 10px 10px 10px;
}

#homeBox_my .one_fourth_my:hover{
 background:#5e5e5e;
 }
 
 #homeBox_my .one_fourth_my .boxImage_my{
 margin:10px 0px 10px;
 -webkit-transition:all 0.2s linear;
 -moz-transition:all 0.2s linear;
 -o-transition:all 0.2s linear;
 transition:all 0.2s linear;
 }
 
 #homeBox_my .one_fourth_my:hover .boxImage_my{
 position: relative;
 -webkit-animation: moveFromTop 350ms ease;
 -moz-animation: moveFromTop 350ms ease;
 -ms-animation: moveFromTop 350ms ease;
 }
 
 #homeBox_my .one_fourth_my h2{
 color:#4B4A4A;
 margin:5px 0 10px 0;
 font-family:Dotum,"돋음","맑은고딕","Malgun Gothic",sans-serif;
 -webkit-transition:all 0.2s linear;
 -moz-transition:all 0.2s linear;
 -o-transition:all 0.2s linear;
 transition:all 0.2s linear;
 }
 
 #homeBox_my .one_fourth_my:hover h2{
 position: relative;
 color:#EAEAEA;
 -webkit-animation: moveFromTop 200ms ease;
 -moz-animation: moveFromTop 200ms ease;
 -ms-animation: moveFromTop 200ms ease;
 }
 
 #homeBox_my .one_fourth_my .boxDescription_my{
 color:#8d8d8d;
 margin:0 0 -10px 0;
 letter-spacing:0px;
 font-family:Dotum,"돋음","맑은고딕","Malgun Gothic",sans-serif;
 -webkit-transition:all 0.2s linear;
 -moz-transition:all 0.2s linear;
 -o-transition:all 0.2s linear;
 transition:all 0.2s linear;
 }
 
 #homeBox_my .one_fourth_my .boxDescription_my a{
 color:#d1d1d1;margin:0 0 -10px 0;
 letter-spacing:0px;
 font-family:Dotum,"돋음","맑은고딕","Malgun Gothic",sans-serif;
 -webkit-transition:all 0.2s linear;
 -moz-transition:all 0.2s linear;
 -o-transition:all 0.2s linear;
 transition:all 0.2s linear;
 }
 
 #homeBox_my .one_fourth_my:hover .boxDescription_my a:hover{
 position: relative;
 color:#ff9797;
 background:#5e5e5e;
 text-decoration:none;
 font-family:Dotum,"돋음","맑은고딕","Malgun Gothic",sans-serif;
 -webkit-animation: moveFromBottom 500ms ease-in-out;
 -moz-animation: moveFromBottom 500ms ease-in-out;
 -ms-animation: moveFromBottom 500ms ease-in-out;
 }
 
#info_null{
	height: 100px;
}
	
#no_exist{
	color: #999999;
}
 
	
	
</style>
</head>
<%@ include file="include/header.jsp" %>
<body>
	<div class="container">
		<h1>마이페이지</h1><hr/>
		<div class="row">
			<div class="col-sm-12">
				<div id="welcome">
					<h2>${member.member_name}님 환영합니다.</h2>
					<a href="${path}/mypage/password">회원정보수정</a>
					<div id="p_area" align="right">
						<p>가입일자 : ${member.mcreate}</p> <!-- fmt:formatDate value="${member.mcreate}" pattern="yyyy-MM-dd"/-->
						<p>총 구매금액 : ${totalOrderPrice} 원</p>
					</div>
					
				</div>
			</div>
			
			<div id="myshopMain" class="col-sm-12"><!-- 마이페이지 시작 -->
				<div id="social" class="col-sm-12">
					<ul>
						<li>
				            <div id="homeBox_my" class="col-sm-4" >
				                <div class="one_fourth_my">
				                    <div class="boxImage_my"><img src="https://i.imgur.com/6OD0Yhl.png" alt="order"/></div>	
				                    <h2>주문내역조회</h2>			
				                    <div class="boxDescription_my">고객님의 주문내역을 가져옵니다.</div>	
				                    <div class="boxDescription_my"><a href="${path}/mypage/order">${order_list_size}건</a></div>
				                </div>
				            </div>
				        </li>
				        <li>
				            <div id="homeBox_my" class="col-sm-4">
				                <div class="one_fourth_my">
				                    <div class="boxImage_my"><img src="https://i.imgur.com/Yta0MBb.png" alt="basket"/></div>	
				                    <h2>장바구니</h2>			
				                    <div class="boxDescription_my">고객님의 장바구니 내역을 가져옵니다.</div>	
				                    <div class="boxDescription_my"><a href="${path}/mypage/basket">${basket_list_size}건</a></div>
				                </div>
				            </div>
				        </li>
				        <li>
				            <div id="homeBox_my" class="col-sm-4">
				                <div class="one_fourth_my">
				                    <div class="boxImage_my"><img src="https://i.imgur.com/rIJu6FK.png" alt="likey"/></div>	
				                    <h2>찜목록</h2>			
				                    <div class="boxDescription_my">고객님이 찜한 상품을 보여드립니다.</div>	
				                    <div class="boxDescription_my"><a href="${path}/mypage/likey">${likey_list_size}건</a></div>
				                </div>
				            </div>
				        </li>
				       </ul>
				  </div>
			</div>
		</div>
		
		<h2>최근 주문</h2><hr/>
		<c:set var="orderMonSize" value="${fn:length(orderListMon)}"/>
		
		<c:choose>
			
			<c:when test="${orderMonSize == 0}">
			<div class="col-sm-10" align="center" id="info_null">
				<h2 id="no_exist">최근 주문 목록이 없습니다.</h2>
			</div>
			</c:when>
			
			<c:otherwise>
				<div class="col-sm-10">
					<table class="table table-hover table-condensed">
						<caption>최근 한 달간 목록만 표시됩니다.</caption>
						<thead class="thead-dark">
							<tr>
								<th>상품명</th>
								<th>총 가격</th>
								<th>배송 상태</th>
								<th>주문일자</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${orderListMon}" var="TestBean">
								<tr onClick="location.href='${mypath}/mypage/orderview?order_code=${TestBean.orders.order_code}'">
									<td>
										<c:set var="countOfProductCode" value="${TestBean.orders.cnt_pc}"></c:set>
										<c:choose>
											<c:when test="${countOfProductCode eq 1}">${TestBean.products.product_name}</c:when>
											<c:when test="${countOfProductCode > 1}">${TestBean.products.product_name} 외 ${countOfProductCode - 1} 건</c:when>
											<c:otherwise>오류발생 ?</c:otherwise>
										</c:choose>
									</td>
									<td>${TestBean.orders.total_price}</td>
									<td>${TestBean.orders.order_status}</td>
									<td><fmt:formatDate value="${TestBean.orders.order_date}" pattern="yyyy-MM-dd"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>		
				</div>			
			</c:otherwise>
		
		</c:choose>
		
		
		
		<h2>최근 찜한 내역</h2><hr/>
		<c:set var="likeyMonSize" value="${fn:length(likeyListMon) }"/>
		
		<c:choose>
			<c:when test="${likeyMonSize == 0}">
				<div class="col-sm-8" align="center" id="info_null">
					<h2 id="no_exist">최근 찜한 내역이 없습니다.</h2>
				</div>
			</c:when>
			
			<c:otherwise>
				<div class="col-sm-8">
					<table class="table table-hover table-condensed">
						<caption>최근 한 달간 목록만 표시됩니다.</caption>
						<thead class="thead-dark">
							<tr>
								<th colspan="2">상품명</th>
								<th>금액</th>
								<th>등록 일자</th>
							</tr>			
						</thead>
						<tbody>
							<c:forEach items="${likeyListMon}" var="TestBean">
								<tr>
									<td style="width: 10%"><img src="${TestBean.products.img_view}" alt="상품썸네일"/></td>
									<td><a href="${path}/products/productView?product_code=${TestBean.products.product_code}">${TestBean.products.product_name}</a></td>
									<td>${TestBean.products.product_price}</td>
									<td><fmt:formatDate value="${TestBean.likey.register_date}" pattern="yyyy-MM-dd"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:otherwise>
		</c:choose>
		
		
		
		
		<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
		
	
	</div>

</body>
<%@ include file="include/footer.jsp" %>
</html>