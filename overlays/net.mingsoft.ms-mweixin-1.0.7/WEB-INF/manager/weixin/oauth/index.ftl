<@ms.html5>
	<@ms.nav title="微信网页2.0授权表管理"></@ms.nav>
	<@ms.searchForm name="searchForm" isvalidation=true>
    		<@ms.text name="oauthDescription" label="授权描述" validation={"required":"true","maxlength":"50","data-bv-maxlesizength-message":"描述长度不能超过五十个字符长度!"} />
			<@ms.searchFormButton>
				 <@ms.queryButton onclick="search()"/> 
			</@ms.searchFormButton>			
	</@ms.searchForm>
	<@ms.panel>
		<div id="toolbar">
			<@ms.panelNav>
				<@ms.buttonGroup>
					<@ms.addButton id="addOauthBtn"/>
					<@ms.delButton id="delOauthBtn"/>
				</@ms.buttonGroup>
			</@ms.panelNav>
		</div>
		<table id="oauthList" 
			data-show-refresh="true"
			data-show-columns="true"
			data-show-export="true"
			data-method="post" 
			data-pagination="true"
			data-page-size="10"
			data-side-pagination="server">
		</table>
	</@ms.panel>
	
	<@ms.modal  modalName="delOauth" title="授权数据删除" >
		<@ms.modalBody>删除此授权
			<@ms.modalButton>
				<!--模态框按钮组-->
				<@ms.button  value="确认删除？"  id="deleteOauthBtn"  />
			</@ms.modalButton>
		</@ms.modalBody>
	</@ms.modal>
</@ms.html5>

<script>
	$(function(){
		$("#oauthList").bootstrapTable({
			url:"${managerPath}/weixin/oauth/list.do",
			contentType : "application/x-www-form-urlencoded",
			queryParamsType : "undefined",
			toolbar: "#toolbar",
	    	columns: [{ checkbox: true},
	    	{
	        	field: 'oauthWeixinId',
	        	title: '微信编号',
	        	width:'10',
	        	align: 'center'
	        },{
	        	field: 'oauthId',
	        	title: '子增长ID',
	        	width:'10',
	        	align: 'center',
	        	formatter:function(value,row,index) {
	        		var url = "${managerPath}/weixin/oauth/form.do?oauthId="+row.oauthId;
	        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
	        	}
	    	},{
	        	field: 'oauthAppId',
	        	title: '关联微信应用ID',
	        	width:'10',
	        	align: 'right'
	        },{
	        	field: 'oauthSuccessUrl',
	        	title: '授权成功重定向地址',
	        	width:'200',
	        	align: 'left'
	        },{
	        	field: 'oauthErrorUrl',
	        	title: '授权失败者或错误重定向地址',
	        	width:'200',
	        	align: 'left'
	        },{
	        	field: 'oauthDescription',
	        	title: '授权描述',
	        	width:'100',
	        	align: 'left'
	        },{
	        	field: 'oauthType',
	        	title: '授权类型',
	        	width:'100',
	        	align: 'center',
	        	formatter:function(value,row,index) {
		        	switch(value) {
		        		case 1:
		        		return "弹出授权界面";break;
		        		case 2:
		        		return "不弹出授权界面";break;
		        	}
		        }
	        }]
	    })
	})
	//增加按钮
	$("#addOauthBtn").click(function(){
		location.href ="${managerPath}/weixin/oauth/form.do"; 
	})
	
	//删除按钮
	$("#delOauthBtn").click(function(){
		//获取checkbox选中的数据
		var rows = $("#oauthList").bootstrapTable("getSelections");
		//没有选中checkbox
		if(rows.length <= 0){
			<@ms.notify msg="请选择需要删除的记录" type="warning"/>
		}else{
			$(".delOauth").modal();
		}
	})
	
	$("#deleteOauthBtn").click(function(){
		var rows = $("#oauthList").bootstrapTable("getSelections");
		$(this).text("正在删除...");
		$(this).attr("disabled","true");
		$.ajax({
			type: "post",
			url: "${managerPath}/weixin/oauth/delete.do",
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
        var params = $('#oauthList').bootstrapTable('getOptions');
        params.queryParams = function(params) {  
        	$.extend(params,search);
	        return params;  
       	}  
   	 	$("#oauthList").bootstrapTable('refresh', {query:$("form[name='searchForm']").serializeJSON()});
	}
</script>