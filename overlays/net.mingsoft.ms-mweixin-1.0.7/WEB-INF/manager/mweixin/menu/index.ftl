<@ms.html5>
	<@ms.nav title="微信菜单管理"></@ms.nav>
	<@ms.searchForm name="searchForm" isvalidation=true>
	<@ms.text label="菜单名称" name="menuTitle" value=""  width="170px;" maxlength="20" placeholder="请输入菜单名称"/>
			<@ms.searchFormButton>
				 <@ms.queryButton onclick="search()"/> 
			</@ms.searchFormButton>			
	</@ms.searchForm>
	<@ms.panel>
		<div id="toolbar">
			<@ms.panelNavBtnGroup>
				<@ms.panelNavBtnAdd id="addMenuBtn" title=""/> 
				<@ms.panelNavBtnDel id="delMenuBtn" title=""/>
			</@ms.panelNavBtnGroup>
			<@ms.button id="create" value="发布"/> 
		</div>
		<table id="menuList" 
			data-show-refresh="true"
			data-show-columns="true"
			data-show-export="true"
			data-method="post" 
			data-pagination="true"
			data-page-size="10"
			data-side-pagination="server">
		</table>
	</@ms.panel>
	
	<@ms.modal  modalName="delMenu" title="微信菜单数据删除" >
		<@ms.modalBody style="width:450px;">删除选中的微信菜单，如果此菜单中包含子菜单，子菜单将一并删除
			<@ms.modalButton>
				<!--模态框按钮组-->
				<@ms.button  value="确认" class="btn btn-danger rightDelete"  id="deleteMenuBtn"  />
			</@ms.modalButton>
		</@ms.modalBody>
	</@ms.modal>
</@ms.html5>

<script>
	$(function(){
		$("#menuList").bootstrapTable({
			url:"${managerPath}/mweixin/menu/list.do",
			contentType : "application/x-www-form-urlencoded",
			queryParamsType : "undefined",
			toolbar: "#toolbar",
			idField: 'menuId',
			treeShowField: 'menuTitle',
            parentIdField: 'menuMenuId',
	    	columns: [{ checkbox: true},
				    	{
				        	field: 'menuId',
				        	title: '编号',
				        	align: 'center',
				        	width:'15'
				    	},{
				        	field: 'menuTitle',
				        	title: '菜单名称',
				        	width:'15',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/mweixin/menu/form.do?menuId="+row.menuId;
				        		//return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        		return "<a href=" +url+ " target='_self' style='cursor:pointer;text-decoration:none;'>" + value + "</a>";
				        	}
				    	},{
				        	field: 'menuType',
				        	title: '菜单属性',
				        	width:'10',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		switch(value){
				        			case 1: return "链接";break;
				        			case 2: return "回复";break;
				        		}
				        	}
				    	}
			]
	    })
	    setInterval("hides()",100);
	})
	function hides(){
		$(".pagination-detail").css("display","none");
	}
	//增加按钮
	$("#addMenuBtn").click(function(){
		location.href ="${managerPath}/mweixin/menu/form.do"; 
	})
	//删除按钮
	$("#delMenuBtn").click(function(){
		//获取checkbox选中的数据
		var rows = $("#menuList").bootstrapTable("getSelections");
		//没有选中checkbox
		if(rows.length <= 0){
			<@ms.notify msg="请选择需要删除的记录" type="warning"/>
		}else{
			$(".delMenu").modal();
		}
	})
	
	//发布按钮
	$("#create").click(function(){
		$(this).text("正在发布...");
		$(this).attr("disabled","true");
		$.ajax({
			type: "post",
			url: "${managerPath}/mweixin/menu/create.do",
			dataType: "json",
			contentType: "application/json",
			success:function(msg) {
				if(msg.result == true) {
					<@ms.notify msg= "发布成功" type= "success" />
					$("#create").text("发布");
					$("#create").removeAttr("disabled");
				}else {
					<@ms.notify msg= "发布失败" type= "fail" />
				}
				
			}
		})
	});
	$("#deleteMenuBtn").click(function(){
		var rows = $("#menuList").bootstrapTable("getSelections");
		$(this).text("正在删除...");
		$(this).attr("disabled","true");
		var ids = "";
		for(var i=0;i<rows.length;i++){
			if(ids == ""){
				ids = rows[i].menuId;
			}else{
				ids = ids+","+rows[i].menuId;
			}
		}
		$.ajax({
			type: "post",
			url: "${managerPath}/mweixin/menu/delete.do?ids="+ids,
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
        var params = $('#menuList').bootstrapTable('getOptions');
        params.queryParams = function(params) {  
        	$.extend(params,search);
	        return params;  
       	}  
   	 	$("#menuList").bootstrapTable('refresh', {query:$("form[name='searchForm']").serializeJSON()});
	}
</script>