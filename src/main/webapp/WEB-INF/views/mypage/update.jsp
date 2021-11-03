<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 세션 사용여부 옵션 -->
<!-- page 디렉티브의 session 속성의 기본값은 true이므로 false로 지정하지 않으면 자동 생성된다. -->
<%@ page session="false" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원정보수정</title>
	
	<style type="text/css">
	body{
		background-color: #F8F8F8;
		padding-top: 180px;
	}
	</style>
	
</head>
<%@include file="../include/header.jsp" %>
<body>
	<div class="container">
		<h1>회원정보수정</h1><hr/>
		<form class="form-horizontal" action="${path}/mypage/update" method="post" >
	
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-3">
				<input type="checkbox" name="checkBox_val" id="update_pw_chbox"/>비밀번호 변경
			</div>
		</div>
		
		<!-- 회원 ID 는 숨겨서 넘겨준다. -->
		<input type="hidden" name="member_id" value="${member.member_id}"/>
		
		<!-- 체크박스가 선택되있으면 비밀번호 상자 활성화-->
		<div class="form-group">
			<label class="control-label col-sm-2">비밀번호</label>
			<div class="col-sm-2">
				<input type="password" id="input_pw_txtbox" name="member_pw" class="form-control" maxlength="15" />
			</div>
		</div>
		
		<!-- 체크박스가 선택 헤제 되있으면 나머지 상자들이 비활성화-->
		<div class="form-group">
			<label class="control-label col-sm-2">이름</label>
			<div class="col-sm-2">
				<input type="text" id="input_name_txtbox" name="member_name" class="form-control" maxlength="20" value="${member.member_name}"/><br/>
			</div>
		</div>
		
		<div class="form-group">
			<label class="control-label col-sm-2">주소</label>
			<div class="row">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<div class="col-sm-2">
					<input type="text" id="input_post_txtbox" name="post_no" class="form-control" maxlength="100" value="${member.post_no}"/>
				</div>
				<div class="col-sm-2">
					<button type="button" class="btn btn-sm btn-dark" onclick="daumZipCode()">우편번호</button><br/><br/>
				</div>
			</div>
			
			<div class="col-sm-5">
				<input type="text" id="input_addr1_txtbox" name="member_addr1" class="form-control" maxlength="100" value="${member.member_addr1}"/>
			</div>
			
			<label class="control-label col-sm-2">상세주소</label>
			<div class="col-sm-4">
				<input type="text" id="input_addr2_txtbox" name="member_addr2" class="form-control" maxlength="100" value="${member.member_addr2}"/><br/>
			</div>
			
		</div>
		
		
		<div class="form-group">
			<label class="control-label col-sm-2">이메일</label>
			<div class="col-sm-4">
				<input type="email" id="input_email_txtbox" name="member_email" class="form-control" maxlength="30" value="${member.member_email}"/>
			</div>
		</div>
		
		<div class="form-group">
			<label class="control-label col-sm-2">휴대전화</label>
			<div class="col-sm-4">
				<input type="text" id="input_phone_txtbox" name="member_tel" class="form-control" maxlength="15" value="${member.member_tel}"/>
			</div>
		</div>
		
		
		<div class="form-group">
			<div class="col-sm-offset-3">
				<button type="submit" id="btn_update" class="btn btn-dark btn-sm">수정</button> 
			</div>
			
		</div>
		
	</form>
		
		
		
		
		
		
		
		
		
		
	</div>
