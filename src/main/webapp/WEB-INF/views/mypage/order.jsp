<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../../../resources/css/bootstrap.jsp" %>
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
	<title>주문내역</title>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<style type="text/css">
	body{
		background-color: #F8F8F8;
		padding-top: 180px;
	}
	
	
	
	#datepicker_bar{
		width: 775px;
	}
	
	td, th{
		font-size: 14px;
	}
	
	table{
		margin-left: auto;
		margin-right: auto;
	}
	
	img{
		width: 100px;
		height: 100px;
		object-fit: fill;
	}
	
	#pdt_name{
		width: 25%;
	}
	
	#info_null{
		margin-left: auto;
		margin-right: auto;
		height: 500px;
	}
	
	#no_exist{
		color: #999999;
	}
	</style>
	<!-- DateTimePicker CSS -->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<!-- DateTimePicker CSS -->
</head>
<%@include file="../include/header2.jsp" %>
<body>
	<div class="container">
		<h1>주문내역</h1><hr/>
		<br/>
		
		
		<form class="form-horizontal" id="form_search" action="${path}/mypage/order" method="post">
		
			<div class="form-group" align="right">
				<div id="datepicker_bar" align="left">
					<!-- datepicker -->
					<input type="text" id="from_date" value="${from_date}"> ~
			  		<input type="text" id="to_date" value="${to_date}">
			  		&nbsp;&nbsp;&nbsp;
			  		<button type="button" class="btn btn-dark" onclick="view_orderList()">search</button>
					<!-- datepicker -->
				</div>
			</div>
			
			
			<input type="hidden" id="start_date" name="from_date" value="">
			<input type="hidden" id="end_date" name="to_date" value="">
			
			
			
			
			
			
			<div class="form-group" align="center">
				<button type="button" class="btn btn-dark btn-sm" onclick="setDate('day')">오늘</button>
				<button type="button" class="btn btn-dark btn-sm" onclick="setDate('week')">일 주일</button>
				<button type="button" class="btn btn-dark btn-sm" onclick="setDate('month')">한 달</button>
				<button type="button" class="btn btn-dark btn-sm" onclick="setDate('threeMonth')">3개월</button>
				<button type="button" class="btn btn-dark btn-sm" onclick="setDate('sixMonth')">6개월</button>
			</div>
			
			<div class="form-group" align="center">
			<button type="button" class="btn btn-dark btn-sm" >전체</button>
			</div>
		</form>
		
		<c:set var="orderSize" value="${fn:length(order_list)}"/>
		<!-- 분기 -->
		<c:choose>
			<c:when test="${orderSize == 0}">
					
			<div class="col-sm-7" align="center" id="info_null">
				<h2 id="no_exist">주문목록이 없습니다.</h2>
			</div>
					
			</c:when>
			<c:otherwise>
				<table style="width: 70%" class="table table-hover table-responsive">
					<thead class="thead-dark">
						<tr>
							<th>주문일자</th>
							<th colspan="2">상품명</th>
							<th>결제금액</th>
							<th>상세</th>
							<th>배송상태</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach items="${order_list}" var="TestBean">
							<tr>
								<td><fmt:formatDate value="${TestBean.orders.order_date}" pattern="yyyy-MM-dd"/></td>
								<td><img src="${TestBean.products.img_view}" alt="이미지"/></td>
								<td id="pdt_name">
									<c:set var="countOfProductCode" value="${TestBean.orders.cnt_pc}"></c:set>
										<c:choose>
											<c:when test="${countOfProductCode eq 1}">${TestBean.products.product_name}</c:when>
											<c:when test="${countOfProductCode > 1}">${TestBean.products.product_name} 외 ${countOfProductCode - 1} 건</c:when>
											<c:otherwise>오류발생 ?</c:otherwise>
										</c:choose></td>
								<td><fmt:formatNumber pattern="###,###,###" value="${TestBean.orders.total_price}"/>원</td>
								<td><a href="${path}/mypage/orderview?order_code=${TestBean.orders.order_code}"><button class="btn btn-dark btn-sm">상세보기</button></a></td>
								<td>${TestBean.orders.order_status}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>			
			</c:otherwise>
		</c:choose>
		
		
					
					
		<!-- 페이징 처리 -->	
		<!-- <div class="col-sm-offset-4">
			<ul class="btn-group pagination">
			    <c:if test="${pageMaker.prev }">
			    <li>
			        <a href='<c:url value="${path}/mypage/order?page=${pageMaker.startPage-1 }"/>'><span class="glyphicon glyphicon-chevron-left"></span></a>
			    </li>
			    </c:if>
			    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
			    <li>
			        <a href='<c:url value="${path}/mypage/order?page=${pageNum }"/>'><i class="fa">${pageNum }</i></a>
			    </li>
			    </c:forEach>
			    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
			    <li>
			        <a href='<c:url value="${path}/mypage/order?page=${pageMaker.endPage+1 }"/>'><span class="glyphicon glyphicon-chevron-right"></span></i></a>
			    </li>
			    </c:if>
			</ul>
			
		</div>-->
	</div>
</body>
<%@ include file="../include/footer.jsp" %>

<script type="text/javascript">

