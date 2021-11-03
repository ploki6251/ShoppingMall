package com.myproject.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.myproject.controller.MypageController;
import com.myproject.domain.BasketVO;
import com.myproject.domain.LikeyVO;
import com.myproject.domain.MemberDateVO;
import com.myproject.domain.TestBean;
import com.myproject.domain.orderVO;



@Repository
public class MypageDAOImpl implements MypageDAO {
	
private static final Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	@Inject
	SqlSession sqlSession;
	
	//네임스페이스 조심. mypageMapper.xml 과 일치하도록 작성
	private static String namespace = "com.myproject.mappers.mypgMapper";
	
	//총 구매금액 구하기
	@Override 
	public int totalOrderPrice(orderVO orderVO) throws Exception{
		logger.info("MypageDAO => totalOrderPrice");
		return sqlSession.selectOne(namespace + ".totalOrderPrice", orderVO);
	}
	
	//찜목록 보기
	@Override
	public List<LikeyVO> likeyList(LikeyVO likeyVO) throws Exception {
		logger.info("MypageDAO => likeyList 가 일한다.");
		return sqlSession.selectList(namespace + ".likeyList", likeyVO);
	}
	
	//찜목록(product_code만)
	@Override
	public List<Integer> likeyPcList(LikeyVO likeyVO) throws Exception {
		logger.info("MypageDAO => likeyPcList");
		return sqlSession.selectList(namespace + ".likeyPcList", likeyVO);
	}
	
	//최근 한 달간 찜목록 보기
	@Override
	public List<LikeyVO> likeyListMonth(int member_code) throws Exception {
		logger.info("likeyListMonth => 최든 한달간 찜목록 DAO");
		return sqlSession.selectList(namespace + ".likeyListMonth", member_code);
	}
	
	//찜목록 삭제(bno)
	@Override
	public void deleteLikey(LikeyVO likeyvo) throws Exception {
		sqlSession.delete(namespace + ".deleteLikey", likeyvo);
	}
	
	//찜목록 삭제(product_code로)
	@Override
	public int deleteLikeyPc(LikeyVO likeyVO) throws Exception {
		return sqlSession.delete(namespace + ".deleteLikeyPc", likeyVO);
	}
	
	//장바구니 목록 보기
	@Override
	public List<TestBean> basketList(BasketVO basketVO) throws Exception {
		logger.info("MypageDAO => basketList 가 일한다.");
		return sqlSession.selectList(namespace + ".basketList", basketVO);
	}
	
	//장바구니 체크된 항목 bno 전달 -> 상품 이름, 가격 전달
	@Override
	public TestBean basketCheckedList(BasketVO basketVO) throws Exception {
		logger.info("MypageDAO => basketCheckedList");
		return sqlSession.selectOne(namespace + ".basketCheckedList", basketVO);
	}
	
	//장바구니 목록 보기(product_code만)
	@Override
	public List<Integer> basketPcList(BasketVO basketVO) throws Exception{
		logger.info("MypageDAO => basketPcList가 일한다.");
		return sqlSession.selectList(namespace + ".basketPcList", basketVO);
	}
	
	//장바구니 목록 삭제
	@Override
	public void deleteBasket(BasketVO basketVO) throws Exception {
		sqlSession.delete(namespace + ".deleteBasket", basketVO);
	}
	
	//주문내역 보기
	@Override
	public List<orderVO> orderList(orderVO orderVO) throws Exception {
		logger.info("MypageDAO => orderList 가 일함");
		return sqlSession.selectList(namespace + ".orderList", orderVO);
	}
	
	//최근 한 달 간 주문내역 보기
	@Override
	public List<orderVO> orderListMonth(orderVO orderVO) throws Exception {
		logger.info("MypageDAO => orderListMonth ");
		return sqlSession.selectList(namespace + ".orderListMonth", orderVO);
	}
	
	//날짜를 설정하여 주문목록을 가져온다.
	@Override
	public List<orderVO> getDateList(MemberDateVO memberdateVO) throws Exception {
		logger.info("mypageDAO => getDateList ");
		return sqlSession.selectList(namespace + ".getDateList", memberdateVO);
	}
	
	//주문목록 상세보기
	@Override
	public TestBean ordersDetailView(orderVO orderVO) throws Exception {
		logger.info("mypageDAO => orderDetailView");
		return sqlSession.selectOne(namespace + ".ordersDetailView", orderVO);
	}
	
	//주문한 상품 리스트 보기
	@Override
	public List<orderVO> orderProductList(int order_code) throws Exception {
		logger.info("mypageDAO => orderProductList");
		return sqlSession.selectList(namespace + ".orderProductList", order_code);
	}
	
	//좋아요 클릭 시 사용자 찜목록 추가
	@Override
	public int insertLike(LikeyVO likeyVO) throws Exception {
		return sqlSession.insert(namespace + ".insertLike", likeyVO);
	}
	
	//장바구니 목록에 추가
	@Override
	public int insert_basket(BasketVO basketVO) throws Exception {
		return (int)sqlSession.insert(namespace + ".insert_basket", basketVO);
	}
	
	/*
	 * selectList : 쿼리 결과를 List<E>로 반환
	 * 				결과가 없을 시에는 빈 List를 반환한다.
	 * 
	 * selectOne : 쿼리 결과는 하나의 레코드가 나와야 한다.
	 * 			   쿼리결과가 없으면 null을 반환
	 * 			   DB에 레코드가 하나만 있는경우에 사용 => 다수의 레코드가 있을 시 TooManyResultException에러 발생
	 * 
	 * */
}
	
