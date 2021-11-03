package com.myproject.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.myproject.domain.BasketOrdersVO;
import com.myproject.domain.BasketVO;
import com.myproject.domain.MemberVO;
import com.myproject.domain.TestBean;
import com.myproject.domain.orderVO;
import com.myproject.domain.productVO;
import com.myproject.service.MemberService;
import com.myproject.service.orderService;
import com.myproject.service.productService;

@Controller
@RequestMapping(value="/order", produces="text/plain;charset=UTF-8")
public class orderController {

	// logger사용
	private static final Logger logger = LoggerFactory.getLogger(orderController.class);
	
	@Inject
	productService productService;
	
	@Inject
	orderService orderService;
	
	@Inject
	MemberService memberService;
	
	// 주문
	@RequestMapping(value = "/order", method = RequestMethod.GET)
	public void order(Model model, HttpServletRequest req, @RequestParam("product_code") int product_code) throws Exception {	
		
		//로그인세션가져오기		  
		HttpSession session = req.getSession();			
		MemberVO memberVO = (MemberVO) session.getAttribute("member");	
		model.addAttribute("member", memberVO);
		
		//보기
		productVO View = null;
		View = productService.productView(product_code);
		model.addAttribute("productView", View);
		
	}
	
	// 결제완료
	@RequestMapping(value = "/orderComplete", method = {RequestMethod.GET, RequestMethod.POST})
	public void orderComplete(Model model, HttpServletRequest req, orderVO vo) throws Exception {	
		
		logger.info("orderController orderComplete()일한다.");
		
		//로그인세션가져오기		  
		HttpSession session = req.getSession();			
		MemberVO memberVO = (MemberVO) session.getAttribute("member");	
		model.addAttribute("member", memberVO);
		
		orderService.orderComplete(vo);
		orderService.insertBo_refByOrderVO(vo);
		}
	
	
	//basketorder 추가(이경태)
		//장바구니 페이지에서 넘어가는 결제페이지
		@RequestMapping(value="/basketorder", method=RequestMethod.GET)
		public void basketOrder(@RequestParam("basketListbno[]") List<String> billBno, Model model, HttpServletRequest req, BasketVO basketVO) throws Exception {
			
			//로그인세션가져오기		  
			HttpSession session = req.getSession();
			MemberVO memberVO = (MemberVO) session.getAttribute("member");
			model.addAttribute("member", memberVO);
			
			//결과를 저장할 result 값
			//for문에 쓸 basketBno 변수
			int basketBno = 0;
			//결과 컬럼을 저장할 리스트
			List<TestBean> baksetBnoList = new ArrayList<TestBean>();
			
			int member_code = memberVO.getMember_code();
			
			//System.out.println("billBno : " + billBno);
			
			if(memberVO != null) {
				basketVO.setMember_code(member_code);
				
				for(String i : billBno) { //String 형 List인 `billBno`의 요소를 차례로 방문
					basketBno = Integer.parseInt(i);
					basketVO.setBno(basketBno);
					
					baksetBnoList.add(orderService.basketOrder(basketVO));
				}
			}
			model.addAttribute("basketbnoList", baksetBnoList);
		}
		
		//basketorderComplete 추가 (이경태)
		//장바구니 결제창 결제 성공 controller
		@RequestMapping(value="/boComplete", method=RequestMethod.GET)
		public void boComplete(@RequestParam("product_code[]") List<Integer> pc,
							   @RequestParam("order_count[]") List<Integer> oc, 
							   @RequestParam("total_price[]") List<Integer> tp,
							   HttpServletRequest req, orderVO orderVO, Model model) 			throws Exception{
			
			//로그인세션가져오기		  
			HttpSession session = req.getSession();			
			MemberVO memberVO = (MemberVO) session.getAttribute("member");
			model.addAttribute("member", memberVO);
			
			//배열 첨자로 사용될 변수
			int cnt1 = 0;
			int cnt2 = 0;
			
			//orders 테이블에 저장될 값 별도 지정
			int total_price = 0;
			
			
			//BasketOrdersVO 객체배열 생성
			BasketOrdersVO[] bovo = new BasketOrdersVO[pc.size()];
		
			//테스트용
			//System.out.println("pc : " + pc);
			//System.out.println("oc : " + oc);
			//System.out.println("tp : " + tp);
			
			//NullPointerException 방지
			//각 배열을 new 연산자로 초기화 해준다.
			for(int m = 0 ; m < bovo.length ; m++) {
				bovo[m] = new BasketOrdersVO();
			}
			
			//product_code 리스트(pc)의 값을 객체변수에 저장
			for(int i : pc) {
				//bovo[cnt1] = new BasketOrdersVO();
				bovo[cnt1].setProduct_code(i);
				cnt1++;
			}
			
			//order_count 리스트(oc)의 값을 객체변수에 저장
			for(int j : oc) {
				//bovo[cnt2] = new BasketOrdersVO();
				bovo[cnt2].setOrder_count(j);
				cnt2++;
			}
			
			//total_price 리스트(tp)의 값을 객체변수에 저장
			for(int k : tp) {
				total_price += k ;
			}
			
			
		
			
			/*//테스트용
			for(int n = 0 ; n < bovo.length ; n++) {
				System.out.println("[" + n +  "] = " + bovo[n]);
			}
			*/
			
			//리스트 생성(할 필요 없음)
			//List<BasketOrdersVO> list = new ArrayList<BasketOrdersVO>();
			
			/*(할 필요 없음)
			for(int l = 0 ; l < bovo.length ; l++) {
				list.add(bovo[l]);
			}
			*/
			
			//테스트용
			// System.out.println("최종 리스트 : " + list);
			
			orderVO.setTotal_price(total_price);
			//주문정보 insert
			orderService.orderComplete(orderVO);
			
			//for문을 이용한 주문상품정보 insert (결국 주문할 상품갯수 만큼 insert 시행)
			for(int o = 0 ; o < bovo.length ; o++) {
				orderService.insertBo_ref(bovo[o]);
			}
			
			/*(필요없음)
			for(BasketOrdersVO baorVO : list) {
				//System.out.println("테스트 값 : " + baorVO);
				orderService.insertBo_ref(baorVO);
			}
			*/
		}
	
	
	//주소찾기
	@RequestMapping(value = "/jusoPopup", method = {RequestMethod.GET, RequestMethod.POST})
	public void jusoPopup() throws Exception {
		
	}
	
