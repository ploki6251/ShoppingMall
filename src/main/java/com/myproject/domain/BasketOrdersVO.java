package com.myproject.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BasketOrdersVO {
	
	private int product_code ;
	private int order_count ;
	private int total_price ;
}