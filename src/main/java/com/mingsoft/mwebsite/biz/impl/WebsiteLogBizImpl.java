package com.mingsoft.mwebsite.biz.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mingsoft.base.biz.impl.BaseBizImpl;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.mwebsite.biz.IWebsiteLogBiz;
import com.mingsoft.mwebsite.dao.IWebsiteLogDao;

@Service("logBiz")
public class WebsiteLogBizImpl extends BaseBizImpl implements IWebsiteLogBiz {

	/**
	 * 声明IAppDao持久化层
	 */
	@Autowired
	private IWebsiteLogDao logDao;

	@Override
	protected IBaseDao getDao() {
		return logDao;
	}


}
