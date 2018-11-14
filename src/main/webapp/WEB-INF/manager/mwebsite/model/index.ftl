<@ms.html5>
	<@ms.nav title="模块管理"></@ms.nav>
	<@ms.panel>
		<div id="toolbar">
			<@ms.panelNav>
				<@ms.buttonGroup>
					<@ms.addButton id="addModelBtn"/>
					<@ms.delButton id="delModelBtn"/>
				</@ms.buttonGroup>
			</@ms.panelNav>
		</div>
		<table id="modelList" 
			data-show-refresh="true"
			data-show-columns="true"
			data-show-export="true"
			data-method="post" 
			data-side-pagination="server">
		</table>
	</@ms.panel>
 	<!--添加模块-->    
	<@ms.modal modalName="addEditModel" title="添加模块">
		<@ms.modalBody height="350">
			<@ms.form isvalidation=true name="addEditForm"  action="" method="post"  >
				<@ms.formRow label="父级菜单">
					<@ms.treeInput treeId="modelInputTree" json="${parentModelList?default('')}" jsonId="modelId" jsonPid="modelModelId" jsonName="modelTitle"  addNodesName="顶级模块" buttonText="顶级模块" inputName="modelModelId" inputValue="0"  expandAll="true" showIcon="true"/>
				</@ms.formRow>
				<@ms.text name="modelTitle" label="标题" title="模块标题" placeholder="请输入模块标题" value="" validation={"required":"true", "data-bv-notempty-message":"请输入模块标题!"} />
				<@ms.text name="modelCode"  label="编码" title="模块编码" placeholder="请输入模块编码" value="" validation={"required":"true", "data-bv-notempty-message":"请输入模块编码!"} />
				<@ms.text name="modelIcon"  label="图标" title="模块图标"  placeholder="请输入模块图标" value=""/>
				<@ms.text name="modelUrl"  label="链接地址" title="模块链接地址"  placeholder="请输入模块链接地址" value=""/>
				<#assign isMenu=[{"id":"0","name":"否"},{"id":"1","name":"是"}]>
				<@ms.number name="modelSort" label="排序" title="模块排序" value="" width="165px;" placeholder="请输入排序" validation={"required":"true","data-bv-notempty-message":"请输入模块的排序"}/>
				<@ms.select name="modelIsMenu" style="width: 25%;" id="modelMenuSelect" list=isMenu  listKey="id" listValue="name" label="是否是菜单"  value="0" title="是否是菜单" />
				<@ms.hidden name="modelId" value="" id="hideModelId"/>
			</@ms.form>
		</@ms.modalBody>
		<@ms.modalButton>
			<@ms.button  value=""  id="addEditBtn"/>
		</@ms.modalButton>
	</@ms.modal>	
	<@ms.modal  modalName="delModel" title="模块数据删除" >
		<@ms.modalBody>删除此模块
			<@ms.modalButton>
				<!--模态框按钮组-->
				<@ms.button  value="删除" class="btn btn-danger rightDelete"  id="deleteModelBtn"  />
			</@ms.modalButton>
		</@ms.modalBody>
	</@ms.modal>
</@ms.html5>

