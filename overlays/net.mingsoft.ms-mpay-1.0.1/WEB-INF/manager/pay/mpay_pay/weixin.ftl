<@ms.html5>
	 <@ms.nav title="微信支付设置" >
    	<@ms.saveButton  onclick="save()"/>
    </@ms.nav>
    <@ms.panel>
    	<@ms.form name="payForm" isvalidation=true>
    		<@ms.hidden name="payId" value="${(payEntity.payId)?default('')}"/>
			<@ms.hidden  name="payType" value="weixin"/>
			<@ms.text label="微信appId" name="payNo" value="${(payEntity.payNo)?default('')}"  width="300px;" placeholder="微信appId" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"微信appId长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
			<@ms.text label="商户号" name="payPartner" value="${(payEntity.payPartner)?default('')}"  width="300px;" placeholder="请输入商户号" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"合作身份者ID长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
			<@ms.text label="微信Key" name="payKey" value="${(payEntity.payKey)?default('')}"  width="300px;" placeholder="请输入微信key" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"交易key长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
			<@ms.text label="微信appSecret" name="paySecret" value="${(payEntity.paySecret)?default('')}"  width="300px;" placeholder="请输入微信appSecret" help="微信公众号支付必填" validation={"maxlength":"50","data-bv-stringlength-message":"微信appSecret长度不能超过五十个字符长度!"}/>
    		<@ms.text name="payResource" label="商户证书:" width="300px;" value="${(payEntity.payResource)?default('')}" title="商户证书" readonly="readonly" help="如需退款，则必须上传商户证书"/>
    		<@ms.formRow >
					<@ms.uploadFile path="" uploadFloderPath="WEB-INF/pay" inputName="payResourceUrl" size="10" filetype="p12" msg="后缀为.p12文件,大小不能超过3M"  maxSize="3" callBack="setFile" isRename="true"  />
			</@ms.formRow>
    	</@ms.form>
    </@ms.panel>
</@ms.html5>
<script>
	if($("input[name = 'payId']").val() > 0){
		$(".btn-success").text("更新");
	}
	function setFile(file){
   	   	if(file < 0){   
   	   		}else{  
	   		<@ms.notify msg="上传成功!" type= "success" />  
   	   		$("input[name='payResource']").val(file);    	   
   	   	}
   	}
	//编辑按钮onclick
	function save() {
		$("#payForm").data("bootstrapValidator").validate();
			var isValid = $("#payForm").data("bootstrapValidator").isValid();
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
			data:$("form[name = 'payForm']").serialize(),
			url:"${managerPath}/mpay/pay/saveOrUpdate.do",
			success: function(data,status) {
				if(data.payId > 0) { 
					<@ms.notify msg="保存或更新成功" type= "success" />
					$(".btn-success").text("更新");
				}
				else{
					<@ms.notify msg= "保存或更新失败！" type= "fail" />
				}
				$(".btn-success").removeProp("disabled");
				$(".btn-success").text("更新");
			}
		})
		
	}	
</script>
