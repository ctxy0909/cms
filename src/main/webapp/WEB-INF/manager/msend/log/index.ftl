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
	<@ms.nav title="发送日志管理"></@ms.nav>
	<@ms.searchForm name="searchForm" isvalidation=true>
		<@ms.text label="接收人" name="logReceive" value=""  width="240px;" placeholder="请输入接收人" validation={"maxlength":"50","data-bv-stringlength-message":"接收人长度不能超过五十个字符长度!"}/>
		<@ms.select 
			id="logType"
		    name="logType" 
		    label="日志类型" 
		    width="240"  
		    list=[{"id":1,"value":"短信"},{"id":0,"value":"邮件"}] 
		    value=""
		    listKey="id" 
		    listValue="value"  
		/>
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
	
	<@ms.modal  modalName="delLog" title="授权数据删除" >
		<@ms.modalBody>删除此授权
			<@ms.modalButton>
				<!--模态框按钮组-->
				<@ms.button  value="确认删除？"  id="deleteLogBtn"  />
			</@ms.modalButton>
		</@ms.modalBody>
	</@ms.modal>
</@ms.html5>

<script>
	$("#logType").select2({width: "270px"});
	$(function(){
		$("#logList").bootstrapTable({
			url:"${managerPath}/msend/log/list.do",
			contentType : "application/x-www-form-urlencoded",
			queryParamsType : "undefined",
			toolbar: "#toolbar",
	    	columns: [
				    	{
				        	field: 'logType',
				        	title: '日志类型',
				        	width:'50',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		if(value == 1){
				        			return "短信";
				        		}else{
				        			return "邮件";
				        		}
						     }
				    	},{
				        	field: 'logReceive',
				        	title: '接收人',
				        	width:'100'
				    	},{
				        	field: 'logContent',
				        	title: '接收内容',
				        	width:'255'
				    	},{
				        	field: 'logDatetime',
				        	title: '发送时间',
				        	width:'200',
				        	align: 'center'
				    	}			]
	    })
	})
	//增加按钮
	$("#addLogBtn").click(function(){
		location.href ="${managerPath}/msend/log/form.do"; 
	})
	//删除按钮
	$("#delLogBtn").click(function(){
		//获取checkbox选中的数据
		var rows = $("#logList").bootstrapTable("getSelections");
		//没有选中checkbox
		if(rows.length <= 0){
			<@ms.notify msg="请选择需要删除的记录" type="warning"/>
		}else{
			$(".delLog").modal();
		}
	})
	
	$("#deleteLogBtn").click(function(){
		var rows = $("#logList").bootstrapTable("getSelections");
		$(this).text("正在删除...");
		$(this).attr("disabled","true");
		$.ajax({
			type: "post",
			url: "${managerPath}/msend/log/delete.do",
			data: JSON.stringify(rows),
			dataType: "json",
			contentType: "application/json",
			success:function(msg) {
				if(msg.result == true) {
					<@ms.notify msg= "删除成功" type= "success" />
				}else {
					<@ms.notify msg= "删除失败" type= "fail" />
				}
				location.reload();
			}
		})
	});
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