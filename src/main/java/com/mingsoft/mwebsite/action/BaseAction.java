package com.mingsoft.mwebsite.action;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.BeanUtils;

import com.mingsoft.basic.constant.Const;
import com.mingsoft.basic.entity.ManagerSessionEntity;
import com.mingsoft.mwebsite.biz.IWebsiteBiz;
import com.mingsoft.mwebsite.entity.WebsiteEntity;


/**
 * 站点基础控制类
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2015-11-25<br/>
 * 历史修订：<br/>
 */
public class BaseAction extends com.mingsoft.basic.action.BaseAction{
	
	/**
	 * 
	 * 根据用户请求获取网站实体
	 * @param request HttpServletRequest
	 * @return  网站实体
	 */
	protected WebsiteEntity getWebsite(HttpServletRequest request) {
		WebsiteEntity website = new WebsiteEntity();
		
		IWebsiteBiz websiteBiz = (IWebsiteBiz) getBean(request.getServletContext(), "webisteBiz");
		// 根据用户所请求的域名地址获取网站实体
		WebsiteEntity curWebsite = websiteBiz.getByUrl(this.getDomain(request));
		if(curWebsite!=null){
			BeanUtils.copyProperties(curWebsite, website);
			return website;
		}
		return null;
		
	}
	
	/**
	 * 判断当前管理员是否是系统平台管理员
	 * @param request 请求对象
	 * @return true:是系统平台管理员，false:不是系统平台管理员
	 */
	protected boolean isSystemManager(HttpServletRequest request) {
		ManagerSessionEntity manager = (ManagerSessionEntity) getManagerBySession(request);
		if (manager.getManagerRoleID() == Const.DEFAULT_SYSTEM_MANGER_ROLE_ID) {
			return true;
		} else {
			return false;
		}
	}	
}
