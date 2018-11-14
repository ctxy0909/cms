<@ms.html5>
	<style>
		.select2-container .select2-container--default {  
		 	height: 34px;  
		} 
		.select2-container .select2-selection--single{
			font: inherit;
			border: 1px solid #ccc;
		    display: block;
		    height: 34px;
		    padding: 2px 3px;
    		font-size: 14px;
    		color: rgb(85, 85, 85);
		}
	</style> 
	 <@ms.nav title="邮件配置" back=true>
    	<@ms.saveButton  onclick="save()"/>
    </@ms.nav>
    <@ms.panel>
    	<@ms.form name="mailForm" isvalidation=true>
    		<@ms.hidden name="appId" value="${(mailEntity.appId)?default('')}"/>
    			<@ms.select 
    				id="mailType"
				    name="mailType" 
				    label="邮件类型"
				    width="270"  
				    list=["sendcloud","邮件服务器"] 
				    value="${(mailEntity.mailType)?default('')}"
				    validation={"required":"true", "data-bv-notempty-message":"必选项目"}
				    helpDirection="bottom"
				    help="提示：支持邮件服务器、sendcloud两种； 邮件服务器：所有输入项为必填； sendcloud：只需输入API_USER与AP_I_KEY；"
				/>
    			<@ms.text label="账号(API_USER)" name="mailName" value="${(mailEntity.mailName)?default('')}"  width="270px;" placeholder="请输入账号" validation={"required":"false","maxlength":"50","data-bv-stringlength-message":"账号长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    			<@ms.password name="mailPassword" label="密码(API_KEY)"  title="" size="5" width="270"  validation={"required":"false","data-bv-stringlength":"true","data-bv-stringlength-max":"20", "maxlength":"20", "data-bv-stringLength-min":"6" ,"data-bv-stringlength-message":"密码长度为6-20个字符", "data-bv-notempty-message":"必填项目"}/>
    			<div class="server">
	    			<@ms.text label="服务器" name="mailServer" value="${(mailEntity.mailServer)?default('')}"  width="270px;" placeholder="请输入服务器" validation={"maxlength":"50","data-bv-stringlength-message":"服务器长度不能超过五十个字符长度!"}/>
					<@ms.number label="端口号" name="mailPort" value="${(mailEntity.mailPort)?default('')}" max=9999999 width="270px;" placeholder="请输入端口号" maxlength=7  />
				</div>
				<@ms.text label="发送人姓名" name="mailFormName" value="${(mailEntity.mailFormName)?default('')}"  width="270px;" placeholder="请输入发送人姓名" validation={"maxlength":"50","data-bv-stringlength-message":"发送人姓名长度不能超过五十个字符长度!"}/>
    			<@ms.text label="发送者邮箱地址" name="mailForm" value="${(mailEntity.mailForm)?default('')}"  width="270px;" placeholder="请输入发送者邮箱地址" validation={"maxlength":"50","data-bv-stringlength-message":"发送者邮箱地址不能超过五十个字符长度!"}/>
    			<!--<@ms.select 
    				id="mailEnable"
				    name="mailEnable" 
				    label="是否启用" 
				    width="270"  
				    list=[{"id":0,"value":"启用"},{"id":1,"value":"禁用"}] 
				    value="${(mailEntity.mailEnable)?default('')}"
				    listKey="id" 
				    listValue="value"  
				    validation={"required":"true", "data-bv-notempty-message":"必选项目"}
				/>-->
    	</@ms.form>
    </@ms.panel>
</@ms.html5>
<script>
	
	$("#mailType").select2({width: "240px"});
	var url = "${managerPath}/msend/mail/save.do";
	if($("input[name = 'appId']").val() > 0){
		url = "${managerPath}/msend/mail/update.do";
		$(".btn-success").text("更新");
	}
	<#if (mailEntity.mailType)?default("") == "邮件服务器">
		$(".server").show();
	<#else>
		$(".server").hide();
	</#if>
	$("select#mailType").change(function(){
		if($(this).val() == "邮件服务器"){
			$(".server").show();
		}else if($(this).val() == "sendcloud"){
			$(".server").hide();
		}
	 });
	//编辑按钮onclick
	function save() {
		$("#mailForm").data("bootstrapValidator").validate();
			var isValid = $("#mailForm").data("bootstrapValidator").isValid();
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
			data:$("form[name = 'mailForm']").serialize(),
			url:url,
			success: function(status) {
				if(status != null) { 
					<@ms.notify msg="保存或更新成功" type= "success" />
					$(".btn-success").text("更新");
				}
				else{
					<@ms.notify msg= "保存或更新失败！" type= "fail" />
					$(".btn-success").text(btnWord);
				}
				$(".btn-success").removeAttr("disabled");
			}
		})
	}	
</script>
