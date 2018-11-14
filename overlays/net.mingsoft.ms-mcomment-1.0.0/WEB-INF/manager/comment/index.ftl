<@ms.html5>
	<@ms.nav title="评论管理"></@ms.nav>
	<@ms.searchForm name="searchForm" isvalidation=true>
		<@ms.text label="评论标题" name="basicTitle" value=""  width="240px;" placeholder="请输入评论标题" validation={"maxlength":"50"}/>
		<#assign status=[{"id":"-1","name":"全部"},{"id":"0","name":"已发布"},{"id":"1","name":"未发布"}]>
		<@ms.select label="发布状态" list=status listValue="name" listKey="id" name="commentAudit" value="" />
		<@ms.searchFormButton>
			 <@ms.queryButton onclick="search()"/> 
		</@ms.searchFormButton>			
	</@ms.searchForm>
	<@ms.panel>
		<div id="toolbar">
			<@ms.button id="audit" value="发布" onclick="audit(0)"/>
			<@ms.button id="cancleAudit" value="取消发布" onclick="audit(1)"/>
		</div>
		<table id="commentList" 
			data-show-refresh="true"
			data-show-columns="true"
			data-show-export="true"
			data-method="post" 
			data-pagination="true"
			data-page-size="10"
			data-side-pagination="server">
		</table>
	</@ms.panel>
	
	<@ms.modal  modalName="delComment" title="评论数据删除" >
		<@ms.modalBody>删除此评论
			<@ms.modalButton>
				<!--模态框按钮组-->
				<@ms.button  value="确认" class="btn btn-danger rightDelete"  id="deleteCommentBtn"  />
			</@ms.modalButton>
		</@ms.modalBody>
	</@ms.modal>
</@ms.html5>

<script>
	$(function(){
		$("#commentList").bootstrapTable({
			url:"${managerPath}/comment/list.do",
			contentType : "application/x-www-form-urlencoded",
			queryParamsType : "undefined",
			toolbar: "#toolbar",
	    	columns: [{ checkbox: true},
				    	{
				        	field: 'commentId',
				        	title: '编号',
				        	width:'80',
				        	align: 'center'
				    	},
							    	{
				        	field: 'basicTitle',
				        	title: '被评论标题',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/comment/form.do?commentId="+row.commentId;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},{
				        	field: 'puNickname',
				        	title: '评论用户昵称',
				        	width: '120'
				    	},{
				        	field: 'commentType',
				        	title: '评论的类型',
				        	align: 'center',
				        	width: '100',
				        	formatter:function(value,row,index) {
				        		switch(value){
				        			case 1 : return "匿名";break;
				        			case 2 : return "公开";break;
				        		}
				        	}
				    	},{
				        	field: 'commentPoints',
				        	title: '评价打分',
				        	align: 'center',
				        	width: '100'
				    	},{
				        	field: 'commentAudit',
				        	title: '发布状态',
				        	width:'100',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		switch(value){
				        			case 0 : return "已发布";break;
				        			case 1 : return "未发布";break;
				        		}
				        	}
				    	},{
				        	field: 'commentTime',
				        	title: '评论时间',
				        	width:'180',
				        	align: 'center'
				    	}
			]
	    })
	})
	//通过按钮
	function audit(commentAudit){
		var rows = $("#commentList").bootstrapTable("getSelections");
		if(rows.length < 1){
			<@ms.notify msg= "至少选择一条数据" type= "warning" />
			return;
		}
		if(commentAudit==0){
			$("#audit").text("正在发布...");
			$("#audit").attr("disabled","true");
		}else{
			$("#cancleAudit").text("正在取消发布...");
			$("#cancleAudit").attr("disabled","true");
		}
		$.ajax({
			type: "post",
			url: "${managerPath}/comment/update.do?commentAudit="+commentAudit,
			data: JSON.stringify(rows),
			dataType: "json",
			contentType: "application/json",
			success:function(msg) {
				if(msg.result == true) {
					if(commentAudit==0){
						<@ms.notify msg= "发布成功" type= "success" />
					}else{
						<@ms.notify msg= "取消发布成功" type= "success" />
					}
				}else {
					<@ms.notify msg= "发布失败" type= "fail" />
				}
				$("#commentList").bootstrapTable("refresh");
				if(commentAudit==0){
					$("#audit").text("发布");
					$("#audit").removeAttr("disabled");
				}else{
					$("#cancleAudit").text("取消发布");
					$("#cancleAudit").removeAttr("disabled");
				}
			}
		})
	}
	//删除按钮
	$("#delCommentBtn").click(function(){
		//获取checkbox选中的数据
		var rows = $("#commentList").bootstrapTable("getSelections");
		//没有选中checkbox
		if(rows.length <= 0){
			<@ms.notify msg="请选择需要删除的记录" type="warning"/>
		}else{
			$(".delComment").modal();
		}
	})
	
	$("#deleteCommentBtn").click(function(){
		var rows = $("#commentList").bootstrapTable("getSelections");
		$(this).text("正在删除...");
		$(this).attr("disabled","true");
		$.ajax({
			type: "post",
			url: "${managerPath}/comment/delete.do",
			data: JSON.stringify(rows),
			dataType: "json",
			contentType: "application/json",
			success:function(msg) {
				if(msg.result == true) {
					<@ms.notify msg= "删除成功" type= "success" />
				}else {
					<@ms.notify msg= "删除失败" type= "warning" />
				}
				location.reload();
			}
		})
	})
	//查询功能
	function search(){
		var search = $("form[name='searchForm']").serializeJSON();
        var params = $('#commentList').bootstrapTable('getOptions');
        params.queryParams = function(params) {  
        	$.extend(params,search);
	        return params;  
       	}  
   	 	$("#commentList").bootstrapTable('refresh', {query:$("form[name='searchForm']").serializeJSON()});
	}
	
</script>