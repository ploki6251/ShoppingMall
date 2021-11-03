package com.myproject.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.myproject.dao.orderDAO;
import com.myproject.domain.BasketOrdersVO;
import com.myproject.domain.BasketVO;
import com.myproject.domain.TestBean;
import com.myproject.domain.orderVO;




@Service
public class orderServiceimpl implements orderService {
	
	@Inject	
	orderDAO orberDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(orderServiceimpl.class);

	//단품구매
	@Override
	public void orderComplete(orderVO orderVO) throws Exception {		
		logger.info("orderServiceimpl orderComplete() => " + orderVO);
		orberDAO.orderComplete(orderVO);
	}
	
	//단품주문완료(orders참조 테이블(bo_ref)에 입력 - 매개변수가 orderVO)
	@Override
	public void insertBo_refByOrderVO(orderVO orderVO) throws Exception{
		logger.info("orderServiceImpl insertBo_refByOrderVO() =>" + orderVO);
		orberDAO.insertBo_refByOrderVO(orderVO);
	}
	
	//장바구니 주문  성공2
	@Override
	public void insertBo_ref(BasketOrdersVO baorVO) throws Exception {
		logger.info("orderServiceimpl insertBo_ref");
		orberDAO.insertBo_ref(baorVO);
	}
		
	// 회원 주문 목록(관리자)
	@Override
	public List<orderVO> orderList() throws Exception {
		return orberDAO.orderList();
	}	
		
	// 비회원 주문 목록(관리자)
	@Override
	public List<orderVO> nonOrderList() throws Exception {
		return orberDAO.nonOrderList();
	}
		
	// 회원 주문 조회(회원)
	@Override
	public List<orderVO> MemberOrdList(orderVO orderVO) throws Exception {
		return orberDAO.MemberOrdList(orderVO);
	}
		
	// 비회원 로그인 확인
	@Override
	public orderVO nonlogin(orderVO vo) throws Exception {
		// TODO Auto-generated method stub
		return orberDAO.nonlogin(vo);
	}
		
	// 비회원 주문 조회
	@Override
	public List<orderVO> nonMemberOrdList(int order_code) throws Exception {
		return orberDAO.nonMemberOrdList(order_code);
	}
		
	// 주문 상세보기(관리자)
	@Override
	public List<orderVO> orderView(int order_code) throws Exception {
		return orberDAO.orderView(order_code);
	}
		
	// 배송 상태(관리자)
	@Override
	public void delivery(orderVO vo) throws Exception {
		orberDAO.delivery(vo);
	}

	//취소
	@Override
	public void orderDelete(int order_code) throws Exception {		
		logger.info("orderServiceimpl orderDelete() => " + order_code);
		orberDAO.orderDelete(order_code);
	}
	
	//장바구니 주문
	@Override
	public TestBean basketOrder(BasketVO basketVO) throws Exception {
		logger.info("orderServiceimpl basketOrder ");
		return orberDAO.basketOrder(basketVO);
	}

	

	

}
