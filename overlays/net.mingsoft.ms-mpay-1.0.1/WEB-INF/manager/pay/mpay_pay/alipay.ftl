<@ms.html5>
	 <@ms.nav title="支付宝设置" >
    	<@ms.saveButton  onclick="save()"/>
    </@ms.nav>
    <@ms.panel>
    	<@ms.form name="payForm" isvalidation=true>
    		<@ms.hidden name="payId" value="${(payEntity.payId)?default('')}"/>
			<@ms.hidden  name="payType" value="alipay" />
			<@ms.text label="支付宝账号" name="payNo" value="${(payEntity.payNo)?default('')}"  width="300px;" placeholder="请输入支付宝账号" validation={"maxlength":"50","data-bv-stringlength-message":"支付宝账号长度不能超过五十个字符长度!"}/>
			<@ms.select 
 				default="请选择接口类型"
			    name="payApitype" 
			    label="接口类型" 
			    list=[{"id":1,"value":"即时到账"}]
			    listKey="id" 
			    listValue="value"
			    width="300px;" 
			/>
			<@ms.text label="合作身份者ID" name="payPartner" value="${(payEntity.payPartner)?default('')}"  width="300px;" placeholder="请输入合作身份者ID" validation={"maxlength":"50","data-bv-stringlength-message":"合作身份者ID长度不能超过五十个字符长度!"}/>
			<@ms.text label="交易安全检验码" name="payKey" value="${(payEntity.payKey)?default('')}"  width="300px;" placeholder="请输入交易安全检验码" validation={"maxlength":"50","data-bv-stringlength-message":"交易安全检验码长度不能超过五十个字符长度!"}/>
			<@ms.text label="应用Id(app支付)" name="payAppId" value="${(payEntity.payAppId)?default('')}"  width="300px;" placeholder="请输入应用ID" validation={"maxlength":"50","data-bv-stringlength-message":"应用ID长度不能超过五十个字符长度!"}/>
			<@ms.textarea colSm="2" name="payAppPrivateKey" label="应用私钥(app支付)" wrap="Soft" rows="6"  size=""  value="${(payEntity.payAppPrivateKey)?default('')}" help="支付类型为APP支付时需填写" placeholder="请输入应用私钥" validation={"maxlength":"3000","data-bv-stringlength-message":"文章描述在3000个字符以内!"}/>
			<@ms.textarea colSm="2" name="payAlipayPublicKey" label="支付宝公钥(app支付)" wrap="Soft" rows="6"  size=""  value="${(payEntity.payAlipayPublicKey)?default('')}" help="支付类型为APP支付时需填写" placeholder="请输入支付宝公钥" validation={"maxlength":"3000","data-bv-stringlength-message":"文章描述在3000个字符以内!"}/>
    	</@ms.form>
    </@ms.panel>
</@ms.html5>
<script>
	if($("input[name = 'payId']").val() > 0){
		$(".btn-success").text("更新");
		$("select[name='payApitype']").val(${(payEntity.payApitype)?default('请选择接口类型')});
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
