<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %> 
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
	<title>장바구니 목록</title>
	
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
	
	#no_exist{
		color: #999999;
	}
	</style>
	
</head>
<%@include file="../include/header.jsp" %>
<body>
	<div class="container">
		<c:set var="basketSize" value="${fn:length(basket_list)}"/>
		
		<h1>장바구니 목록</h1><hr/>
		<div class="row">	
			<!-- 분기 -->
			<c:choose>
				<c:when test="${basketSize == 0}">
				<div class="col-sm-8" align="center" id="info_null">
					<h2 id="no_exist">장바구니 목록이 없습니다.</h2>
				</div>
						
				</c:when>
				
				<c:otherwise>
					<div class="col-sm-8">
						<div class="form-group float-right">
							<button type="button" id="btn_delete" class="btn-dark btn-sm">선택삭제</button>
						</div>
						<!-- 장바구니 목록 테이블 -->
						<table class="table table-hover">
							<thead class="thead-dark">
								<tr>
									<th colspan="2">상품명</th>
									<th>수량</th>
									<th>단가</th>
									<th>가격</th>
									<th>등록일자</th>
									<th><input type="checkbox" id="select_all" name="select_all" onclick="clk_preChBox()"/></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${basket_list}" var="TestBean">
									<tr>
										<td><img src="${TestBean.products.img_view}" alt="상품썸네일"/></td>
										<td><a href="${path}/products/productView?product_code=${TestBean.products.product_code}">${TestBean.products.product_name }</a></td>
										<td> ${TestBean.basket.basket_count}</td>
										<td> <fmt:formatNumber pattern="###,###,###" value="${TestBean.products.product_price}"/>원</td>
										<td> <fmt:formatNumber pattern="###,###,###" value="${TestBean.basket.basket_price}"/>원</td>
										<td><fmt:formatDate value="${TestBean.basket.register_date}" pattern="yyyy-MM-dd"/></td>
										<td><input type="checkbox" class="select_item" name="select_item" onclick="clk_chBox()" data-bno="${TestBean.basket.bno}" data-name="${TestBean.products.product_name} " data-price="${TestBean.basket.basket_price}" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:otherwise>
			</c:choose>
			<!-- 계산서 형식의 표 -->
			<div class="col-sm-4">
				<form action="/order/basketorder" method="get" id="frm_bill">
				<input type="hidden" id="myInputValue" value="" name="basketListbno[]"/>
					<table class="table fixed-right">
						<thead class="thead-light">
							<tr>
								<th colspan="2" class="text-center">결제금액</th>
							</tr>
						</thead>
						<tbody id="bill_tbody">
							<c:set var="total" value="0"/>
							
							
							
							
						</tbody>
						
					<tfoot>							
						<tr>
							<td class="text-right">총 결제금액</td>
							<td class="text-right" id="sum_of_bill">${total}원</td>
						</tr>
						<tr>
							<td colspan="2" class="text-right"><button type="button" onclick="test()" id="btn_pay" class="btn btn-warning" style="width: 100%">결제하러가기</button></td>
						</tr>
					</tfoot>
					</table>
				</form>	
			</div>
		</div>
	</div>
</body>
<%@ include file="../include/footer.jsp" %>

<script>

	//전역변수
	var checkedItemBno = new Array();
	
	$(document).ready(function() {
		
		
		
		//항목의 value가 변경되면
		//$(".select_item").change(function() {
			
			//var checkedItemArr_name = new Array(); //선택된 항목의 이름을 담을 배열선언
			//var checkedItemArr_price = new Array(); //선택된 항목의 가격을 담을 배열선언
			
			//$("input[name='select_item']:checked").each(function(){
				//checkedItemArr_name.push($(this).attr("data-name")); //배열에 선택된  항목의 이름을 담음
			//});
			
			//$("input[name='select_item']:checked").each(function(){
				//checkedItemArr_price.push($(this).attr("data-price")); //배열에 선택된 항목의 가격을 담음
			//});
			
			
			
			//$.ajax({
				//type : "get",
				//url : "${path}/myapp/myapge/basket",
				//data: { name 	: 	checkedItemArr_name,
						//price 	:  checkedItemArr_price
					  //},
				//datatype: "json",
				//async : true,
				//success: function(){
					//alert("전달 성공");
				//}
			//});
			
		//});
		
		//체크한 항목을 삭제처리하는 ajax
		$("#btn_delete").click(function(){ //id = "btn_delete"
			var selected_cnt = $("input[name='select_item']:checked").length; //selected_cnt = 선택된 항목의 갯수
		
			if(selected_cnt == 0){ //선택된 항목이 없는경우
				alert("상품을 선택하세요.");
			}else{
				var confirm_val = confirm(selected_cnt + "개의 항목을 삭제하시겠습니까?"); 	//alert 창을 띄우고 yes/no 값을 받아와 confirm_val에 저장.
				
				if(confirm_val) {													//삭제 값이 yes일 경우
					var checkedItemArr = new Array(); //배열선언
			   
					$("input[name='select_item']:checked").each(function(){
						checkedItemArr.push($(this).attr("data-bno"));
					});
					
					$.ajax({
						type : "post",								//전송할 방식.
						url : "${path}/mypage/delete_basket", //전송할 컨트롤러 이름.
				    	data : {selected_item : checkedItemArr},	//컨트롤러로 전송하는 변수 checkedItemArr 값을 담아 "selected_item" 이라는 변수 이름으로 컨트롤러에게 넘겨줌		
				    	success : function(result){					//result값이 1 = 전송 / 0 = 전송실패.
				    		if(result == 1) {
				    			alert(selected_cnt + "개가 삭제되었습니다.");
				    			location.href = "${path}/mypage/basket";	// mypage/basket를 새로고침 시킴
				    		}else{
				    			alert("삭제 실패!!!");
				    		}
				    	},
				    	error: function(request, status, error){
				    		alert("ajax 오류!");
				    		alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
				    	}
					});
				}
			}
		});
		
		//결제하러 가기 버튼을 누르면 결제 페이지로 가는 ajax
		/*$("#btn_pay").click(function(){
			var basketListBno = new Array();
			
			$("td[id='bno']").each(function() {
				basketListBno.push($(this).attr("data-bno"));
			});
			
			$.ajax({
				type: "get",
				url: "${path}/order/basketorder",
				data : {basketListbno : basketListBno},
				success : function(){
						alert("각 행의 bno 값 전송 성공");
						location.href = "${path}/order/basketorder?basketListbno[]=" + $.param(basketListBno);
				},
				error: function(request, status, error){
					alert("ajax 오류!");
		    		alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
				}
			});
			
			
		});*/
	
	});

