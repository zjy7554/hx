<%@page import="com.hotent.platform.model.system.GlobalType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.hotent.platform.model.bpm.BpmDefRights"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
    <head>
		<%@include file="/commons/include/get.jsp" %>
        <title><spr:message code="processCenter.accordingMatters"/></title>
		<f:link href="tree/zTreeStyle.css"></f:link>
		<script type="text/javascript" src="${ctx}/js/tree/jquery.ztree.js"></script>
		<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerLayout.js"></script>
		<script type="text/javascript" src="${ctx}/js/hotent/platform/form/GlobalType.js"></script>
        <script type="text/javascript">
    			var catKey="<%=GlobalType.CAT_FLOW%>";
     			var glTypeTreeUrl = __ctx+'/platform/system/globalType/getByCatKeyForBpmAccording.ht',
     			leftClickUrl= __ctx+'/platform/bpm/bpmTaskExe/accordingMattersList.ht'
         </script> 
		<script type="text/javascript" src="${ctx}/js/hotent/platform/form/GlobalTypeByFlow.js"></script>
		<style type="text/css">
			.tree-title{overflow:hidden;width:100%;}
			html,body{ padding:0px; margin:0; width:100%;height:100%;overflow: hidden;}
		</style>
    </head>
    <body>
      	<div id="defLayout" >
            <div position="left" title="<spr:message code='processCenter.processType'/>" style="overflow: auto;float:left;width:100%;height:96%;">
            	<div class="tree-toolbar">
					<span class="toolBar">
						<div class="group"><a class="link reload" id="treeFresh" href="javascript:globalType.loadGlobalTree();"  title="<spr:message code='menu.button.refresh'/>"></a></div>
						<div class="l-bar-separator"></div>
						<div class="group"><a class="link expand" id="treeExpandAll" href="javascript:treeExpandAll(true)"  title="<spr:message code='menu.button.expand'/>"></a></div>
						<div class="l-bar-separator"></div>
						<div class="group"><a class="link collapse" id="treeCollapseAll" href="javascript:treeExpandAll(false)"  title="<spr:message code='menu.button.collapse'/>"></a></div>
					</span>
				</div>
				<ul id="glTypeTree" class="ztree"></ul>
            </div>
            <div position="center">														  
          		<iframe id="defFrame" height="100%" width="100%" frameborder="0" src="${ctx}/platform/bpm/bpmTaskExe/accordingMattersList.ht"></iframe>
            </div>
        </div>
    </body>
</html>