</body>
<%@ include file="../include/footer.jsp" %>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 우편번호 검색기능 -->
<script>
$(document).ready(function() {
	
	//초반의 체크박스의 상태에 따라 비활성화(disabled) 시킬 텍스트 박스 지정
	if($("#update_pw_chbox").is(":checked")) { //체크되있는 상태
		$("#input_name_txtbox").attr("disabled", true);
		$("#input_post_txtbox").attr("disabled", true);
		$("#input_addr1_txtbox").attr("disabled", true);
		$("#input_addr2_txtbox").attr("disabled", true);
		$("#input_email_txtbox").attr("disabled", true);
		$("#input_phone_txtbox").attr("disabled", true);
	}else{									 //체크안된 상태
		$("#input_pw_txtbox").attr("disabled", true);
	}
	
	//체크박스가 클릭될때마다 동작을 처리
	$("#update_pw_chbox").click(function() {
		if($("#update_pw_chbox").is(":checked")) { //체크되있는 상태
	        $("#input_pw_txtbox").removeAttr("disabled");   // disabled 삭제
			$("#input_name_txtbox").attr("disabled", true);
			$("#input_post_txtbox").attr("disabled", true);
			$("#input_addr1_txtbox").attr("disabled", true);
			$("#input_addr2_txtbox").attr("disabled", true);
			$("#input_email_txtbox").attr("disabled", true);
			$("#input_phone_txtbox").attr("disabled", true);
		}else{									 //체크안된 상태
			$("#input_pw_txtbox").attr("disabled", true);   // disabled true
			$("#input_name_txtbox").removeAttr("disabled"); // disabled 삭제
			$("#input_post_txtbox").removeAttr("disabled"); // disabled 삭제
			$("#input_addr1_txtbox").removeAttr("disabled"); // disabled 삭제
			$("#input_addr2_txtbox").removeAttr("disabled"); // disabled 삭제
			$("#input_email_txtbox").removeAttr("disabled"); // disabled 삭제
			$("#input_phone_txtbox").removeAttr("disabled"); // disabled 삭제
		}
	});
	
		
	//수정 버튼 클릭 시 빈 내용이 있는지 검사
	$("#btn_update").click(function() {
		
		//var checkbox = $("#update_pw_chbox").is(":checked") == true ? true : false ;
		
		
		if($("#update_pw_chbox").is(":checked")) {
			if($("#input_pw_txtbox").val() == ""){
				alert("비밀번호를 입력해 주세요.");
				$("#input_pw_txtbox").focus();
				return false;
			}else{
				//비밀번호 유효성 검사(규칙은 join꺼 따라씀.)
				var reg = /^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&-]).{8,16}$/;
				var password = $("#input_pw_txtbox").val();
				
				if(!reg.test(password)){
					alert("(영문 대소문자/숫자/특수문자 중 3가지 이상 조합, 8자~16자)-비밀번호 설정시 특수문자 *은 제외하세요");
					$("#input_pw_txtbox").focus();
					return false;
				}
			}
			
		}else{
			if($("#input_name_txtbox").val() == "" ) {
				alert("이름을 입력해 주세요.");
				$("#input_name_txtbox").focus();
				return false;
			}
				
			if($("#input_addr1_txtbox").val() =="" ) {
				alert("주소를 입력해 주세요.");
				$("#input_addr1_txtbox").focus();
				return false;
			}
			
			if($("#input_addr2_txtbox").val() =="" ) {
				alert("상세주소를 입력해 주세요.");
				$("#input_addr2_txtbox").focus();
				return false;
			}
				
			if($("#input_email_txtbox").val() == "" ) {
				alert("이메일을 입력해 주세요.");
				$("#input_email_txtbox").focus();
				return false;
			}
				
			if($("#input_phone_txtbox").val() == "") {
				alert("휴대전화를 입력해 주세요.");
				$("#input_phone_txtbox").focus();
				return false;
			}
		}
		
		//return false; //주석처리 해야함.
		
		//체크박스(update_pw_chbox) 값을 ajax로 넘김.
	});
	
	
});

//우편번호 검색관련
function daumZipCode() {
	new daum.Postcode({
		oncomplete: function(data) {
			//팝업창에서 검색한 결과 중 항목을 클릭하였을 경우에 
			//실행할 코드를 이곳에 작성한다.

			//각 주소의 노출 규칙에 따라 주소를 조합한다.
			//내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로,
			//이름 참고하여 분기한다.
			var fullAddr  = '';	//최종 주소 변수
			var subAddr   = ''; //조합형 주소 변수

			//사용자가 선택한 주소의 타입에 따라서 해당 주소값을 가져온다.
			if(data.userSelectedType == 'R') { //도로명 주소를 선택한 경우
				fullAddr = data.roadAddress;
			} else { //지번 주소를 선택한 경우
				fullAddr = data.jibunAddress;
			}

			//사용자가 선택한 주소가 도로명 타입일 때 조합한다.
			if(data.userSelectedType == 'R') {
				//법정동명이 있을 경우 추가한다.
				if(data.bname != '') {
					subAddr += data.bname;
				}
				//건물명이 있을 경우에 추가한다.
				if(data.buildingName != '') {
					subAddr += (subAddr != '' ? ', ' + data.buildingName : data.buildingName);
				}
				//조합형 주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
				fullAddr += (subAddr != '' ? '(' + subAddr + ')' : '');
			}
			//우편번호와 주소정보를 행당 필드에 나타낸다.
			//5자리의 새 우편번호
			document.getElementById('input_post_txtbox').value   = data.zonecode; 
			document.getElementById('input_addr1_txtbox').value = fullAddr;
			//커서를 상세주소 입력필드로 이동시킨다.
			document.getElementById('input_addr2_txtbox').focus();
		}
	}).open();
}




//전화번호 입력 시 자동 '-' 삽입
$(document).on("keyup", "#input_phone_txtbox", function() {
//$("#input_phone_txtbox").keyup(function() {
	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
});
//});


</script>

</html>









