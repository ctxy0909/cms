<@ms.html5>
	<@ms.nav title="站点信息" back=true>
		<@ms.saveButton  postForm="websiteForm"/>
	</@ms.nav>
	<@ms.panel>
			<@ms.form isvalidation=true name="websiteForm" action="${base}${baseManager}/website/${autoCURD}.do" redirect="${base}${baseManager}/website/index.do">
				<@ms.hidden name="websiteMobileStyle" value="${website.websiteMobileStyle?default('')}"/>
				<@ms.hidden name="websiteId" value="${website.websiteId}"/>
				<@ms.text name="websiteName" label="网站标题" width="500" value="${website.websiteName?default('')}" maxlength="60"  title="网站标题" placeholder="请输入网站标题" validation={"maxlength":"50","required":"true", "data-bv-notempty-message":"必填项目","data-bv-stringlength-message":"网站标题在50个字符以内!"}/>
				<@ms.formRow label="网站状态" help="可以控制网站的运行状态，如果网站已停止，预览用户会看网站暂停的相关信息。">
					<@ms.switchButton name="websiteState" off={"text":"已停止","value":1} on={"text":"运行中","value":0} value="${website.websiteState?default(0)}"/>
            	</@ms.formRow>		
				<@ms.textarea name="websiteUrl" width="400" label="域 名"  rows="4" value="${website.websiteUrl?default('')}" 
							  placeholder="使用回车换行可以输入多个域名地址，必须要加http://" 
				              validation={"minlength":"10","maxlength":"300","required":"true","data-bv-notempty-message":"必填项目", "data-bv-stringlength-message":"长度在10到300个字符以内!"} 
				              help="多个域名回车换行显示，必须以http[s]://打头，<br/>例如：http://www.a.com <br/> http://a.com"/>
				<@ms.textarea name="websiteKeyword" width="700" maxlength="500" label="关键字"  value="${website.websiteKeyword?default('')}" rows="4"  placeholder="请输入关键字" />
				<@ms.textarea name="websiteDescription" width="700" maxlength="500" label="描述"  value="${website.websiteDescription?default('')}" rows="4"  placeholder="请输入站点描述"/>
				<@ms.textarea name="websiteCopyright" width="700" maxlength="500" label="版权信息"  value="${website.websiteCopyright?default('')}" rows="4"  placeholder="请输入版权信息"/>
				<@ms.checkbox name="websiteMobileState" label="移动站状态" list=[{"key":"0","value":"启用"}] listKey="key" valueList=["${website.websiteMobileState}"] listValue="value" 
				help="启用后手机用户访问网站会显示手机版网页，前提是网站必需提供移动端皮肤，相关教程:<a href='http://ms.ming-soft.com/mbbs/13086/detail.do'>铭飞移动端开发教程</a>"/>
					<!--超级管理员对站点的管理-->
				<@ms.date name="websitePayDate" width="150" label="每年续费日期" size="6" value="${(website.websitePayDate?string('yyyy-MM-dd'))!''}" single=true  placeholder="点击选择时间段" validation={"required":"true", "data-bv-notempty-message":"必选项目"}/> 
				<@ms.textarea name="websitePay"  width="700" label="续费清单"  rows="4" value="${website.websitePay?default('')}"  placeholder="请输入应用费用清单"  validation={"maxlength":"300","data-bv-stringlength-message":"网站标题在50个字符以内!"}  help="可以记录空间、域名、维护等费用明细" helpDirection="top"/> 
				<@ms.text name="websiteId"style="display:none" readonly="readonly" value="${website.websiteId?c?default(0)}"/>
			</@ms.form>	
	</@ms.panel>
</@ms.html5>