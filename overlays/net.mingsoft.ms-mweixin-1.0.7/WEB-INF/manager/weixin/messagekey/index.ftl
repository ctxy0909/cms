<@ms.html5>
	<@ms.panel>	
		<!--title对应板块名称-->
		<@ms.nav title="关键字回复"></@ms.nav>
		<!--使用bootstrap-table的toolbar添加按钮-->
		<div id="toolbar">
			<@ms.panelNav empty=false>
				<!--列表操作按钮，添加和删除-->
				<@ms.panelNavBtnGroup>
					<@ms.panelNavBtnAdd id="addButton" value="" />
					<@ms.panelNavBtnDel id="delButton" value="" />
				</@ms.panelNavBtnGroup>													
			</@ms.panelNav>
		</div>
		<!--表格标题-->	
		<table id="messagekeyListTable"
			data-show-refresh="true"
	        data-show-columns="true"
	        data-show-export="true"
			data-method="post"
			data-pagination="true"
			data-page-size="10" 
			data-detail-formatter="detailFormatter" 
			data-side-pagination="server">
		</table>
	</@ms.panel>
	<@ms.modal  modalName="delMessagekeyModal" title="删除关键字回复" >
		<@ms.modalBody>
			删除关键字
		</@ms.modalBody>
		<@ms.modalButton>
			<!--模态框按钮组-->
			<@ms.button  value="确认删除？"  id="deleteMessagekey"  />
		</@ms.modalButton>
	</@ms.modal>											
</@ms.html5>
<script>
	$(function(){
		$("#messagekeyListTable").bootstrapTable({
        	url:"${managerPath}/weixin/messagekey/list.do",
        	contentType : "application/x-www-form-urlencoded",
        	queryParamsType : "undefined",
        	toolbar: "#toolbar",
        	queryParams:function(params) {
				return  $.param(params);
			},
			columns: [{checkbox:'true'},
			{
				align:'left',
			   	field: 'passiveMessageKey',
			    title: '关键词',
			    width:'200'
			    
			}, {
			    align:'left',
			    field: 'passiveMessageId',
			    title: '回复内容',
			    formatter:function(value,row,index){
			    	if(row.newsEntity.newsType == 0){
			    		return "<a style='cursor: pointer;'  class='editMessage' data-original-title='修改' data-id=" + row.passiveMessageId + ">" + row.basicEntity.basicTitle + "</a>";
			    	}
			    	else if(row.newsEntity.newsType == 1){
			    		return "<a style='cursor: pointer;'  class='editMessage' data-original-title='修改' data-id=" + row.passiveMessageId + ">主图文标题：" + row.basicEntity.basicTitle +  "</a>";
			    	}
			    	else if(row.newsEntity.newsType == 2){
			    		return "<a style='cursor: pointer;'  class='editMessage'   data-original-title='修改' data-id=" + row.passiveMessageId + ">" + row.newsEntity.newsContent + "</a>";
			    	}
			    	else if(row.newsEntity.newsType == 3){
			    		return "图片素材";
			    	}
			    	else{
			    		return "未知";
			    	}
			   }
			},{
			    align:'center',
			    field: 'newsType',
			    title: '素材类型',
			    width:'150',
			    formatter:function(value,row,index){
			    	if(row.newsEntity.newsType == 0){
			    		return "单图文素材";
			    	}
			    	else if(row.newsEntity.newsType == 1){
			    		return "多图文素材";
			    	}
			    	else if(row.newsEntity.newsType == 2){
			    		return "文本素材";
			    	}
			   }
			}]
        });
    })
	//新增关键字回复
	$("#addButton").click(function(){
		location.href = base+"${baseManager}/weixin/messagekey/add.do"; 
	});
	//编辑关键字回复
	$("body").delegate(".editMessage","click",function(){
		location.href = base+"${baseManager}/weixin/messagekey/"+$(this).attr("data-id")+"/edit.do"; 
	})
	//判断打开删除模态框的条件
	$("#delButton").click(function(){
		//获取CheckBox选中的数据
		var rows = $("#messagekeyListTable").bootstrapTable("getSelections");
		//没有选中checkbox
		if(rows.length <= 0){
			<@ms.notify msg="请选择删除的关键字回复" type="warning"/>
		//点击全选，但是列表为空
		}else if(rows.length == 0){
			<@ms.notify msg="请选择删除的关键字回复" type="warning"/>
		}else{
			$(".delMessagekeyModal").modal();
		}
	})
	//批量删除
	$("#deleteMessagekey").click(function(){
		$(this).text("努力删除中...")
		$(this).attr("disabled","true");
		rows = $("#messagekeyListTable").bootstrapTable("getSelections");	
		$.ajax({		
		    type:"post",
			url:"${managerPath}/weixin/messagekey/delete.do",
		    data:JSON.stringify(rows),
		    dataType:"json",
  			contentType:"application/json",
		    success:function(msg) { 
				if (msg.result == false) {
					<@ms.notify msg="删除失败" type="fail"/>
				}else{
					<@ms.notify msg="删除成功" type="success"/>
					location.href = base+"${baseManager}/weixin/messagekey/index.do";
				}
			}
		});	
	})    
</script>
