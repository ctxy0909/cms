package com.mingsoft.mwebsite.entity;

import java.util.Date;

import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.mwebsite.constant.e.WebsiteLogEnum;

/**
 * 
 * 铭飞MS平台-日志基础
 * @author 铭飞开发团队
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2016年3月4日<br/>
 * 历史修订：<br/>
 */
public class WebsiteLogEntity extends BaseEntity {

	private int logId;

	private int logAppId;

	private Date logDatetime;

	private String logIp;

	private int logIsMobile;

	public int getLogId() {
		return logId;
	}

	public void setLogId(int logId) {
		this.logId = logId;
	}

	public int getLogAppId() {
		return logAppId;
	}

	public void setLogAppId(int logAppId) {
		this.logAppId = logAppId;
	}

	public Date getLogDatetime() {
		return logDatetime;
	}

	public void setLogDatetime(Date logDatetime) {
		this.logDatetime = logDatetime;
	}

	public String getLogIp() {
		return logIp;
	}

	public void setLogIp(String logIp) {
		this.logIp = logIp;
	}

	public int getLogIsMobile() {
		return logIsMobile;
	}

	public void setLogIsMobile(int logIsMobile) {
		this.logIsMobile = logIsMobile;
	}
	
	public void setLogIsMobile(WebsiteLogEnum logIsMobile) {
		this.logIsMobile = logIsMobile.toInt();
	}
	
}
