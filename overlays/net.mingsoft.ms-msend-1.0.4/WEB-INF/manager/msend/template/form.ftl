<@ms.html5>
	 <@ms.nav title="添加消息模板" back=true>
    	<@ms.saveButton  onclick="save()"/>
    </@ms.nav>
    <@ms.panel>
    	<@ms.form name="templateForm" isvalidation=true>
    		<@ms.hidden name="templateId" value="${templateEntity.templateId?default('')}"/>
    			<@ms.text label="标题" name="templateTitle" value="${templateEntity.templateTitle?default('')}"  width="240px;" placeholder="请输入标题" validation={"required":"false","maxlength":"50","data-bv-stringlength-message":"标题长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    			<@ms.text label="邮件模块代码" help="提示:需使用加密过后的模块代码；邮件模板：通过邮件接口发出的内容模板；短信模板：通过短信接口发出的内容模板；" name="templateCode" value="${templateEntity.templateCode?default('')}"  width="240px;" placeholder="请输入邮件模块代码" validation={"required":"false","maxlength":"50","data-bv-stringlength-message":"邮件模块代码长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    			<@ms.textarea colSm="2" name="templateMail" label="邮件内容" wrap="Soft" rows="5"  size="" width="500px;" value="${templateEntity.templateMail?default('')}" placeholder="请输入邮件内容" validation={"maxlength":"4500","data-bv-stringlength-message":"邮件内容长度不能超过4500个字符长度!"}/>
    			<@ms.textarea colSm="2" name="templateSms" label="消息内容" wrap="Soft" rows="5"  size="" width="500px;" value="${templateEntity.templateSms?default('')}" placeholder="请输入消息内容" validation={"maxlength":"4500","data-bv-stringlength-message":"消息内容长度不能超过4500个字符长度!"}/>
    	</@ms.form>
    </@ms.panel>
</@ms.html5>
<script>
	var url = "${managerPath}/msend/template/save.do";
	if($("input[name = 'templateId']").val() > 0){
		url = "${managerPath}/msend/template/update.do";
		$(".btn-success").text("更新");
	}
	//编辑按钮onclick
	function save() {
		$("#templateForm").data("bootstrapValidator").validate();
			var isValid = $("#templateForm").data("bootstrapValidator").isValid();
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
			data:$("form[name = 'templateForm']").serialize(),
			url:url,
			success: function(status) {
				if(status.templateId > 0) { 
					<@ms.notify msg="保存或更新成功" type= "success" />
					location.href = "${managerPath}/msend/template/index.do";
				}
				else{
					<@ms.notify msg= "保存或更新失败！" type= "fail" />
					location.href= "${managerPath}/msend/template/index.do";
				}
			}
		})
	}	
</script>
