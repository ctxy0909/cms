<@ms.html5>
	<@ms.panel>
		<@ms.nav title="公众号列表"></@ms.nav>
		<!--使用bootstrap-table的toolbar添加按钮-->
		<div id="toolbar">
			<!--列表操作按钮，添加和删除 开始 -->
			<@ms.panelNavBtnGroup>
				<@ms.panelNavBtnAdd id="addButton" value="" /><!-- 新增按钮 -->
				<@ms.panelNavBtnDel id="delButton" value="" /><!-- 删除按钮 -->
			</@ms.panelNavBtnGroup>		
			<!--列表操作按钮，添加和删除结束 -->
		</div>
		<!--微信列表-->
		<table id="weixinListTable"
			data-show-refresh="true"
	        data-show-columns="true"
	        data-show-export="true"
			data-method="post" 
			data-detail-formatter="detailFormatter" 
			data-pagination="true"
			data-page-size="10"
			data-side-pagination="server">
		</table>	
	</@ms.panel>
</@ms.html5>
<@ms.modal  modalName="delWeixinModal" title="删除微信" >
	<@ms.modalBody>
		删除微信
	</@ms.modalBody>
	<@ms.modalButton>
		<!--模态框按钮组-->
		<@ms.button  value="确认删除？"  id="deleteWeixin"  />
	</@ms.modalButton>
</@ms.modal>
<script>
	$(function(){
		$("#weixinListTable").bootstrapTable({
        	url:"${managerPath}/weixin/list.do",
        	contentType : "application/x-www-form-urlencoded",
        	queryParamsType : "undefined",
        	toolbar:"#toolbar",
        	queryParams:function(params) {
				return  $.param(params);
			},
			columns: [{checkbox:'true'},
			{
				align:'center',
			   	field: 'weixinId',
			    title: '编号',
			    width:'50'
			    
			}, {
			    align:'left',
			    field: 'weixinNo',
			    title: '微信号',
			    width:'220'
			    
			},{
			    align:'left',
			    field: 'weixinName',
			    title: '公众号名称',
			     width:'220',
			    formatter:function(value,row,index){return"	<a class='btn btn-xs red tooltips editWeixin' data-id=" + row.weixinId + ">" + row.weixinName + "</a>"}
			}, {
			    align:'center',
			    field: 'weixinType',
			    title: '公众号类型',
			    width:'110',
			    formatter:function(value,row,index){
			    	if(row.weixinType == 0){
			    		return "服务号";
			    	}
			    	else if(row.weixinType == 1){
			    		return "订阅号";
			    	}
			   }
			},{
			    align:'left',
			    field: 'weixinToken',
			    title: '微信token',
			    width:'120'
			},{
				align:'left',
				field: 'weixinOauthUrl',
			    title: '网页2.0授权地址'
			}]
        });
    })
	//新增微信
	$("#addButton").click(function(){
		location.href = "${managerPath}/weixin/add.do"; 	
	})
	//判断打开删除模态框条件
	$("#delButton").click(function(){
		//获取checkbox选中的数据
		var rows = $("#weixinListTable").bootstrapTable("getSelections");
		//没有选中checkbox
		if(rows.length <= 0){
			<@ms.notify msg="请选择删除的微信" type="warning"/>
		//点击全选，但是列表为空
		}else if(rows.length == 0){
			<@ms.notify msg="没有可删除的微信" type="warning"/>
		}else{
			$(".delWeixinModal").modal();
		}
	});
	//批量删除
	$("#deleteWeixin").click(function(){
		var rows = $("#weixinListTable").bootstrapTable("getSelections");
		$(this).text("努力删除中...")
		$(this).attr("disabled","true");
		$.ajax({		
		    type:"post",
			url:"${managerPath}/weixin/delete.do",
		    data:JSON.stringify(rows),
		    dataType:"json",
  			contentType:"application/json",
		    success:function(msg) { 
				if(msg.result == true) {
					<@ms.notify msg="删除成功" type="success"/>
				}else{
					<@ms.notify msg="删除失败" type="fail"/>
				}
				location.reload();
			}
		});	
	})
    $("body").delegate(".editWeixin","click",function(){
    	var weixinId = $(this).attr("data-id");
    	location.href="${managerPath}/weixin/"+weixinId+"/function.do";
    })
</script>
