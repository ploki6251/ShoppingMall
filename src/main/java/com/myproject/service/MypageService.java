package com.myproject.service;

import java.util.List;

import com.myproject.domain.BasketVO;
import com.myproject.domain.LikeyVO;
import com.myproject.domain.MemberDateVO;
import com.myproject.domain.TestBean;
import com.myproject.domain.orderVO;



public interface MypageService {
	
	//총 주문금액 구하기
	public int totalOrderPrice(orderVO orderVO) throws Exception;
	
	//찜 목록 보기
	public List<LikeyVO> likeyList(LikeyVO likeyVO) throws Exception;
	
	//찜 목록(product_code만)
	public List<Integer> likeyPcList(LikeyVO likeyVO) throws Exception;
	
	//최근 한달간 찜목록 보기
	public List<LikeyVO> likeyListMonth(int member_code) throws Exception;
	
	//찜 목록 삭제(bno로)
	public void deleteLikey(LikeyVO likeyvo) throws Exception;
	
	//찜목록 삭제(product_code로)
	public int deleteLikeyPc(LikeyVO likeyVO) throws Exception;
	
	//장바구니 목록
	public List<TestBean> basketList(BasketVO basketVO) throws Exception;
	
	//장바구니 체크된 항목 bno 전달 -> 상품 이름, 가격 전달
	public TestBean basketCheckedList(BasketVO basketVO) throws Exception;
	
	//장바구니 목록(product_code만)
	public List<Integer> basketPcList(BasketVO basketVO) throws Exception;
	
	//장바구니 목록 삭제
	public void deleteBasket(BasketVO basketVO) throws Exception;
	
	//주문내역 보기
	public List<orderVO> orderList(orderVO orderVO) throws Exception;

	//한 달간 주문내역 보기
	public List<orderVO> orderListMonth(orderVO ordersVO) throws Exception;
	
	//날짜를 설정하여 주문목록을 가져온다.
	public List<orderVO> getDateList(MemberDateVO memberdateVO) throws Exception;
	
	//주문내역 상세보기
	public TestBean ordersDetailView(orderVO orderVO) throws Exception;
	
	//주문한 상품 리스트 보기
	public List<orderVO> orderProductList(int order_code) throws Exception;
	
	//좋아요 클릭 시 사용자 찜목록 추가
	public int insertLike(LikeyVO likeyVO) throws Exception;
	
	//장바구니 목록에 추가
	public int insert_basket(BasketVO basketVO) throws Exception;
	
}

