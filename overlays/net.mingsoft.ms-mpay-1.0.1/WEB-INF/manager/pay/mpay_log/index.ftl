<@ms.html5>
	<@ms.nav title="交易记录管理"></@ms.nav>
	<@ms.searchForm name="searchForm" isvalidation=true>
			<#assign status=[{"id":"-1","name":"全部"},{"id":"1","name":"支出"},{"id":"2","name":"收入"}]>
			<@ms.select label="交易类型" list=status listValue="name" listKey="id"    name="logType" value="" />
			<@ms.text label="交易标题" name="logTitle" value=""  placeholder="请输入交易标题" validation={"maxlength":"50"}/>
			<@ms.text label="交易流水号" name="logTransactionId" value=""  placeholder="请输入流水号" validation={"maxlength":"50"}/>
			<@ms.searchFormButton>
				 <@ms.queryButton onclick="search()"/> 
			</@ms.searchFormButton>			
	</@ms.searchForm>
	<@ms.panel>
		<table id="logList" 
			data-show-refresh="true"
			data-show-columns="true"
			data-show-export="true"
			data-method="post" 
			data-pagination="true"
			data-page-size="10"
			data-side-pagination="server">
		</table>
	</@ms.panel>
	
</@ms.html5>

<script>
	$(function(){
		$("#logList").bootstrapTable({
			url:"${managerPath}/mpay/payLog/list.do?peopleId=${peopleId?default('')}",
			contentType : "application/x-www-form-urlencoded",
			queryParamsType : "undefined",
	    	columns: [{
				        	field: 'logTransactionId',
				        	title: '交易流水号',
				        	width:'200',
				        	align: 'center'
				    	},{
				        	field: 'orderNo',
				        	title: '订单编号',
				        	width:'200',
				        	align: 'center'
				    	},{
				        	field: 'peopleUser.puNickname',
				        	title: '用户昵称',
				        	width:'150'
				    	},{
				        	field: 'logTitle',
				        	title: '交易标题',
				        	width:'255'
				    	},{
				        	field: 'logStatus',
				        	title: '交易状态',
				        	width:'100',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		switch(value){
				        			case 1 : return "待付款";break;
				        			case 2 : return "已付款";break;
				        			case 5 : return "交易关闭";break;
				        		}
				        	}
				    	},{
				        	field: 'logMoney',
				        	title: '交易额',
				        	width:'100',
				        	align: 'right'
				    	},{
				        	field: 'logType',
				        	title: '交易类型',
				        	width:'100',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		switch(value){
				        			case 1 : return "支出";break;
				        			case 2 : return "收入";break;
				        		}
				        	}
				    	},{
				        	field: 'logPayType',
				        	title: '支付类型',
				        	width:'100',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		switch(value){
				        			case "weixin" : return "微信";break;
				        			case "alipay" : return "支付宝";break;
				        			default : return value;
				        		}
				        	}
				    	},{
				        	field: 'logDate',
				        	title: '交易时间',
				        	width:'255',
				        	align: 'center'
				    	}
							    	
			]
	    })
	})
	//查询功能
	function search(){
		var search = $("form[name='searchForm']").serializeJSON();
        var params = $('#logList').bootstrapTable('getOptions');
        params.queryParams = function(params) {  
        	$.extend(params,search);
	        return params;  
       	}  
   	 	$("#logList").bootstrapTable('refresh', {query:$("form[name='searchForm']").serializeJSON()});
	}
	
</script>