
<!DOCTYPE html>
<html lang="en">
<head>
	<#include "${managerViewPath}/include/macro.ftl"/>
	<#include "${managerViewPath}/include/meta.ftl"/> 
<style> 
	 
</style>
</head>

<body>
	<@ms.content>
		<@ms.contentBody>
			<@ms.contentNav title="评论管理"></@ms.contentNav>
			<@ms.contentPanel>

					<@ms.table head=['评论ID','被评论标题','评论内容','评论用户','评论时间','操作']>
						<#if listComment?has_content>
		        			<#list listComment as comment>
		           				<tr>
						            <td class="text-center commentId" style="width: 10%">${comment.commentId?c?default(0)}</td>
						            <td class="text-center" style="width: 10%">${comment.basicTitle?default("暂无")}</td>
						            <td class="text-center" style="width: 50%"><div style="width:550px " data-toggle="tooltip" class="ms-text-hide ">${comment.commentContent?default("暂无")}</div></td>
						            <td class="text-center" style="width: 10%">${comment.peopleName?default("暂无")}</td>
						            <td class="text-center" style="width: 10%">${comment.commentTime?string("yyyy-MM-dd HH:mm:ss")}</td>
						            <td class="text-center operate" style="width: 10%">
					                    <a class="btn btn-xs tooltips deleteImg" data-toggle="tooltip" data-id="${comment.commentId?c?default(0)}" data-original-title="删除">
					                        <i class="glyphicon glyphicon-trash"></i>
					                    </a>
					                    <a class="btn btn-xs tooltips preview" data-toggle="tooltip" data-id="${comment.commentBasicId?c?default(0)}" data-original-title="预览">
					                     	<i class=" glyphicon glyphicon-globe"></i>
					                    </a>
									</td>
						        </tr>
		           			</#list>
		           		<#else>	
			           			<tr>
						            <td colspan="4" class="text-center">
						            	<@ms.nodata/>
									</td>
					          	</tr>
		           		</#if>
					</@ms.table>
					<@showPage page=page/>
			</@ms.contentPanel>
		</@ms.contentBody>
		<!--=================模态框部分开始=================-->
		<!--删除的模态框开始-->
		<@ms.modal modalName="delete" title="删除评论">
			 <@ms.modalBody>
				确定删除该评论吗？
		     </@ms.modalBody>
		     <@ms.modalButton>
	    		<@ms.button value="返回" id="closeDelete"/>  
	 			<@ms.button class="btn btn-danger" id="deleteButton" value="删除"/>  
	 		 </@ms.modalButton>
		</@ms.modal>
		<!--保存的模态框结束-->

		<!--=================模态框部分结束=================-->
	</@ms.content>
	
	<script type="text/javascript">				
	var commentId;
		//删除评论
		function deleteComment(commentId){
				var URL="${base}${baseManager}/comment/"+commentId+"/delete.do"
				$(this).request({url:URL,data:"commentId=" + commentId,type:"json",method:"post",func:function(msg) {
					//回调处理方式
					if(msg != 0) {
						alert("删除评论成功");
			    		if($("tbody tr").length==0 && msg != 1){
			    			location.href = base+"${baseManager}/comment/list.do?pageNo="+(msg-1);
						}else{
							location.href = base+"${baseManager}/comment/list.do?pageNo="+msg;
						}
			    	} else {
						alert("删除评论失败");
			    	}
				}});
			}
		
		$(function () {		
			//删除评论模态框
			$(".deleteImg").on("click",function(){
				var commentId = $(this).attr("data-id");
				$(".delete").modal();//打开
				
				$("#deleteButton").click(function(){
					deleteComment(commentId);
				});
			});
			
			//预览评论
			$("tbody").delegate(".preview","click",function(){
				var subjectId = $(this).attr("data-id");
				window.open(base+"/mbbs/"+subjectId+"/detail.do");
				//window.open(${basePath}+"/manager/cms/generate/"+commentId+"/comment.do");
			});		
			
			
			//关闭删除模态框
			$("#closeDelete").click(function(){
				$(".delete").modal("hide");//关闭
			});
			
		});	
		
	</script>
</body>
</html>
	