$(document).ready(function(){
	
	
    //모든 datepicker에 대한 공통 옵션 설정
    $.datepicker.setDefaults({
        dateFormat: 'yy-mm-dd', 	//Input Display Format 변경
        showMonthAfterYear:true, 	//년도 먼저 나오고, 뒤에 월 표시
        showButtonPanel: true,
        changeYear: true, 			//콤보박스에서 년 선택 가능
        changeMonth: true, 			//콤보박스에서 월 선택 가능
        prevText: '이전 달',			//prev 버튼의 툴팁내용
        nextText: '다음 달',			//next 버튼의 툴팁내용
        //showOn: "both", 			//button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
        //buttonImage: "https://i.imgur.com/y8l1clf.png", 			//버튼 이미지 경로
        //buttonImageOnly: true,	//기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
        yearSuffix: "년", 			//달력의 년도 부분 뒤에 붙는 텍스트
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], //달력의 월 부분 텍스트
        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'], 				//달력의 월 부분 Tooltip 텍스트
        dayNamesMin: ['일','월','화','수','목','금','토'], 													//달력의 요일 부분 텍스트
        dayNames: ['일', '월', '화', '수', '목', '금', '토'],	 											//달력의 요일 부분 Tooltip 텍스트
        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
        maxDate: 0,																						//오늘 이후 날짜는 선택 못함.
    });
    
    /*
    $("#from_date" ).datepicker();  
    $('img.ui-datepicker-trigger').css({'cursor':'pointer', 'margin-left':'5px'});  //아이콘(icon) 위치
    $('.ui-datepicker ').css({ "margin-left" : "141px", "margin-top": "-223px"});  //달력(calendar) 위치
    $('img.ui-datepicker-trigger').attr('align', 'absmiddle');
    */

   $("#from_date").datepicker({
		onClose: function( selectedDate ) {
			//시작일(startDate) datepicker가 닫힐때
			//종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
			$("#to_date").datepicker( "option", "minDate", selectedDate );
		}
	});
	
	$("#to_date").datepicker({
		onClose: function( selectedDate ) {
			// 종료일(endDate) datepicker가 닫힐때
			// 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
			$("#from_date").datepicker( "option", "maxDate", selectedDate );
		}
	});
	
	
	
});

//날짜처리
var date = new Date(); //오늘날짜
var week = new Date();
var month = new Date();
var threeMonth = new Date();
var sixMonth = new Date();

week.setDate(date.getDate() -7 );
month.setMonth(date.getMonth() - 1);
threeMonth.setMonth(date.getMonth() - 3);
sixMonth.setMonth(date.getMonth() - 6);

var date_structure = {
		'today' : setFormatDate(date), // 오늘
        'week' : setFormatDate(week),//setFormatDate(new Date(date.setDate(Date.getDate() - 7))),
        'month' : setFormatDate(month),
        'threeMonth' : setFormatDate(threeMonth),
        'sixMonth' : setFormatDate(sixMonth),
}


function setFormatDate(date) {
	var year = date.getFullYear(); //년도를 가져옴
	var month = ('0' + (date.getMonth() + 1)).slice(-2);//0을 붙인다.
	var day = ('0' + date.getDate()).slice(-2); //0을 붙인다.
	
	var dateString = year + '-' + month  + '-' + day;
	return dateString;
}


//날짜 설정 후 보기 버튼 클릭
function view_orderList(){
	var from_date = $("#from_date").val();
	var to_date = $("#to_date").val();
	
	//from_date = $("#from_date").datepicker('getDate');
	//to_date = $("#to_date").datepicker('getDate');
	
	//alert("보기버튼 눌림");
	
	if(from_date == ""){
		alert("시작날짜를 입력하세요.");
		$("#from_date").focus();
		return false;
	}
	
	if(to_date == "") {
		alert("끝 날짜를 입력하세요.");
		$("#to_date").focus();
		return false;
	}
	
	//alert("값 집어넣기 전 : " + document.getElementById('end_date').value);
	
	document.getElementById('start_date').value = from_date;
	document.getElementById('end_date').value = to_date;

	//alert("값 집어넣은 다음 : " + document.getElementById('end_date').value);
	document.getElementById('form_search').submit();
}

function setDate(type){
	if(type=='day'){
		//alert("오늘");
		document.getElementById('start_date').value = date_structure['today'];
		document.getElementById('end_date').value = date_structure['today'];
	}else if(type=='week'){
		//alert("일주일");
		document.getElementById('start_date').value = date_structure['week'];
		document.getElementById('end_date').value = date_structure['today'];
	}else if(type=='month'){
		//alert("한 달");
		document.getElementById('start_date').value = date_structure['month'];
		document.getElementById('end_date').value = date_structure['today'];
	}else if(type=='threeMonth'){
		//alert("3개월");
		document.getElementById('start_date').value = date_structure['threeMonth'];
		document.getElementById('end_date').value = date_structure['today'];
	}else if(type=='sixMonth'){
		//alert("6개월");
		document.getElementById('start_date').value = date_structure['sixMonth'];
		document.getElementById('end_date').value = date_structure['today'];
	}
	
	document.getElementById('form_search').submit();
	
}
</script>

</html>