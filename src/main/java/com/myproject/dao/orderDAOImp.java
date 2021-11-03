package com.myproject.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.myproject.domain.BasketOrdersVO;
import com.myproject.domain.BasketVO;
import com.myproject.domain.TestBean;
import com.myproject.domain.orderVO;


@Repository
public class orderDAOImp implements orderDAO {
	
private static final Logger logger = LoggerFactory.getLogger(orderDAOImp.class);
	
	@Inject
	SqlSession sqlSession;
	
	private static String namespace = "com.myproject.mappers.orderMapper";

	//단품주문완료
	@Override
	public void orderComplete(orderVO orderVO) throws Exception {
		logger.info("orderDAOImp orderComplete() => " + orderVO);
		sqlSession.insert(namespace + ".orderComplete", orderVO);		
	}
	
	//단품주문완료(orders참조 테이블(bo_ref)에 입력 - 매개변수가 orderVO)
	@Override
	public void insertBo_refByOrderVO(orderVO orderVO) throws Exception {
		logger.info("orderDAOImpl insertBo_refByorderBO() => " + orderVO);
		sqlSession.insert(namespace + ".insertBo_refByOrderVO", orderVO);
	}
	
	//장바구니 주문 성공2
	@Override
	public void insertBo_ref(BasketOrdersVO boarVO) throws Exception{
		logger.info("orderDAOimpl insertBo_ref BasketOrdersVO" + boarVO);
		sqlSession.insert(namespace + ".insertBo_ref", boarVO);
	}

	//주문삭세
	@Override
	public void orderDelete(int order_code) throws Exception {
		logger.info("orderDAOImp orderDelete() => " + order_code);
		sqlSession.delete(namespace + ".orderDelete", order_code);		
	}
	
	// 회원 주문 목록(관리자)
	@Override
	public List<orderVO> orderList() throws Exception {
		return sqlSession.selectList(namespace + ".orderList");
	}
	
	// 비회원 주문 목록(관리자)
	@Override
	public List<orderVO> nonOrderList() throws Exception {
		return sqlSession.selectList(namespace + ".nonOrderList");
	}
	
	// 회원 주문 조회(회원)
	@Override
	public List<orderVO> MemberOrdList(orderVO orderVO) throws Exception {
		return sqlSession.selectList(namespace + ".MemberOrdList", orderVO);
	}
	
	// 비회원 로그인 확인
	@Override
	public orderVO nonlogin(orderVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".nonlogin", vo);
	}
	
	// 비회원 주문 조회
	@Override
	public List<orderVO> nonMemberOrdList(int order_code) throws Exception {
		return sqlSession.selectList(namespace + ".nonMemberOrdList", order_code);
	}
	
	// 주문 상세보기(관리자)
	@Override
	public List<orderVO> orderView(int order_code) throws Exception {
		return sqlSession.selectList(namespace + ".orderView", order_code);
	}
	
	// 배송 상태(관리자)
	@Override
	public void delivery(orderVO vo) throws Exception {
		sqlSession.update(namespace + ".delivery", vo);
	}
	
	//장바구니 주문
	@Override
	public TestBean basketOrder(BasketVO basketVO) throws Exception{
		logger.info("orderDAO basketOrder");
		return sqlSession.selectOne(namespace + ".basketOrder", basketVO);
	}

}
