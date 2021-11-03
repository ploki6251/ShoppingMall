package com.myproject.service;

import java.util.List;

import com.myproject.domain.BasketOrdersVO;
import com.myproject.domain.BasketVO;
import com.myproject.domain.TestBean;
import com.myproject.domain.orderVO;

public interface orderService {	
		
	//주문완료
	public void orderComplete(orderVO orderVO) throws Exception;
	
	//주문완료(orders참조 테이블(bo_ref)에 입력 - 매개변수가 orderVO)
	public void insertBo_refByOrderVO(orderVO orderVO) throws Exception;
	
	//장바구니 결제 성공
	public void insertBo_ref(BasketOrdersVO baorVO) throws Exception;
	
	// 회원 주문 목록(관리자)
	public List<orderVO> orderList() throws Exception;
		
	// 비회원 주문 목록(관리자)
	public List<orderVO> nonOrderList() throws Exception;
		
	// 회원 주문 조회(회원)
	public List<orderVO> MemberOrdList(orderVO orderVO) throws Exception;
		
	// 비회원 로그인 확인
	public orderVO nonlogin(orderVO vo) throws Exception;
		
	// 비회원 주문 조회
	public List<orderVO> nonMemberOrdList(int order_code) throws Exception;
		
	// 주문 상세보기(관리자)
	public List<orderVO> orderView(int order_code) throws Exception;
		
	// 배송 상태(관리자)
	public void delivery(orderVO vo) throws Exception;
		
	//취소
	public void orderDelete(int order_code) throws Exception;
	
	//장바구니 주문
	public TestBean basketOrder(BasketVO basketVO) throws Exception;
}
