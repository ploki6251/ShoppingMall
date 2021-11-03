package com.myproject.controller;

import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myproject.domain.MemberVO;
import com.myproject.service.MemberService;

import lombok.extern.java.Log;

@Controller
@Log
@RequestMapping("/member") // 공통적인 url 매핑
public class MemberController {

	// 로깅을 위한 변수
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	//-------------------------------------------------------------------------------------------------
	@Inject
	MemberService memberService;
		
	//회원가입 페이지
	@RequestMapping(value="/join", method=RequestMethod.GET) 
	public String join() throws Exception { 
		System.out.println("회원가입페이지");
		logger.info("join get.."); 
		return "/member/join"; //
	}
	
	//로그인 페이지	
	@RequestMapping(value="/login", method=RequestMethod.GET) 
	public String login() throws Exception { 
		 logger.info("login get.."); 
		 return "/member/login";
	}
	   
	//로그인
	@ResponseBody
	@RequestMapping(value="/login", method=RequestMethod.POST) 
	public String login(MemberVO memberVO, HttpServletRequest req, RedirectAttributes rttr) throws Exception { 
		logger.info("login post.."); 

		HttpSession session = req.getSession();
		  
		MemberVO login = memberService.login(memberVO);
		logger.info("MemberController Return Value " + login);

		String result = "N";
		  
	  	//해당하는 회원정보가 없으면
		if(login == null) {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
	  	}
		else {
			// 로그인이 정상이라면 세션을 발급한다.
	  		System.out.println("로그인 완료: memberVO.getMember_id()" + "-" + memberVO.getMember_id());  
			session.setAttribute("member", login);
			
			int diffNum = memberService.pwChangeCheck(memberVO.getMember_id());
			
			if(90 <= diffNum){
				result = "Y2";
			}
			else {
				result = "Y1";
			}
			
		}
		 
		return result;
	}
	   
	//아이디 중복검사
	@ResponseBody
	@RequestMapping(value="/idCheck", method=RequestMethod.POST)
	public int idCheck(MemberVO memberVO) throws Exception{
		System.out.println("idCheck.....memberController");
		log.info("memberController idCheck.....");
		  
		int result = memberService.idCheck(memberVO);
		  
		log.info("MemberController idCheck Return Value [" + result + "]");
				  
		return result;
	}
	  
	//이메일 중복검사
	@ResponseBody
	@RequestMapping(value="/emailCheck", method=RequestMethod.POST)
	public boolean emailCheck(String member_email) throws Exception{
		  
		boolean result = memberService.emailCheck(member_email);
		log.info("emailCheck"+result);
		  		  
		return result;
	}
	
	
	//회원가입 post
	//@RequestMapping(value="/join", method=RequestMethod.POST)
	@RequestMapping(value="/joinForm", method=RequestMethod.POST)
	public String postJoin(MemberVO memberVO) throws Exception{
		log.info("post 회원가입");

			 
		//아이디가 있는지 검사
		int result = memberService.idCheck(memberVO);
		  
		if(result == 1) {
			return "redirect:/member/join";
		}
		else if(result == 0) {
			  
			String mobile = memberVO.getMobile1() + memberVO.getMobile2() + memberVO.getMobile3();
			memberVO.setMobile(mobile);
			  
			String member_tel = memberVO.getMember_tel1() + memberVO.getMember_tel2() + memberVO.getMember_tel3();
			memberVO.setMember_tel(member_tel);
			  
			memberService.join(memberVO);
			 
		}
		  
		return "redirect:/member/login";
	}

	//우편번호
	@RequestMapping(value="address", method=RequestMethod.GET)
	public String adress() throws Exception{
		return "/member/join";
	}
	  
		
	//회원정보 수정	페이지
	@RequestMapping(value="/memberUpdate", method=RequestMethod.GET) 
	public String memberUpdate() throws Exception { 
		 logger.info("memberUpdate get.."); 
		 return "/member/memberUpdate";
	}
	
	//회원정보 수정 post	
	@RequestMapping(value="/updateForm", method=RequestMethod.POST)
	public String postUpdate(MemberVO memberVO) throws Exception{
		log.info("post 회원가입");

		memberService.memberUpdate(memberVO);
				  
		return "redirect:/";
	}
	
	//비밀번호 변경 팝업창
	@RequestMapping(value="pwChange", method=RequestMethod.GET)
	public String pwchange() throws Exception{
		logger.info("pwChange get....");
		return "/member/pwChange";
	}
	
	//비밀번호 변경 post
	@ResponseBody
	@RequestMapping(value="pwChangeForm", method=RequestMethod.POST)
	public String postPwChange(MemberVO memberVO) throws Exception{
		log.info("post 비밀번호 변경");
		
		String result = "N";
		
		//비밀번호 체크
		int Num =  memberService.pwCheck(memberVO);
		if(Num == 0) {
			result = "N";
		}else if(Num ==1) {
			memberService.pwChange(memberVO);	
			result = "Y";
		}		
		return result;
	}
	
	//탈퇴 페이지
	@RequestMapping(value="memberDelete", method=RequestMethod.GET)
	public String memberDelete() throws Exception{
		logger.info("pwChange get....");
		return "/member/memberDelete";
	}
	
	//회원 탈퇴(삭제)
	@ResponseBody
	@RequestMapping(value="memberDelForm", method=RequestMethod.POST)
	public String memberDelete(MemberVO memberVO) throws Exception{		
		
		String result = "N";
		
		memberService.memberDelete(memberVO);
		
		int check = memberService.idCheck(memberVO);
		  
		if(check == 1) {
			result = "N"; // 아이디가 아직 있음
		}
		else if(check == 0) {			
			result  = "Y"; // 아이디 없음
		}	
		return result;
	}
	
	
	
   
	//로그아웃
		@RequestMapping(value="/logout", method=RequestMethod.GET) 
		public String headerlogout(HttpServletRequest req) throws Exception { 
			logger.info("맴버 컨트롤러 로그아웃");
			HttpSession session = req.getSession();
			session.invalidate(); //세션죽이기
			System.out.println("로그아웃");
			//홈으로 가는 코드 삽입
			
			return "redirect:/";
			
			
		}
	
}
