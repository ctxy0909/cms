<@ms.html5>
	 <@ms.nav title="微信网页2.0授权表编辑" back=true>
    	<@ms.saveButton  onclick="save()"/>
    </@ms.nav>
    <@ms.panel>
    	<@ms.form name="oauthForm" isvalidation=true>
    		<@ms.hidden name="oauthId" value="${oauthEntity.oauthId?default('')}"/>
    		<@ms.number label="微信编号" name="oauthWeixinId" value="${oauthEntity.oauthWeixinId?default('')}" width="240px;" placeholder="请输入微信编号" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"微信编号长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    		<@ms.number label="关联微信应用ID" name="oauthAppId" value="${oauthEntity.oauthAppId?default('')}" width="240px;" placeholder="请输入关联微信应用ID" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"关联微信应用ID长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    		<@ms.text label="授权成功重定向地址" name="oauthSuccessUrl" value="${oauthEntity.oauthSuccessUrl?default('')}"  width="240px;" placeholder="请输入授权成功重定向地址" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"授权成功重定向地址长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    		<@ms.text label="授权失败者或错误重定向地址" name="oauthErrorUrl" value="${oauthEntity.oauthErrorUrl?default('')}"  width="240px;" placeholder="请输入授权失败者或错误重定向地址" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"授权失败者或错误重定向地址长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    		<@ms.text label="授权描述" name="oauthDescription" value="${oauthEntity.oauthDescription?default('')}"  width="240px;" placeholder="请输入授权描述" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"授权描述长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    		<@ms.select label="授权类型" list=os name="oauthType" value="" listKey="key" listValue="Value" width="240px;"/>
    	</@ms.form>
    </@ms.panel>
</@ms.html5>
<script>
	var url = "${managerPath}/weixin/oauth/save.do";
	if($("input[name = 'oauthId']").val() > 0){
		url = "${managerPath}/weixin/oauth/update.do";
		$(".btn-success").text("更新");
	}
	//编辑按钮onclick
	function save() {
		$("#oauthForm").data("bootstrapValidator").validate();
			var isValid = $("#oauthForm").data("bootstrapValidator").isValid();
			if(!isValid) {
				<@ms.notify msg= "数据提交失败，请检查数据格式！" type= "warning" />
				return;
		}
		var btnWord =$(".btn-success").text();
		$(".btn-success").text(btnWord+"中...");
		$(".btn-success").prop("disabled",true);
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("form[name = 'oauthForm']").serialize(),
			url:url,
			success: function(status) {
				if(status.result == true) { 
					<@ms.notify msg="保存或更新成功" type= "success" />
					location.href = "${managerPath}/weixin/oauth/index.do";
				}
				else{
					<@ms.notify msg= "保存或更新失败！" type= "fail" />
					location.href= "${managerPath}/weixin/oauth/index.do";
				}
			}
		})
	}	
</script>
