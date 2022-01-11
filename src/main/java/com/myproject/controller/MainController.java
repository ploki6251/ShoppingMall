package com.myproject.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.myproject.domain.BasketVO;
import com.myproject.domain.LikeyMonthVO;
import com.myproject.domain.LikeyVO;
import com.myproject.domain.MemberVO;
import com.myproject.domain.TestBean;
import com.myproject.domain.orderVO;
import com.myproject.service.MypageService;


@Controller
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Inject
	private MypageService mypageService;
	
	//메인페이지
	@RequestMapping("/")
	public String memberMain(Model model, HttpServletRequest req) {
		//로그인세션가져오기		  
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("member");	
		model.addAttribute("member", memberVO);
		
		return "memberMain";
	}	
			
	//로그인
	@RequestMapping(value="/include/header", method=RequestMethod.POST) 
	public void headerlogin(Model model, HttpServletRequest req) throws Exception {		  
		//로그인세션가져오기		  
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("member");	
		model.addAttribute("member", memberVO);
	}
	
	//마이페이지 메인  get
	@RequestMapping(value="/mypage", method= RequestMethod.GET)
	public void getMypageMain(Model model, HttpServletRequest req, LikeyVO likeyVO, BasketVO basketVO, orderVO orderVO) throws Exception {
		
		//로그인세션가져오기
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("member");	
		model.addAttribute("member", memberVO);
		
		//세션이 비어있으면 alert 후 로그인 화면으로 돌려보냄
		
		if(memberVO == null) {
			System.out.println("세션이 비었음.");
		}else {
			int member_code = memberVO.getMember_code();
			
			//테스트용
			System.out.println("사용자 주소 : " + memberVO.getMember_addr1());
			
			//likeyVO, basket_VO에 세션member_code 부여
			likeyVO.setMember_code(member_code);
			basketVO.setMember_code(member_code);
			orderVO.setMember_code(member_code);
			
			//리스트 생성(찜리스트, 주문리스트, 장바구니 리스트)
			List<LikeyVO> likey_list_mon = null;
			List<orderVO> order_list_mon = null;
			
			List<LikeyVO> likey_list = null;
			List<TestBean> basket_list = null;
			List<orderVO> order_list = null;
			
			//총 주문금액을 담을 변수
			int totalOrderPrice = 0;
			
			logger.info("likey_list_mon ==> " + likey_list_mon);
			
			//서비스에 전달
			likey_list 	 	= mypageService.likeyList(likeyVO);
			basket_list 	= mypageService.basketList(basketVO);
			order_list 		= mypageService.orderList(orderVO);
			
			order_list_mon  = mypageService.orderListMonth(orderVO);
			likey_list_mon 	= mypageService.likeyListMonth(member_code);
			
			totalOrderPrice = mypageService.totalOrderPrice(orderVO); //nullPointerException
			
			//화면으로 전달
			model.addAttribute("likeyListMon", likey_list_mon);
			model.addAttribute("orderListMon", order_list_mon);
			
			//총 갯수 
			model.addAttribute("basket_list_size", basket_list.size());
			model.addAttribute("likey_list_size", likey_list.size());
			model.addAttribute("order_list_size", order_list.size());
			
			//한 달 기준 갯수 (테스트용)
			//model.addAttribute("likeyListMon_size", likey_list_mon.size());
			//model.addAttribute("orderListMon_size", order_list_mon.size());
				
			//총 주문금액
			model.addAttribute("totalOrderPrice", totalOrderPrice);
			
			logger.info("Mypage 가 컨트롤러에 의해 get 실행");
		}
	}
	
	//마이페이지 메인 post
	/*@RequestMapping(value="/mypage", method= RequestMethod.POST)
	public String postMypageMain(Model model, HttpServletRequest req) throws Exception {
		
		//로그인세션가져오기		  
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("member");	
		model.addAttribute("member", memberVO);
		
		//리스트 생성(찜리스트, 주문리스트, 장바구니 리스트, 리뷰)
		List<LikeyVO> likey_list_mon = null;
		List<LikeyVO> likey_list = null;
		List<BasketVO> basket_list = null;
		
		//서비스에 전달
		likey_list_mon 	= mypageService.likeyListMonth("likey"); //최근 한 달간 찜목록
		likey_list 		= mypageService.likeyList("likey");
		basket_list 	= mypageService.basketList("basket");		//장바구니 목록
		
		
		//화면으로 전달
		model.addAttribute("likeyListMon", likey_list_mon);
		model.addAttribute("basket_list_size", basket_list.size());
		model.addAttribute("likey_list_size", likey_list.size());
		
		//System.out.println(likey_list.size());
		
		
		
		
		logger.info("Mypage 가 컨트롤러에 의해 post 실행");
		return "redirect:/mypage/main";
	}*/


	
}
