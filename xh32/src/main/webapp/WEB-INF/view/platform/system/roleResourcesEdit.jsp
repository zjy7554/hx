<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" import="com.hotent.platform.model.system.Resources"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	
	<%@include file="/commons/include/form.jsp" %>
	<title><spr:message code="sys.roleresource.pageTitle"/></title>
	<f:js pre="js/lang/view/platform/system" ></f:js>
	<base target="_self"/> 
	<%-- <link href="${ctx}/styles/ligerUI/ligerui-all.css" rel="stylesheet"	type="text/css" /> --%>
	<f:link href="Aqua/css/ligerui-all.css"></f:link>
	<link rel="stylesheet" href="${ctx }/js/tree/zTreeStyle.css" type="text/css" />
	<script type="text/javascript" src="${ctx}/js/tree/jquery.ztree.js"></script>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerComboBox.js"></script>
	<script type="text/javascript">
		//当前访问系统
		var systemId=null;
		//树展开层数
		var expandDepth = 2; 
		$(function()
		{
			
			//加载树
			systemId=$("#subSystem").val();
			if(systemId!=null)
				loadTree();
			//改变子系统
			$("#subSystem").change(function(){
				systemId=$("#subSystem").val();
				loadTree();
			});
			
			  $("a.save").click(save);
		});
	  
		//树
		var resourcesTree;
		//加载树
		function loadTree(){
		
			var setting = {
				data: {
					key : {
						name: "resName",
						title: "resName"
					},
					simpleData: {
						enable: true,
						idKey: "resId",
						pIdKey: "parentId",
						rootPId: <%=Resources.ROOT_PID%>
					}
				},
				view: {
					selectedMulti: true
				},
				check: {
					enable: true,
					chkboxType: { "Y": "ps", "N": "s" }
				}
				
			};
			//一次性加载
			var url="${ctx}/platform/system/resources/getSysRolResTreeChecked.ht?roleId=${roleId}&systemId="+systemId;
			
			$.post(url,function(result){
				
				resourcesTree=$.fn.zTree.init($("#resourcesTree"), setting,eval(result));
				if(expandDepth!=0)
				{
					resourcesTree.expandAll(false);
					var nodes = resourcesTree.getNodesByFilter(function(node){
						return (node.level < expandDepth);
					});
					if(nodes.length>0){
						for(var i=0;i<nodes.length;i++){
							resourcesTree.expandNode(nodes[i],true,false);
						}
					}
				}else resourcesTree.expandAll(true);
			})
				
			
			
		};
		//保存
		function save(){
			var resourcesTree = $.fn.zTree.getZTreeObj("resourcesTree");
			var nodes = resourcesTree.getCheckedNodes(true);
			var resIds="";
			$.each(nodes,function(i,n){
				if(n.resId!=<%=Resources.ROOT_ID%>)resIds+=n.resId+",";
			});
			
			resIds=resIds.substring(0,resIds.length-1);
		
			var url="${ctx}/platform/system/roleResources/upd.ht";
			var data= "roleId=${roleId}&systemId="+systemId+"&resIds="+resIds;
			$.post(url,data,function(result){
				var obj=new com.hotent.form.ResultMessage(result);
				if(obj.isSuccess()){
					$.ligerDialog.confirm($lang_system.sysRole.copy.ok,$lang.tip.msg,function(rtn){
						if(!rtn){
							window.close();
						}
					});
				}else{
					$.ligerDialog.warn($lang_system.sysRole.copy.fail);
				}
			})
		};
	</script>
<style type="text/css">
body{overflow:hidden;}
.ztree{overflow: auto;<c:if test="${systemId!=null}">height: 380px;</c:if><c:if test="${systemId==null}">height: 350px;</c:if> }
html { overflow-x: hidden; }
</style>
</head>
<body>
	<div class="panel-top">
		<div class="tbar-title">
			<span class="tbar-label"><spr:message code="sys.roleresource.title"/></span>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<div class="group"><a class="link save" id="btnSearch"><span></span><spr:message code="menu.button.save"/></a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link del" onclick="javasrcipt:window.close()"><span></span><spr:message code="menu.button.close"/></a></div>
			</div>	
		</div>
	</div>
	<div class="row" <c:if test="${systemId!=null}">style="display: none;"</c:if>>
		<div class="panel-detail">
			<table id="disSys" border="0" cellspacing="0" cellpadding="0"  class="table-detail">
				<tr>
					<td width="30%" style="text-align: right;">
						<span class="label"><spr:message code="sys.roleresource.selectSystem"/>:</span>
					</td>
					<td>
						<select id="subSystem">  
							<c:forEach var="subSystemItem" items="${subSystemList}"> 
							 <option <c:if test="${systemId==subSystemItem.systemId}">selected="selected"</c:if> value="${subSystemItem.systemId}">${subSystemItem.sysName}</option>  
					        </c:forEach>  
						</select>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="panel-detail">
		<div id="resourcesTree" class="ztree"></div>
	</div>
</body>
</html>