//체크박스 클릭 시 실행될 함수 정의
function clk_chBox() {
	
	//var checkedItemBno = new Array(); //배열선언
	var checkedItemName= new Array(); //배열선언
	var checkedItemPrice=new Array(); //배열선언
	var html;
	var sum_of_price = 0;
	
	checkedItemBno.splice(0, checkedItemBno.length); //checkedItemBno 배열을 요소 0부터 배열 길이까지 삭제(빈 배열 만들기)
	//alert("배열 내용 : " + checkedItemBno);  //정상 작동
	
	$("#select_all").prop("checked", false);
	
	$("input[name='select_item']:checked").each(function(){
		checkedItemBno.push($(this).attr("data-bno"));
	});

	$("input[name='select_item']:checked").each(function(){
		checkedItemName.push($(this).attr("data-name"));
	});
	
	$("input[name='select_item']:checked").each(function(){
		checkedItemPrice.push($(this).attr("data-price"));
	});
	
	//alert(checkedItemName); //정상작동
	//alert(checkedItemPrice); //정상작동
 	//alert(checkedItemBno);   //정상작동
	
	for(var i=0 ; i < checkedItemName.length ; i++){
		html += '<tr>';
		html += '<td>'+checkedItemName[i]+'</td>';
		html += '<td>'+checkedItemPrice[i]+'</td>';
		html += '</tr>';
		
		$("#bill_tbody").empty();
		$("#bill_tbody").append(html);
		
		sum_of_price += parseInt(checkedItemPrice[i]);
	}
	
	if(checkedItemName.length == 0 || checkedItemPrice.length == 0){
		$("#bill_tbody").empty();
		sum_of_price = 0;
	}
	
	$('#sum_of_bill').html(sum_of_price + "원");
	
	
	/*
	$.ajax({
		type : "post",
		url : "${path}/mypage/basket_bill",
		data: { selected_item : checkedItemArr},
		success: function(data){
			console.log("data: " + JSON.stringify(data)); //정상출력
			//console.log("데이터 : " + data); //object Object
		},
		error: function(request, status, error){
    		alert("ajax 오류!");
    		alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
    	}
	});
	*/
	
	
	
}

//맨 위에있는 체크박스 클릭시 동작
function clk_preChBox(){
	var checkedItemName = new Array(); //배열선언
	var checkedItemPrice= new Array(); //배열선언
	var html;
	var sum_of_price = 0;
	
	checkedItemBno.splice(0, checkedItemBno.length); //checkedItemBno 배열을 요소 0부터 배열 길이까지 삭제(빈 배열 만들기)
	//alert("배열 내용 : " + checkedItemBno);  //정상 작동
	
	if($("#select_all").prop("checked")){
		//console.log('전체선택 버튼 눌림');
		$("input[name=select_item]").prop("checked", true);
	}else{
		$("input[name=select_item]").prop("checked", false);
	}
	
	$("input[name='select_item']:checked").each(function(){
		checkedItemBno.push($(this).attr("data-bno"));
	});
	
	$("input[name='select_item']:checked").each(function(){
		checkedItemName.push($(this).attr("data-name"));
	});
	
	$("input[name='select_item']:checked").each(function(){
		checkedItemPrice.push($(this).attr("data-price"));
	});
	
	//alert(checkedItemName); //정상작동
	//alert(checkedItemPrice); //정상작동
	
	
	for(var i=0 ; i < checkedItemName.length ; i++){
		html += '<tr>';
		html += '<td>'+checkedItemName[i]+'</td>';
		html += '<td>'+checkedItemPrice[i]+'</td>';
		html += '</tr>';
		
		$("#bill_tbody").empty();
		$("#bill_tbody").append(html);
		
		sum_of_price += parseInt(checkedItemPrice[i]);
	}
	
	if(checkedItemName.length == 0 || checkedItemPrice.length == 0){
		$("#bill_tbody").empty();
		sum_of_price = 0;
	}
	
	$('#sum_of_bill').html(sum_of_price + "원");
}

function test() {
	//alert("결제하러가는길~");
	var checkedListOfBno = new Array();

	checkedListOfBno = checkedItemBno;
		
	//alert(checkedListOfBno); //정상
	
	if(checkedListOfBno.length == 0){
		alert("상품을 선택해주세요.");
	}else{
		document.getElementById('myInputValue').value = checkedListOfBno;
		document.getElementById('frm_bill').submit();
	}
	
	
	/*
	$.ajax({
		type: "post",
		url: "${path}/mypage/checkedItemBno",
		data: {checkedBno : checkedListOfBno},
		success: function(data){
			console.log("data: " + JSON.stringify(data));
			alert("성공");
		},
		error: function(request, status, error) {
			alert("ajax 오류!");
    		alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
		}
	});
	*/
}



</script>

</html>


