<script>
	var modelId;
	var postMessage;
	$(function(){
		$("#modelList").bootstrapTable({
			url:"${managerPath}/mwebsite/model/list.do",
			contentType : "application/x-www-form-urlencoded",
			queryParamsType : "undefined",
			toolbar: "#toolbar",
			idField: 'modelId',
            treeShowField: 'modelTitle',
            parentIdField: 'modelModelId',
	    	columns: [{ checkbox: true},
				    	{
				        	field: 'modelIcon',
				        	title: '模块图标',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		if(value != null){
				        			return "<i class='iconfont'>"+value+"</i>";
				        		}else{
				        			return "";
				        		}
				        	}
				        	
				    	},{
				        	field: 'modelTitle',
				        	title: '模块标题',
				        	formatter:function(value,row,index) {
				        		return "<a style='cursor:pointer;text-decoration:none;' onclick='editModal("+row.modelId+")'>" + value + "</a>";
				        	}
				    	},{
				        	field: 'modelCode',
				        	title: '模块编码'
				    	},{
				        	field: 'modelUrl',
				        	title: '模块连接地址',
				        	formatter:function(value,row,index) {
				        		if(value == null){
				        			return "";
				        		}else{
				        			return value;
				        		}
				        	}
				        	
				    	},{
				        	field: 'modelSort',
				        	title: '模块的排序'
				    	},{
				        	field: 'modelIsMenu',
				        	title: '模块是否是菜单',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		if(value == 0){
				        			return "否";
				        		}else if(value == 1){
				        			return "是";
				        		}else{
				        			return "";
				        		}
				        	}
				    	}]
	    })
	})
	//新增模块
	$("#addModelBtn").click(function(){
		postMessage="保存成功！";
		$("#addEditBtn").text("保存");
		$("#addEditForm").attr("action","${managerPath}/mwebsite/model/save.do");
		$("#addEditForm")[0].reset(); 
		$(".addEditModel").modal();
		$("input[name='modelSort']").val(0);
		$("#hideModelId").attr("disabled",true);
	});
	//编辑模块
	function editModal(id){
	var editUrl="${managerPath}/mwebsite/model/get.do?modelId="+id;
	$(this).request({url:editUrl,type:"json",method:"post",func:function(data){
		var model = data.model;
		// 给表单赋值
		if(model!=null){
			$("input[name='modelId']").val(model.modelId);
			if(model.modelIcon!=undefined){
				$("input[name='modelIcon']").val(model.modelIcon);
			}
			if(model.modelModelId==0){
				$("#treeLabelmodelInputTree").text("顶级模块");
			}else{
				$("#treeLabelmodelInputTree").text(data.parentModel.modelTitle);
			}
			if(model.modelIsMenu == 0){
				$("select[name=modelIsMenu]").append("<option value = 0 selected='selected'>否</option>");	
			}else{
				$("select[name=modelIsMenu]").append("<option value = 1 selected='selected'>是</option>");	
			}
			$("input[name='modelTitle']").val(model.modelTitle);
			$("input[name='modelSort']").val(model.modelSort);
			$("input[name='modelCode']").val(model.modelCode);
			$("input[name='modelUrl']").val(model.modelUrl);
			$("#modelMenuSelect option[value="+model.modelMenu+"]").attr("selected",true);
			$("input[name='modelModelId']").val(model.modelModelId);
			$(".addEditModel").modal();
			postMessage="更新成功！";
			$("#addEditBtn").text("更新");
			$("#hideModelId").attr("disabled",false);
			$("#hideModelId").val(model.modelId);
			$("#addEditForm").attr("action","${managerPath}/mwebsite/model/update.do");
		}		
	}});
}
	//提交表单
	$("#addEditBtn").on("click",function(){
		var vobj = $("#addEditForm").data('bootstrapValidator').validate();
		if(vobj.isValid()){
			$(this).postForm("#addEditForm",{func:function(msg) {
				if(msg.result){
					alert(postMessage);
			    	location.reload();
				}
			}});
		}
	});
	
	//删除按钮
	$("#delModelBtn").click(function(){
		//获取checkbox选中的数据
		var rows = $("#modelList").bootstrapTable("getSelections");
		//没有选中checkbox
		if(rows.length <= 0){
			<@ms.notify msg="请选择需要删除的记录" type="warning"/>
		}else{
			$(".delModel").modal();
		}
	})
	
	$("#deleteModelBtn").click(function(){
		var rows = $("#modelList").bootstrapTable("getSelections");
		$(this).text("正在删除...");
		$(this).attr("disabled","true");
		var ids = "";
		for(var i=0;i<rows.length;i++){
			if(ids == ""){
				ids = rows[i].modelId;
			}else{
				ids = ids+","+rows[i].modelId
			}
		}
		$.ajax({
			type: "post",
			url: "${managerPath}/mwebsite/model/delete.do?ids="+ids,
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
        var params = $('#modelList').bootstrapTable('getOptions');
        params.queryParams = function(params) {
        	$.extend(params,search);
	        return params;  
       	}  
   	 	$("#modelList").bootstrapTable('refresh', {query:$("form[name='searchForm']").serializeJSON()});
	}
</script>