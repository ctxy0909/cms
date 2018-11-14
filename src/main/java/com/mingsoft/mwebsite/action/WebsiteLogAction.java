package com.mingsoft.mwebsite.action;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.IManagerBiz;
import com.mingsoft.basic.constant.Const;
import com.mingsoft.basic.constant.ModelCode;
import com.mingsoft.basic.constant.e.CookieConstEnum;
import com.mingsoft.basic.constant.e.SessionConstEnum;
import com.mingsoft.basic.entity.ManagerEntity;
import com.mingsoft.mwebsite.biz.IWebsiteBiz;
import com.mingsoft.mwebsite.biz.IWebsiteLogBiz;
import com.mingsoft.mwebsite.entity.WebsiteEntity;
import com.mingsoft.parser.IParserRegexConstant;
import com.mingsoft.util.PageUtil;
import com.mingsoft.util.StringUtil;

/**
 * 网站基本信息控制层
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2014-07-14<br/>
 * 历史修订：<br/>
 */
@Controller
@RequestMapping("/${managerPath}/website/log")
public class WebsiteLogAction extends BaseAction{
	
	@Autowired
	private IWebsiteLogBiz websiteLogBiz;
	
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request,ModelMap mode,HttpServletResponse response){
		return view("/mwebsite/log/website_log_list");
	}
	
	
}
