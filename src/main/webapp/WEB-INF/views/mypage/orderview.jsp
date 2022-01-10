<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 세션 사용여부 옵션 -->
<!-- page 디렉티브의 session 속성의 기본값은 true이므로 false로 지정하지 않으면 자동 생성된다. -->
<% 
if(session.getAttribute("member") == null) {

	out.println("<script> alert('세션이 비어있습니다. 로그인 페이지로 이동합니다.'); </script>");
	out.println("<script> location.href = '/member/login'; </script>");
	//response.sendRedirect("/member/login"); 실행되기 이전의 out.print들은 무시함
}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문상세보기</title>
	
	<style type="text/css">
	body{
		background-color: #F8F8F8;
		padding-top: 180px;
	}
	
	img{
		width: 100px;
		height: 100px;
		object-fit: fill;
	}
	</style>
	
</head>
<%@include file="../include/header.jsp" %>
<body>
	<div class="container">
		<h1>주문상세보기</h1><hr/>
		
		<table class="table table-sm table-response" style="width: 70%;">
			
				<thead class="thead-dark">
					<tr>
						<th colspan="2">상품명</th>
						<th>주문수량</th>				
					</tr>									
				</thead>
				<tbody>
					<c:forEach items="${orderProductList}" var="TestBean">
						<tr>
							<td style="width: 20%;"><img src="${TestBean.products.img_view}" alt="상품썸네일"/></td>
							<td><a href="${path}/products/productView?product_code=${TestBean.products.product_code}">${TestBean.products.product_name}</a></td>
							<td>${TestBean.orders.order_count}</td>
						</tr>					
					</c:forEach>
			</tbody>
		</table>
		
		
		<h3>주문자정보</h3>
		<div class="table-sm table-orderinfo">		
            <table class="table table-borderless">
                <colgroup>
                    <col width="140" />
                    <col width="*" />
                    <col width="140" />
                    <col width="*" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row"><div class="">주문코드</div></th>
                        <td><div class="">${orderDetailview.orders.order_code}</div></td>
                        <th scope="row"><div class="">주문일자</div></th>
                        <td><div class=""><fmt:formatDate value="${orderDetailview.orders.order_date}" pattern="yyyy-MM-dd HH:mm:ss"/></div></td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="">주문자</div></th>
                        <td><div class="">${orderDetailview.member.member_name}</div></td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        <h3>배송정보</h3>
		<div class="table-sm table-orderinfo">
            <table class="table table-borderless">
                <colgroup>
                    <col width="140" />
                    <col width="*" />
                    <col width="140" />
                    <col width="*" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row"><div class="">수취인</div></th>
                        <td><div class="">${orderDetailview.orders.delivery_name}</div></td>
                        <th scope="row"><div class="">연락처</div></th>
                        <td> ${orderDetailview.orders.delivery_tel}</td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="">주소</div></th>
                        <td><div class="">${orderDetailview.orders.roadFullAddr}</div></td>
                    </tr>
                    
                    <tr>
                    	<th scope="row"><div class="">배송상태</div></th>
                        <td><div class="">${orderDetailview.orders.order_status}</div></td>
                        <th scope="row"><div class=""></div></th>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	</div>
</body>
<%@ include file="../include/footer.jsp" %>

<script src="../../../resources/js/jquery-3.6.0.min.js"></script>
<script src="../../../resources/bootstrap/js/bootstrap.min.js"></script>
<script>

</script>

</html>