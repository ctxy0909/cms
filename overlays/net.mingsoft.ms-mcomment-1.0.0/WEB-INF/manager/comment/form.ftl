<@ms.html5>
	 <@ms.nav title="评论详情" back=true>
    </@ms.nav>
    <@ms.panel>
    	<@ms.form name="commentForm" isvalidation=true>
    		<@ms.hidden name="commentId" value="${(commentEntity.commentId)?default('')}"/>
    			<@ms.number label="被评论标题" name="basicTitle" value="${(commentEntity.basicTitle)?default('')}" width="240px;" readonly="false"/>
    			<@ms.number label="评论用户名" name="puNickname" value="${(commentEntity.puNickname)?default('')}" width="240px;" readonly="false"/>
    			<#if commentEntity.commentType!=2>
    			<@ms.number label="评论的类型" name="commentType" value="匿名" width="240px;" readonly="false"/>
    			<#else>
    			<@ms.number label="评论的类型" name="commentType" value="公开" width="240px;" readonly="false"/>
    			</#if>
    			<@ms.number label="评价打分" name="commentPoints" value="${(commentEntity.commentPoints)?default(0)}" width="240px;" readonly="false"/>
    			<@ms.text label="评论时间" name="commentTime" value="${((commentEntity.commentTime)?string('yyyy-MM-dd'))!}" readonly="false" width="240px;"/>
    			<@ms.editor colSm="2" name="commentContent" label="评论的内容" content="${(commentEntity.commentContent)?default('')}" validation={"required":"true","maxlength":"4000","data-bv-stringlength-message":"内容长度不能超过四千个字符长度!"}  />
    	</@ms.form>
    </@ms.panel>
</@ms.html5>

