/**
 * 
 */
package com.mingsoft.mwebsite.constant;

import com.mingsoft.base.constant.e.BaseEnum;

/**
 * 
 * 
 * 
 * <p>
 * <b>铭飞科技</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * @author killfen
 * 
 * <p>
 * Comments:
 * </p>
 * 
 * <p>
 * Create Date:2017-3-27
 * </p>
 * 
 * <p>
 * Modification history:
 * </p>
 */ 
public  enum ModelCode implements BaseEnum{
	
	/**
	 * 应用管理
	 */
	APP_MANAGEMENT("00000002"),
	
	/**
	 * 模块管理
	 */
	MODULE_MANAGEMENT("00000001")
	;

	ModelCode(String code) {
		this.code = code;
	}

	private String code;

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return code;
	}

	public int toInt() {
		// TODO Auto-generated method stub
		return Integer.parseInt(code);
	}

}
