<@ms.html5>
	 <@ms.nav title="微信带参数的二维码编辑" back=true>
    	<@ms.saveButton  onclick="save()"/>
    </@ms.nav>
    <@ms.panel>
    	<@ms.form name="qrcodeForm" isvalidation=true>
    		<@ms.hidden name="qrcodeId" value="${qrcodeEntity.qrcodeId?default('')}"/>
    		<@ms.text label="二维码名称" name="qrcodeTitle" value="${qrcodeEntity.qrcodeTitle?default('')}"  width="240px;" placeholder="请输入二维码名称" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"二维码名称长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    		<@ms.number label="二维码的场景值" name="qrcodeValue" value="${qrcodeEntity.qrcodeValue?default('')}" width="240px;" placeholder="请输入二维码的场景值" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"二维码的场景值长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    		<@ms.select label="二维码类型" list=os name="qrcodeType" value="" listKey="key" listValue="Value" width="240px;"/>
    		<@ms.number label="二维码所属应用ID" name="qrcodeAppId" value="${qrcodeEntity.qrcodeAppId?default('')}" width="240px;" placeholder="请输入二维码所属应用ID" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"二维码所属应用ID长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    		<@ms.text label="二维码描述" name="qrcodeDescription" value="${qrcodeEntity.qrcodeDescription?default('')}"  width="240px;" placeholder="请输入二维码描述" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"二维码描述长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    		<@ms.text label="二维码生成时间" name="qrcodeTime" value="${qrcodeEntity.qrcodeTime?string('yyyy-MM-dd HH:mm:ss')}"  width="240px;" placeholder="请输入二维码生成时间" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"二维码生成时间长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    		<@ms.number label="二维码到期时间" name="qrcodeExpireTime" value="${qrcodeEntity.qrcodeExpireTime?default('')}" width="240px;" placeholder="请输入二维码到期时间" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"二维码到期时间，最大为1800，以秒为单位(只有临时二维码才有该值)长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    		<@ms.number label="微信编号" name="qrcodeWeixinId" value="${qrcodeEntity.qrcodeWeixinId?default('')}" width="240px;" placeholder="请输入微信编号" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"微信编号长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    	</@ms.form>
    </@ms.panel>
</@ms.html5>
<script>
	var url = "${managerPath}/weixin/qrcode/save.do";
	if($("input[name = 'qrcodeId']").val() > 0){
		url = "${managerPath}/weixin/qrcode/update.do";
		$(".btn-success").text("更新");
	}
	//编辑按钮onclick
	function save() {
		$("#qrcodeForm").data("bootstrapValidator").validate();
			var isValid = $("#qrcodeForm").data("bootstrapValidator").isValid();
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
			data:$("form[name = 'qrcodeForm']").serialize(),
			url:url,
			success: function(status) {
				if(status.result == true) { 
					<@ms.notify msg="保存或更新成功" type= "success" />
					location.href = "${managerPath}/weixin/qrcode/index.do";
				}
				else{
					<@ms.notify msg= "保存或更新失败！" type= "fail" />
					location.href= "${managerPath}/weixin/qrcode/index.do";
				}
			}
		})
	}	
</script>
