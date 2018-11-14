<@ms.html5>
	 <@ms.nav title="发送日志编辑" back=true>
    	<@ms.saveButton  onclick="save()"/>
    </@ms.nav>
    <@ms.panel>
    	<@ms.form name="logForm" isvalidation=true>
    		<@ms.hidden name="logId" value="${logEntity.logId?default('')}"/>
    			<@ms.number label="应用编号" name="appId" value="${logEntity.appId?default('')}" width="240px;" placeholder="请输入应用编号" validation={"required":"false","maxlength":"50","data-bv-stringlength-message":"应用编号长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    			<@ms.text label="发送时间" name="logDatetime" value="${logEntity.logDatetime?string('yyyy-MM-dd')}"  width="240px;"/>
    			<@ms.text label="接收内容" name="logContent" value="${logEntity.logContent?default('')}"  width="240px;" placeholder="请输入接收内容" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"接收内容长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    			<@ms.text label="接收人" name="logReceive" value="${logEntity.logReceive?default('')}"  width="240px;" placeholder="请输入接收人" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"接收人长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    			<@ms.number label="日志类型（0邮件1短信）" name="logType" value="${logEntity.logType?default('')}" width="240px;" placeholder="请输入日志类型0邮件1短信" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"日志类型0邮件1短信长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    	</@ms.form>
    </@ms.panel>
</@ms.html5>
<script>
	var url = "${managerPath}/msend/log/save.do";
	if($("input[name = 'logId']").val() > 0){
		url = "${managerPath}/msend/log/update.do";
		$(".btn-success").text("更新");
	}
	//编辑按钮onclick
	function save() {
		$("#logForm").data("bootstrapValidator").validate();
			var isValid = $("#logForm").data("bootstrapValidator").isValid();
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
			data:$("form[name = 'logForm']").serialize(),
			url:url,
			success: function(status) {
				if(status.result == true) { 
					<@ms.notify msg="保存或更新成功" type= "success" />
					location.href = "${managerPath}/msend/log/index.do";
				}
				else{
					<@ms.notify msg= "保存或更新失败！" type= "fail" />
					location.href= "${managerPath}/msend/log/index.do";
				}
			}
		})
	}	
</script>