	// 약관동의
	@RequestMapping(value = "/buyCheck", method = RequestMethod.GET)
	public void buyCheck() throws Exception {
			
	}
	
	// 관리자 주문조회 (회원 주문 확인)
	@RequestMapping(value = "/orderList", method = RequestMethod.GET)
	public String orderList(Model model) throws Exception {
		logger.info("get orderList");
		List<orderVO> orderList;
		orderList = orderService.orderList();
		model.addAttribute("orderList",orderList);
		
		return "/order/orderList";
		
	}
	
	// 관리자 주문조회 (비회원 주문 확인)
	@RequestMapping(value = "/nonOrderList", method = RequestMethod.GET)
	public String nonOrderList(Model model) throws Exception {
		logger.info("get nonOrderList");
		List<orderVO> nonOrderList;
		nonOrderList = orderService.nonOrderList();
		model.addAttribute("nonOrderList",nonOrderList);
		
		return "/order/nonOrderList";
	}
	
	// 회원 주문 조회 (특정 회원) 
	@RequestMapping(value = "/MemberOrdList", method = RequestMethod.GET)
	public String MemberOrdList(HttpServletRequest req, Model model) throws Exception {
			logger.info("get MemberOrdList");
			HttpSession session = req.getSession();
	
			MemberVO member = (MemberVO)session.getAttribute("member");
			int member_code = member.getMember_code();
			System.out.println(member_code);
			
			orderVO orderVO = new orderVO();
			orderVO.setMember_code(member_code);
			logger.info(orderVO.toString());
			List<orderVO> MemberOrdList;
			MemberOrdList = orderService.MemberOrdList(orderVO);
			
			//logger.info("aaaa = " + MemberOrdList.get(0).getDelivery_name());
			model.addAttribute("MemberOrdList", MemberOrdList);		
			
			return "/order/MemberOrdList";
	}
	
	
	// 주문 상세보기
	@RequestMapping(value = "/orderView", method = RequestMethod.GET)
	public String orderView(HttpServletRequest req, 
							@RequestParam("order_code") int order_code,
							Model model) throws Exception {
		logger.info("get orderView");
		
		HttpSession session = req.getSession();
		MemberVO member = (MemberVO)session.getAttribute("member");
		model.addAttribute("member", member);
		
		System.out.println(member);	
		
		List<orderVO> orderView;
		orderView = orderService.orderView(order_code);
		model.addAttribute("orderView", orderView);
		
		return "/order/orderView";

	}
	
	// 주문 상세 목록 - 배송 상태 변경
	@RequestMapping(value = "/orderView", method = RequestMethod.POST)
	public String delivery(orderVO vo) throws Exception {
		logger.info("update status =>" + vo);
		
		orderService.delivery(vo);
		
		return "redirect:/order/orderView?order_code=" + vo.getOrder_code();
			
	}
	
	
	// 비회원 로그인 확인
	@RequestMapping(value = "/nonlogin", method = RequestMethod.GET)
	public String nonlogin(orderVO vo, HttpServletRequest req) throws Exception {
		logger.info("nonlogin...");
		
		HttpSession session = req.getSession();
		
		orderVO nonlogin = orderService.nonlogin(vo);
		
		// 주문번호 확인
		if(nonlogin == null) {
			System.out.print("해당하는 주문번호가 없습니다.");
			return "/order/nonlogin";
		} else {
			System.out.print("주문번호 확인 완료: orderVO.getOrder_code()" + vo.getOrder_code());
			return "redirect:/order/nonMemberOrdList/" + vo.getOrder_code();
		}
	}
	
	// 비회원 주문 확인
	@RequestMapping(value = "/nonMemberOrdList/{order_code}", method = RequestMethod.GET)
	public String nonMemberOrdList(@PathVariable int order_code, Model model) throws Exception {
		logger.info("get nonMemberOrdList" + order_code);
		
		List<orderVO> nonMemberOrdList;
		nonMemberOrdList = orderService.nonMemberOrdList(order_code);
		model.addAttribute("nonMemberOrdList", nonMemberOrdList);
		
		System.out.print("비회원 주문 목록: orderVO.getOrder_code()" );
		
		return "/order/nonMemberOrdList";
	}
	
}
