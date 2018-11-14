package com.mingsoft.mwebsite.constant;

import java.util.ResourceBundle;
import org.springframework.context.ApplicationContext;

/**
 * 基础枚举类
 * 
 * @author 王天培QQ:78750478
 * @version 版本号：100-000-000<br/>
 *          创建日期：2012-03-15<br/>
 *          历史修订：<br/>
 */
public final class Const {

	/**
	 * spring资源文件加载上下文对象
	 */
	public static ApplicationContext CONTEXT;

	/**
	 * action层对应的国际化资源文件
	 */
	public final static ResourceBundle RESOURCES = ResourceBundle
			.getBundle("com.mingsoft.mwebsite.resources.resources");

}
