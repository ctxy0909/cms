package com.mingsoft.mwebsite.biz.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.biz.impl.BasicBizImpl;
import com.mingsoft.basic.dao.IManagerDao;
import com.mingsoft.basic.dao.IModelDao;
import com.mingsoft.basic.dao.IRoleDao;
import com.mingsoft.basic.dao.IRoleModelDao;
import com.mingsoft.basic.entity.ManagerEntity;
import com.mingsoft.basic.entity.ModelEntity;
import com.mingsoft.basic.entity.RoleEntity;
import com.mingsoft.basic.entity.RoleModelEntity;
import com.mingsoft.mwebsite.biz.IWebsiteBiz;
import com.mingsoft.mwebsite.dao.IWebsiteDao;
import com.mingsoft.mwebsite.entity.WebsiteEntity;

/**
 * 网站基本信息业务层实现类
 * 
 * @author 史爱华
 * @version 版本号：100-000-000<br/>
 *          创建日期：2012-03-15<br/>
 *          历史修订：<br/>
 */
@Service("websiteBiz")
public class WebsiteBizImpl extends BasicBizImpl implements IWebsiteBiz {

	/**
	 * 声明IAppDao持久化层
	 */
	@Autowired
	private IWebsiteDao websiteDao;

	@Autowired
	private IManagerDao managerDao;

	@Autowired
	private IRoleDao roleDao;

	@Autowired
	private IRoleModelDao roleModelDao;

	@Autowired
	private IModelDao modelDao;

	@Override
	public WebsiteEntity getByManagerId(int managerId) {
		// TODO Auto-generated method stub
		return (WebsiteEntity) websiteDao.getByManagerId(managerId);
	}

	/**
	 * 获取应用持久化层
	 * 
	 * @return appDao 返回应用持久化层
	 */
	@Override
	protected IBaseDao getDao() {
		// TODO Auto-generated method stub
		return websiteDao;
	}

	@Override
	public int countByUrl(String websiteUrl) {
		// TODO Auto-generated method stub
		return websiteDao.countByUrl(websiteUrl);
	}

	@Override
	public WebsiteEntity getByUrl(String url) {
		// TODO Auto-generated method stub
		return (WebsiteEntity) websiteDao.getByUrl(url);
	}

	@Override
	public int saveRole(RoleEntity role) {
		// TODO Auto-generated method stub
		return this.websiteDao.saveRole(role);
	}

	@Override
	public void save(WebsiteEntity website, ManagerEntity manager, int[] models) {
		// TODO Auto-generated method stub
		managerDao.saveEntity(manager);
		website.setWebsiteManagerId(manager.getManagerId());
		websiteDao.updateEntity(website);
		RoleEntity role = new RoleEntity();
		role.setRoleName(manager.getManagerNickName());
		role.setRoleManagerId(manager.getManagerId());
		role.setAppId(website.getWebsiteId());
		roleDao.saveEntity(role);
		manager.setManagerRoleID(role.getRoleId());
		managerDao.updateEntity(manager);
		if (models != null) {
			@SuppressWarnings("rawtypes")
			List list = new ArrayList();
			for (int id : models) {
				RoleModelEntity roleModel = new RoleModelEntity();
				roleModel.setModelId(id);
				roleModel.setRoleId(role.getRoleId());
				list.add(roleModel);
			}
			roleModelDao.saveBatch(list);
		}
	}

	@Override
	public void update(ManagerEntity manager, int[] models) {
		// TODO Auto-generated method stub
		managerDao.updateEntity(manager);
		roleModelDao.deleteByRoleId(manager.getManagerRoleID());
		if (models != null) {
			List list = new ArrayList();
			for (int id : models) {
				RoleModelEntity roleModel = new RoleModelEntity();
				roleModel.setModelId(id);
				roleModel.setRoleId(manager.getManagerRoleID());
				list.add(roleModel);
			}
			roleModelDao.saveBatch(list);
		}

	}

}
