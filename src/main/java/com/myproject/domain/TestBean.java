package com.myproject.domain;


import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class TestBean {
	
	private MemberVO member;
	private LikeyVO likey;
	private BasketVO basket;
	private orderVO orders;
	private productVO products;

}
