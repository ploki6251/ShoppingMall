package com.myproject.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.myproject.dao.MypageDAO;
import com.myproject.domain.BasketVO;
import com.myproject.domain.LikeyVO;
import com.myproject.domain.MemberDateVO;
import com.myproject.domain.TestBean;
import com.myproject.domain.orderVO;



@Service
public class MypageServiceImp implements MypageService {
	
	private static final Logger logger = LoggerFactory.getLogger(MypageServiceImp.class);
	
	@Inject
	private MypageDAO mypageDAO;
	
	//총 구매금액 구하기
	@Override
	public int totalOrderPrice(orderVO orderVO) throws Exception {
		logger.info("MypageService => totalOrderPrice");
		return mypageDAO.totalOrderPrice(orderVO);
	}
	
	//찜 목록
	@Override
	public List<LikeyVO> likeyList(LikeyVO likeyVO) throws Exception {
		logger.info("MypageService => likeyList 가 일한다.🔥🔥🔥");
		return mypageDAO.likeyList(likeyVO);
	}
	
	//찜 목록(product_code만)
	@Override
	public List<Integer> likeyPcList(LikeyVO likeyVO) throws Exception {
		logger.info("MypageService => likeyPcList");
		return mypageDAO.likeyPcList(likeyVO);
	}
	
	//최근 한 달간 찜목록
	@Override
	public List<LikeyVO> likeyListMonth(int member_code) throws Exception {
		logger.info("mypageService => 최근 한달간 찜목록 service");
		return mypageDAO.likeyListMonth(member_code);
	}
	
	//찜목록 삭제(bno)
	@Override
	public int deleteLikey(LikeyVO likeyvo) throws Exception{
		return mypageDAO.deleteLikey(likeyvo);
	}
	
	//찜목록 삭제(product_code로)
	@Override
	public int deleteLikeyPc(LikeyVO likeyVO) throws Exception {
		return mypageDAO.deleteLikeyPc(likeyVO);
	}
	
	//장바구니 목록
	@Override
	public List<TestBean> basketList(BasketVO basketVO) throws Exception {
		logger.info("MypageService => basketList 가 일한다.🔥🔥🔥");
		return mypageDAO.basketList(basketVO);
	}
	
	//장바구니 체크된 항목 bno 전달 -> 상품 이름, 가격 전달
	public TestBean basketCheckedList(BasketVO basketVO) throws Exception {
		logger.info("MypageService => basketCheckedList");
		return mypageDAO.basketCheckedList(basketVO);
	}
	
	//장바구니 목록(product_code만)
	@Override
	public List<Integer> basketPcList(BasketVO basketVO) throws Exception{
		logger.info("MypageService => basketPcList가 일한다.");
		return mypageDAO.basketPcList(basketVO);
		
	}
	
	//장바구니 목록 삭제
	@Override
	public int deleteBasket(BasketVO basketVO) throws Exception {
		return mypageDAO.deleteBasket(basketVO);
	}
	
	//주문내역 보기
	@Override
	public List<orderVO> orderList(orderVO orderVO) throws Exception {
		logger.info("MypageService => orderList 가 일함.");
		return mypageDAO.orderList(orderVO);
	}
	
	//한 달간 주문내역 보기
	@Override
	public List<orderVO> orderListMonth(orderVO orderVO) throws Exception {
		logger.info("MypageService => orderListMonth ");
		return mypageDAO.orderListMonth(orderVO);
	}
	
	//날짜를 설정하여 주문목록을 가져온다.
	@Override
	public List<orderVO> getDateList(MemberDateVO memberdateVO) throws Exception {
		logger.info("mypageService => getDateList");
		return mypageDAO.getDateList(memberdateVO);
	}
	
	//주문목록 상세보기
	@Override
	public TestBean ordersDetailView(orderVO orderVO) throws Exception {
		logger.info("mypageService => ordersDetailView");
		return mypageDAO.ordersDetailView(orderVO);
	}
	
	//주문한 상품 리스트 보기
	@Override
	public List<orderVO> orderProductList(int order_code) throws Exception {
		logger.info("mypageService => orderProductList()");
		return mypageDAO.orderProductList(order_code);
	}
	
	//좋아요 클릭 시 사용자 찜목록 추가
	@Override
	public int insertLike(LikeyVO likeyVO) throws Exception {
		return mypageDAO.insertLike(likeyVO);
	}
	
	//장바구니 목록에 추가
	@Override
	public int insert_basket(BasketVO basketVO) throws Exception {
		return mypageDAO.insert_basket(basketVO);
	}
	

}
