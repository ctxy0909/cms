<@ms.html5>
	<@ms.nav title="微信带参数的二维码管理"></@ms.nav>
	<@ms.searchForm name="searchForm" isvalidation=true>
			<@ms.searchFormButton>
				 <@ms.queryButton onclick="search()"/> 
			</@ms.searchFormButton>			
	</@ms.searchForm>
	<@ms.panel>
		<div id="toolbar">
			<@ms.panelNav>
				<@ms.buttonGroup>
					<@ms.addButton id="addQrcodeBtn"/>
					<@ms.delButton id="delQrcodeBtn"/>
				</@ms.buttonGroup>
			</@ms.panelNav>
		</div>
		<table id="qrcodeList" 
			data-show-refresh="true"
			data-show-columns="true"
			data-show-export="true"
			data-method="post" 
			data-pagination="true"
			data-page-size="10"
			data-side-pagination="server">
		</table>
	</@ms.panel>
	
	<@ms.modal  modalName="delQrcode" title="二维码数据删除" >
		<@ms.modalBody>删除此二维码
			<@ms.modalButton>
				<!--模态框按钮组-->
				<@ms.button  value="确认删除？"  id="deleteQrcodeBtn"  />
			</@ms.modalButton>
		</@ms.modalBody>
	</@ms.modal>
</@ms.html5>

<script>
	$(function(){
		$("#qrcodeList").bootstrapTable({
			url:"${managerPath}/weixin/qrcode/list.do",
			contentType : "application/x-www-form-urlencoded",
			queryParamsType : "undefined",
			toolbar: "#toolbar",
	    	columns: [{ checkbox: true},
	    	{
	        	field: 'qrcodeId',
	        	title: '自增长ID',
	        	width:'10',
	        	align: 'center',
	        	formatter:function(value,row,index) {
	        		var url = "${managerPath}/weixin/qrcode/form.do?qrcodeId="+row.qrcodeId;
	        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
	        	}
	    	},{
	        	field: 'qrcodeTitle',
	        	title: '二维码名称',
	        	width:'50',
	        	align: 'left'
	        },{
	        	field: 'qrcodeValue',
	        	title: '二维码的场景值',
	        	width:'10',
	        	align: 'center'
	        },{
	        	field: 'qrcodeType',
	        	title: '二维码类型',
	        	width:'50',
	        	align: 'center',
	        	formatter:function(value,row,index) {
		        	switch(value) {
		        		case 0:
		        		return "永久二维码";break;
		        		case 1:
		        		return "临时二维码";break;
		        	}
		        }
	        },{
	        	field: 'qrcodeAppId',
	        	title: '二维码所属应用ID',
	        	width:'10',
	        	align: 'right'
	        },{
	        	field: 'qrcodeDescription',
	        	title: '二维码描述',
	        	width:'200',
	        	align: 'left'
	        },{
	        	field: 'qrcodeTime',
	        	title: '二维码生成时间',
	        	width:'19',
	        	align: 'center'
	        },{
	        	field: 'qrcodeExpireTime',
	        	title: '二维码到期时间',
	        	width:'10',
	        	align: 'right'
	        },{
	        	field: 'qrcodeWeixinId',
	        	title: '微信编号',
	        	width:'10',
	        	align: 'center'
	        }]
	    })
	})
	//增加按钮
	$("#addQrcodeBtn").click(function(){
		location.href ="${managerPath}/weixin/qrcode/form.do"; 
	})
	
	//删除按钮
	$("#delQrcodeBtn").click(function(){
		//获取checkbox选中的数据
		var rows = $("#qrcodeList").bootstrapTable("getSelections");
		//没有选中checkbox
		if(rows.length <= 0){
			<@ms.notify msg="请选择需要删除的记录" type="warning"/>
		}else{
			$(".delQrcode").modal();
		}
	})
	
	$("#deleteQrcodeBtn").click(function(){
		var rows = $("#qrcodeList").bootstrapTable("getSelections");
		$(this).text("正在删除...");
		$(this).attr("disabled","true");
		$.ajax({
			type: "post",
			url: "${managerPath}/weixin/qrcode/delete.do",
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
        var params = $('#qrcodeList').bootstrapTable('getOptions');
        params.queryParams = function(params) {  
        	$.extend(params,search);
	        return params;  
       	}  
   	 	$("#qrcodeList").bootstrapTable('refresh', {query:$("form[name='searchForm']").serializeJSON()});
	}
</script>