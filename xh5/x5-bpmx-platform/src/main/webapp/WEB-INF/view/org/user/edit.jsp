<%--
	time:2011-11-28 10:17:09
	desc:edit the 用户表
--%>
<%@page language="java" pageEncoding="UTF-8" import="com.hotent.platform.model.system.SysUser"%>
<%@include file="/commons/include/html_doctype.html"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions"%>
<html>
<head>
<%@include file="/commons/include/form.jsp" %>
	<title><spr:message code="menu.button.edit"/><spr:message code="sysUser.title"/></title>
	<f:js pre="js/lang/view/platform/system" ></f:js>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=sysUser"></script>
	<f:link href="tree/zTreeStyle.css"></f:link>
	<script type="text/javascript" src="${ctx}/js/tree/jquery.ztree.js"></script>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerTab.js" ></script>
	<script type="text/javascript" src="${ctx}/js/hotent/displaytag.js" ></script>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerWindow.js" ></script>
   <script type="text/javascript"  src="${ctx}/js/hotent/platform/system/SysDialog.js"></script>
   <script type="text/javascript" src="${ctx}/js/hotent/platform/system/FlexUploadDialog.js"></script>
	<script type="text/javascript">
	var orgTree;    //组织树
	var posTree;    //岗位树
	var rolTree;    //角色树
	
	var orgPosTree;    //组织岗位树
	
	var h;
	var expandDepth =2; 
     
	var action="${action}";
    $(function ()
    {   
       //右键菜单,暂时去掉右键菜单
	  // getMenu();
    	h=$('body').height();
    	$("#tabMyInfo").ligerTab({         	
            	//height:h-80
          });
    	function showRequest(formData, jqForm, options)
    	{ 
			return true;
		}
    	function showResponse(responseText, statusText)  { 
    		var self=this;
    		var obj=new com.hotent.form.ResultMessage(responseText);
    		if(obj.isSuccess()){//成功
    			$.ligerDialog.confirm( obj.getMessage()+","+$lang_system.sysUser.isContinue,$lang.tip.msg,function(rtn){
    				if(rtn){
    					if(self.isReset==1){
    						window.location.reload(true);
    					}
    				}else {
    					window.location.href="${returnUrl}";
    				}
    			});
    			
    	    }else{//失败
    	    	$.ligerDialog.error( obj.getMessage(),$lang.tip.errorMsg);
    	    }
    	}
    	
    	$(".link.back").each( function() {
    		//alert($(this).attr("href"));
            //indexOf("sysUser/edit.ht") >= 0
            if ($(this).attr("href").length==0) {
            	$(this).attr("href","list.ht");
            }
        });
    	

    	//$(".link.back").attr("href","list.ht");
    	if(${sysUser.userId==null}){
			valid(showRequest,showResponse,1);
		}else{
			valid(showRequest,showResponse);
		}
		$("a.save").click(function() {
			$('#sysUserForm').submit(); 
		});
		$("#orgPosAdd").click(function(){
			btnAddRow('orgPosTree');
		});
		$("#orgPosDel").click(function(){
			btnDelRow();
		});
//		$("#posAdd").click(function(){
//			btnAddRow('posTree');
//		});
		$("#posDel").click(function(){
			btnDelRow();
		});
		
		$("#rolAdd").click(function(){
			btnAddRow('rolTree');
		});
		$("#rolDel").click(function(){
			btnDelRow();
		});
		$("#demensionId").change(function(){
			loadorgTree();
		});
		//组织刷新按钮
		$("#treeReFresh").click(function() {
			loadorgTree();
		});
         //组织展开按钮
		$("#treeExpand").click(function() {
			orgTree = $.fn.zTree.getZTreeObj("orgTree");
			var treeNodes = orgTree.transformToArray(orgTree.getNodes());
			for(var i=1;i<treeNodes.length;i++){
				if(treeNodes[i].children){
					orgTree.expandNode(treeNodes[i], true, false, false);
				}
			}
		});
		$("#treeCollapse").click(function() {
			orgTree.expandAll(false);
		});
    	if("grade"==action){
    		loadorgGradeTree();
    	}else{
    		loadorgTree();
    	}
    	//loadposTree();
    	loadrolTree();
    	
   	   var orgIds="${orgIds}";
	   if( orgIds == undefined || orgIds == null || orgIds == ""){
	   }else{
		   //编辑页面才调用此方法
		   loadorgPosTree(orgIds);
	   }
    });//function end

	//添加个人照片
	function picCallBack(fileIds,array){
		if(!array && array!="") return;
		var fileId=array[0].fileId,
			fileName=array[0].fileName;
		
		var path= __ctx + "/platform/system/sysFile/getFileById.ht?fileId=" + fileId;
		/* if(/\w+.(png|gif|jpg)/gi.test(fileName)){
			$("#picture").val("/platform/system/sysFile/getFileById.ht?fileId=" + fileId);
			$("#personPic").attr("src",path);
		}
			
		else
			$.ligerDialog.warn("请选择*png,*gif,*jpg类型图片!"); */
		var name = fileName.toLowerCase();
		if(name.indexOf(".png")>-1||name.indexOf(".gif")>-1||name.indexOf(".jpg")>-1){
			$("#picture").val("/platform/system/sysFile/getFileById.ht?fileId=" + fileId);
			$("#personPic").attr("src",path);
		}else{
			$.ligerDialog.warn($lang_system.sysUser.pictureType);
		}

				
	};
	//上传照片
	function addPic(){
		//FlexUploadDialog({isSingle:true,callback:picCallBack});
		DirectUploadDialog({isSingle:true,callback:picCallBack});
	};
	//删除照片
	function delPic(){
		$("#picture").val("");
		$("#personPic").attr("src","${ctx}/commons/image/default_image_male.jpg");
	};
	
	//生成组织树      		
	function loadorgTree(){
		var demId=$("#demensionId").val();
		var setting = {
			data: {
				key : {
					
					name: "orgName",
					title: "orgName"
				},
				simpleData: {
					enable: true,
					idKey: "orgId",
					pIdKey: "orgSupId",
					rootPId: -1
				}
			},
			async: {
				enable: true,
				url:__ctx+"/platform/system/sysOrg/getTreeData.ht?demId="+demId,
				autoParam:["orgId","orgSupId"]
			},
			view: {
				selectedMulti: true
			},
			onRightClick: false,
			onClick:false,
			check: {
				enable: true,
				chkboxType: { "Y": "", "N": "" }
			},
			callback:{
				onClick: zTreeOnCheck,
				onCheck:orgPostTreeExpand,
				onAsyncSuccess: orgTreeOnAsyncSuccess
			}
		};
		orgTree=$.fn.zTree.init($("#orgTree"), setting);
	};
	
	function zTreeOnCheck(event, treeId, treeNode) {
		var target;
		if(treeId=="rolTree"){
			target = rolTree ;
			if(treeNode.isParent){
				var children=treeNode.children;
				if(children){
					for(var i=0;i<children.length;i++){
						target.checkNode(children[i], !treeNode.checked, false, true);
					}
				}
			}
		} else if(treeId=='orgTree'){
			target = orgTree ;
		} else if(treeId=='orgPosTree'){
			target = orgPosTree ;
		}else{
			target = posTree ;
		}
		target.checkNode(treeNode, '', false, true);
	};
	//判断是否为子结点,以改变图标	
	function orgTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		if(treeNode){
	  	 	var children=treeNode.children;
		  	 if(children.length==0){
		  		treeNode.isParent=true;
		  		orgTree = $.fn.zTree.getZTreeObj("orgTree");
		  		orgTree.updateNode(treeNode);
		  	 }
		}
			var treeNodes = orgTree.transformToArray(orgTree.getNodes());
			if(treeNodes.length>0){
				treeNodes[0].nocheck = true;
				orgTree.updateNode(treeNodes[0]);
			}
	};	
	
	function loadorgGradeTree(){
		var setting = {
				data: {
					key : {
						name: "orgName",
						title: "orgName"
					}
				},
				view : {
					selectedMulti : false
				},
				onRightClick: false,
				onClick:false,
				check: {
					enable: true,
					chkboxType: { "Y": "", "N": "" }
				},
				callback:{
					onClick: zTreeOnCheck,
					onDblClick: orgTreeOnDblClick}
			};
		
		   var orgUrl=__ctx + "/platform/system/grade/getOrgJsonByUserId.ht";
		   //一次性加载
		   $.post(orgUrl,function(result){
			   var zNodes=eval("(" +result +")");
			   orgTree=$.fn.zTree.init($("#orgTree"), setting,zNodes);
			   if(expandDepth!=0)
				{
					orgTree.expandAll(false);
					var nodes = orgTree.getNodesByFilter(function(node){
						return (node.level < expandDepth);
					});
					if(nodes.length>0){
						nodes[0].nocheck = true;
						orgTree.updateNode(nodes[0]);
						for(var i=0;i<nodes.length;i++){
							orgTree.expandNode(nodes[i],true,false);
						}
					}
				}else orgTree.expandAll(true);
		   });		
	};	
    

	
	
	//勾选组织的时候展开组织岗位树
	function orgPostTreeExpand(){
		var setting = {
				data: {
					key : {
						name: "posName",
						title: "posName"
					},
				
					simpleData: {
						enable: true,
						idKey: "posId",
						pIdKey: "orgId",
						rootPId: -1
					}
				},

				view: {
					selectedMulti: true
				},
				onRightClick: false,
				onClick:false,
				check: {
					enable: true,
					chkboxType: { "Y": "", "N": "" }
				},
				callback:{
					onClick: zTreeOnCheck,
					onAsyncSuccess: zTreeOnAsyncSuccess,
					onRightClick: zTreeOnRightClick
				}
		};
		  //获取组织树的勾选节点
		  var treeObj = $.fn.zTree.getZTreeObj('orgTree');
	        var nodes = treeObj.getCheckedNodes(true);
	        var a=[];
	        for ( var key in nodes ) {
	        	a.push(nodes[key].orgId);
	        }
	       var orgIds=a.join();
	       
		  var orgUrl=__ctx + "/platform/system/position/getOrgPosTreeData.ht?orgIds="+orgIds;
		   //一次性加载
		   $.post(orgUrl,function(result){
			   orgPosTree=$.fn.zTree.init($("#orgPosTree"), setting,result);
			   orgPosTree.expandAll(true);
			   
			   //去掉父节点勾选框,???
			   var treeObj = $.fn.zTree.getZTreeObj("orgPosTree");
               var nodes = treeObj.getNodesByParam("orgId", -1, null);//为啥总是为空
			   for(var key in nodes){
			   			nodes[key].nocheck = true;
			   			orgPosTree.updateNode(nodes[key]);
			   }
		   });	
		   orgPostTree=$.fn.zTree.init($("#orgPostTree"), setting);
	}
	
	
	//生成组织岗位树      		
	  function loadorgPosTree(orgIds) {
		  var setting = {
					data: {
						key : {
							name: "posName",
							title: "posName"
						},
					
						simpleData: {
							enable: true,
							idKey: "posId",
							pIdKey: "orgId",
							rootPId: -1
						}
					},

					view: {
						selectedMulti: true
					},
					onRightClick: false,
					onClick:false,
					check: {
						enable: true,
						chkboxType: { "Y": "s", "N": "ps" }
					},
					callback:{
						onClick: zTreeOnCheck,
						onAsyncSuccess: zTreeOnAsyncSuccess,
						onRightClick: zTreeOnRightClick
					}
			};
		   
		    var orgUrl=__ctx + "/platform/system/position/getOrgPosTreeData.ht?orgIds="+orgIds;
			   //一次性加载
			   $.post(orgUrl,function(result){
				   orgPosTree=$.fn.zTree.init($("#orgPosTree"), setting,result);
				   orgPosTree.expandAll(true);

			   });	
			      orgPosTree = $.fn.zTree.init($("#orgPosTree"), setting);
	};
	
	//生成岗位树      		
	  function loadposTree() {
		  var setting = {
					data: {
						key : {
							name: "posName",
							title: "posName"
						},
					
						simpleData: {
							enable: true,
							idKey: "posId",
							pIdKey: "parentId",
							rootPId: -1
						}
					},
					async: {
						enable: true,
						url:__ctx+"/platform/system/position/getChildTreeData.ht",
						autoParam:["posId","parentId"],
						dataFilter: filter
					},
					view: {
						selectedMulti: true
					},
					onRightClick: false,
					onClick:false,
					check: {
						enable: true,
						chkboxType: { "Y": "", "N": "" }
					},
					callback:{
						onClick: zTreeOnCheck,
						onDblClick: posTreeOnDblClick,
						onAsyncSuccess: zTreeOnAsyncSuccess
					}
			};
		    posTree = $.fn.zTree.init($("#posTree"), setting);
	};	
	
	
	
	//判断是否为子结点,以改变图标	
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		if(treeNode){
	  	 var children=treeNode.children;
		  	 if(children.length==0){
		  		treeNode.isParent=true;
		  		pos_Tree = $.fn.zTree.getZTreeObj("SEARCH_BY_POS");
		  		pos_Tree.updateNode(treeNode);
		  	 }
		}
		var treeNodes = posTree.transformToArray(posTree.getNodes());
		if(treeNodes.length>0){
			//显示勾选框
			treeNodes[0].nocheck = true;
			posTree.updateNode(treeNodes[0]);
		}
	};
	
	//过滤节点,默认为父节点,以改变图标	
	function filter(treeId, parentNode, childNodes) {
			if (!childNodes) return null;
			for (var i=0, l=childNodes.length; i<l; i++) {
				if(!childNodes[i].isParent){
					alert(childNodes[i].posName);
					childNodes[i].isParent = true;
				}
			}
			return childNodes;
	};
    
	
	 //生成角色树      		
	  function loadrolTree() {
		var setting = {       				    					
			data: {
				key : {
					name: "roleName",
					title: "roleName"
				},
			
				simpleData: {
					enable: true,
					idKey: "roleId",
					pIdKey: "systemId",
					rootPId: null
				}
			},
			view: {
				selectedMulti: true
			},
			onRightClick: false,
			onClick:false,
			check: {
				enable: true,
				chkboxType: { "Y": "p", "N": "s" }
			},
			callback:{
				onClick: zTreeOnCheck,
				onDblClick: rolTreeOnDblClick}
		   };
		   
			var url="${ctx}/platform/system/sysRole/getTreeData.ht";
			$.post(url,function(result){
				rolTree=$.fn.zTree.init($("#rolTree"), setting,result);
				if(expandDepth!=0)
				{
					rolTree.expandAll(false);
					var nodes = rolTree.getNodesByFilter(function(node){
						return (node.level < expandDepth);
					});
					if(nodes.length>0){
						for(var i=0;i<nodes.length;i++){
							rolTree.expandNode(nodes[i],true,false);
						}
					}
				}else rolTree.expandAll(true);
			});
	};	
	
	
	 function btnDelRow() {
		 var $aryId = $("input[type='checkbox'][class='pk']:checked");
		 var len=$aryId.length;
		 if(len==0){
			 $.ligerDialog.warn($lang_system.sysUser.noRecord);
			 return;
		 }
		 else{			
			 $aryId.each(function(i){
					var obj=$(this);
					delrow(obj.val());
			 });
		 }
	 }
	 
	 function delrow(id)//删除行,用于删除暂时选择的行
	 {
		 $("#"+id).remove();
	 }

	
	
	
	//树按添加按钮
	function btnAddRow(treeName) {
		var treeObj = $.fn.zTree.getZTreeObj(treeName);
        var nodes = treeObj.getCheckedNodes(true);
       
        if(treeName.indexOf("orgPos")!=-1) {
        	 if(nodes==null||nodes=="")
             {
             	 $.ligerDialog.warn($lang_system.sysUser.noPosNode);
     			 return;
             }
	        $.each(nodes,function(i,n){	
	        		orgPosAddHtml(n.posId,n.posName,n.orgId,n.orgName)
	        	
			});
	    }
	    else if(treeName.indexOf("pos")!=-1){
	    	 var posId="";
			 var posName="";
			 var posDesc="";
			 var parentId="";
		     $.each(nodes,function(i,n){
		    	  posId=n.posId;
				  posName=n.posName;
				  parentId=n.parentId;
			 	  posAddHtml(posId,posName,parentId);
		     });
	    }
	    else if(treeName.indexOf("rol")!=-1){
	    	 if(nodes==null||nodes=="")
             {
             	 $.ligerDialog.warn($lang_system.sysUser.noRolNode);
     			 return;
             }
	    	 $.each(nodes,function(i,n){
				  var roleId=n.roleId;
				  if(roleId>0){
					  roleId=n.roleId;
					  roleName=n.roleName;
					  if (n.subSystem==null ||n.subSysten=="")
					  {
	    		       sysName=" ";
	    		       }
					  else{
					  sysName=n.subSystem.sysName;
					  }
					  systemId=n.systemId;
					  rolAddHtml(roleId,roleName,systemId,sysName);
				  }
	    	 });
	    }
    }
	 //组织树左键双击
	 /*
	 function orgTreeOnDblClick(event, treeId, treeNode)
	 {   
		 var orgId=treeNode.orgId;
		 var orgSupId=treeNode.orgSupId;
		 var orgName=treeNode.orgName;
		 if(treeNode.isRoot==0){
			 orgAddHtml(orgId,orgSupId,orgName);
		 }
	 };
	*/ 
	
	 function orgPosAddHtml(posId,posName,orgId,orgName){
		
		 if(orgName==null) return;//去掉父节点
		 //添加过的不再添加
		 var obj=$("#" +posId); 
         if(obj.length>0) return;
         //组织名称 
		 var tr="<tr  id='"+posId+"' style='cursor:pointer'>";
		 tr+="<td style='text-align: center;'>";
		 tr+=""+orgName+"<input  type='hidden' name='orgId' value='"+orgId+"'>";
		 tr+="</td>";
		 //岗位名称 
		 tr+="<td style='text-align: center;'>";
		 tr+=""+posName+"<input  type='hidden' name='posId' value='"+posId+"'>";
		 tr+="</td>";	
		 //主岗位
		 tr+="<td style='text-align: center;'>";
		 tr+="<input type='radio' name='posIdPrimary' value='"+posId+"' />";
		 tr+="</td>";
		 //负责人
		 tr+="<td style='text-align: center;'>";
		 tr+="<input type='checkbox' name='posIdCharge' value='"+posId+"' />";
		 tr+="</td>";
	
		 //移除
		 tr+="<td style='text-align: center;'>";
		 tr+="<a href='#' onclick='delrow(\""+posId+"\")' class='link del'>"+$lang_system.sysUser.removing+"</a>";
		 tr+="</td>";
		 
		 tr+="</tr>";
	     
		 $("#orgItem").append(tr);
		 
	 }
	 
	 function orgAddHtml(orgId,orgSupId,orgName){
		
		 if(orgSupId==-1) return;
		 var obj=$("#" +orgId); 
         if(obj.length>0) return;
         
		 var tr="<tr  id='"+orgId+"' style='cursor:pointer'>";
		 tr+="<td style='text-align: center;'>";
		 tr+=""+orgName+"<input  type='hidden' name='orgId' value='"+orgId+"'>";
		 tr+="</td>";		
		 
		 tr+="<td style='text-align: center;'>";
		 tr+="<input type='radio' name='orgIdPrimary' value='"+orgId+"' />";
		 tr+="</td>";
		 tr+="<td style='text-align: center;'>";
		 tr+="<input type='checkbox' name='chargeOrgId' value='"+orgId+"' />";
		 tr+="</td>";
	
		 
		 tr+="<td style='text-align: center;'>";
		 tr+="<a href='#' onclick='delrow(\""+orgId+"\")' class='link del'>"+$lang_system.sysUser.removing+"</a>";
		 tr+="</td>";
		 
		 tr+="</tr>";
	     
		 $("#orgItem").append(tr);
		 
	 }
	 
	 
	//岗位树左键双击
	 function posTreeOnDblClick(event, treeId, treeNode){   
		 var posId=treeNode.posId;
		 var posName=treeNode.posName;
		 var posDesc=treeNode.posDesc;
		 var parentId=treeNode.parentId;
		 posAddHtml(posId,posName,parentId);
		 
	 };
	 
	 function posAddHtml(posId,posName,parentId){
		 if(parentId==-1) return;
		 var obj=$("#" +posId);
		 if(obj.length>0) return;
		 var tr="<tr  id='"+posId+"' style='cursor:pointer'>";
		 tr+="<td style='text-align: center;'>";
		 tr+=posName +"<input type='hidden' name='posId' value='"+posId+"'>";
		 tr+="</td>";
		 tr+="<td style='text-align: center;'>";
		 tr+="<input type='radio' name='posIdPrimary' value='"+posId+"' />";
		 tr+="</td>";
		 tr+="<td style='text-align: center;'>";
		 tr+="<a href='#' onclick='delrow(\""+posId+"\")' class='link del'>"+$lang_system.sysUser.removing+"</a>";
		 tr+="</td>";
		 tr+="</tr>";
	    
		 $("#posItem").append(tr);
		 
	 }
	//角色树左键双击
	 function rolTreeOnDblClick(event, treeId, treeNode){   
		 var roleId=treeNode.roleId;
		 var roleName=treeNode.roleName;
		 var sysName = " ";
		 if(treeNode.subSystem!=null&&treeNode.subSystem!=""){
			 sysName=treeNode.subSystem.sysName;
		 }
		 var systemId=treeNode.systemId;
		 rolAddHtml(roleId,roleName,systemId,sysName);
	 };
	 
	 function rolAddHtml(roleId,roleName,systemId,sysName){
		// if( systemId==0) return;
		 var obj=$("#" +roleId);
		 if(obj.length>0) return;
		
		 var tr="<tr id='"+roleId+"' style='cursor:pointer'>";
		 tr+="<td style='text-align: center;'>";
		 tr+=""+roleName+"<input type='hidden' name='roleId' value='"+ roleId +"'>";
		 tr+="</td>";
		 tr+="<td style='text-align: center;'>";
		 tr+=""+sysName;
		 tr+="</td>";
		 tr+="<td style='text-align: center;'>";
		 tr+="<a href='#' onclick='delrow(\""+roleId+"\")' class='link del'>"+$lang_system.sysUser.removing+"</a>";
		 tr+="</td>";
		 tr+="</tr>";
	   
		 $("#rolItem").append(tr);
		
	 }	 
	//右键菜单
	 function zTreeOnRightClick(e, treeId, treeNode) {
		// alert(treeNode.orgId);
			if (treeNode.orgId=="-1") {
				orgPostTree.cancelSelectedNode();//取消节点选中状态
				menu_root.show({
					top : e.pageY,
					left : e.pageX
				});
			} else  {
				menu.show({
					top : e.pageY,
					left : e.pageX
				});
			}
		}

	//右键菜单
		function getMenu() {
			menu = $.ligerMenu({
				top : 100,
				left : 100,
				width : 100,
				items:<f:menu>
					[ {
						text : '移除',
						click : 'delNode',
						alias:'delOrg'
					}]
					</f:menu>       
			});

			menu_root = $.ligerMenu({
				top : 100,
				left : 100,
				width : 100,
				items : [ {
					text : $lang_system.sysUser.added,
					click : addNode
				}]
			});
		};
		
		//新增节点
		function addNode() {
			var treeNode=getSelectNode();
			var orgId = treeNode.posId;
			//var demId = treeNode.demId;
			var url = __ctx + "/platform/system/position/edit.ht?orgId="+ orgId;
			var url = "edit.ht?orgId=" + orgId + "&demId=" + demId + "&action=add";
			$("#viewFrame").attr("src", url);
		};
         //删除节点
		function delNode() {
			var treeNode=getSelectNode();
			var callback = function(rtn) {
				if (!rtn) return;
				var params = "orgId=" + treeNode.orgId;
				$.post("orgdel.ht", params, function() {
					orgTree.removeNode(treeNode);
				});
			};
			$.ligerDialog.confirm($lang_system.sysUser.confirmDelOrg, $lang.tip.msg, callback);

		};
	</script>
<style type="text/css">
	html{height:100%}
	body {overflow:auto;}
div.panel-body {margin: 0px;}
.table-detail th {height:40px;}
div#rMenu {
background: none repeat scroll 0 0 #F5F5F5;
border: 1px solid #979797;
overflow: hidden;
padding-bottom: 2px;
position: absolute;
z-index:9999;
}

div#rMenu ul li{
cursor: pointer;
height: 23px;
line-height: 23px;
position: relative;
width: 100%;
}
</style>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">
				<c:if test="${sysUser.userId==null }"><spr:message code="menu.button.add"/><spr:message code="sys.user.userTitle"/></c:if>
				<c:if test="${sysUser.userId!=null }"><spr:message code="menu.button.edit"/>【${sysUser.fullname}】<spr:message code="sys.user.userTitle"/></c:if>  
				</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#"><span></span><spr:message code="menu.button.save"/></a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="${returnUrl}"><span></span><spr:message code="menu.button.back"/></a></div>
				</div>
			</div>
		</div>
	   <form id="sysUserForm" method="post" action="save.ht">
		  		
            <div  id="tabMyInfo" class="panel-nav" style="overflow:hidden; position:relative;">  
	           <div title="<spr:message code='sys.user.baseInfo'/>" tabid="userdetail" icon="${ctx}/styles/default/images/resicon/user.gif">
			         
			           		<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td rowspan="<c:if test="${not empty sysUser.userId}">9</c:if><c:if test="${empty sysUser.userId}">10</c:if>" align="center" width="26%">
									<div style="float:top !important;background: none;height: 24px;padding:0px 6px 0px 112px;">
										<a class="link uploadPhoto" href="#" onclick="addPic();"><spr:message code="sysUser.uploadPhoto"/></a>
										<a class="link del" href="#" onclick="delPic();"><spr:message code="sysUser.delPhoto"/></a>
									</div>
									<div class="person_pic_div">
										<p><img id="personPic" src="${ctx}/${pictureLoad}" style="height: 378px; width:270px" alt="<spr:message code='sysUser.personalPhoto'/>" /></p>
									</div>
									</td>
									<th width="18%"><spr:message code="sysUser.account"/>: <span class="required">*</span></th>
									<td ><c:if test="${bySelf==1}"><input type="hidden" name="bySelf" value="1"></c:if><input type="text" <c:if test="${bySelf==1}">disabled="disabled"</c:if> id="account" name="account" value="${sysUser.account}" style="width:240px !important" class="inputText"/></td>
								</tr>						
																				
								<tr style="<c:if test="${not empty sysUser.userId}">display:none</c:if>">
									<th><spr:message code="sysUser.password"/>: <span class="required">*</span></th>
									<td><input type="password" id="password" name="password" value="${sysUser.password}" style="width:240px !important" class="inputText"/></td>
								</tr>
								
								<tr>
								    <th><spr:message code="sysUser.fullname"/>: <span class="required">*</span></th>
									<td ><input type="text" id="fullname" name="fullname" value="${sysUser.fullname}" style="width:240px !important" class="inputText" /></td>
								</tr>
								<tr>
									<th><spr:message code="sys.user.sex"/>: </th>
									<td>
									<select name="sex" class="select" style="width:245px !important">
											<option value="1" <c:if test="${sysUser.sex==1}">selected</c:if> ><spr:message code="sys.user.boy"/></option>
											<option value="0" <c:if test="${sysUser.sex==0}">selected</c:if> ><spr:message code="sys.user.girl"/></option>
									</select>						
									</td>
								</tr>						
								<tr>
									<th><spr:message code="sys.user.isLock"/>: </th>
									<td >								
										<select name="isLock" class="select" style="width:245px !important" <c:if test="${bySelf==1}">disabled="disabled"</c:if>>
											<option value="<%=SysUser.UN_LOCKED %>" <c:if test="${sysUser.isLock==0}">selected</c:if> ><spr:message code="sys.user.unlock"/></option>
											<option value="<%=SysUser.LOCKED %>" <c:if test="${sysUser.isLock==1}">selected</c:if> ><spr:message code="sys.user.locked"/></option>
										</select>	
									</td>				  
								</tr>
								
								<tr>
								    <th><spr:message code="sys.user.isExpired"/>: </th>
									<td >
										<select name="isExpired" class="select" style="width:245px !important" <c:if test="${bySelf==1}">disabled="disabled"</c:if>>
											<option value="<%=SysUser.UN_EXPIRED %>" <c:if test="${sysUser.isExpired==0}">selected</c:if> ><spr:message code="sys.user.unExpired"/></option>
											<option value="<%=SysUser.EXPIRED %>" <c:if test="${sysUser.isExpired==1}">selected</c:if> ><spr:message code="sys.user.expired"/></option>
										</select>
									</td>
								</tr>
								
								<tr>
								   <th><spr:message code="sys.user.state"/>: </th>
									<td>
										<select name="status"  class="select" style="width:245px !important" <c:if test="${bySelf==1}">disabled="disabled"</c:if>>
											<option value="<%=SysUser.STATUS_OK %>" <c:if test="${sysUser.status==1}">selected</c:if> ><spr:message code="sys.user.active"/></option>
											<option value="<%=SysUser.STATUS_NO %>" <c:if test="${sysUser.status==0}">selected</c:if> ><spr:message code="sys.user.unactive"/></option>
											<option value="<%=SysUser.STATUS_Del %>" <c:if test="${sysUser.status==-1}">selected</c:if>><spr:message code="menu.button.del"/></option>
										</select>
									</td>								
								</tr>						
								<tr>
								   <th><spr:message code="sysUser.email"/>: </th>
								   <td ><input type="text" id="email" name="email" value="${sysUser.email}" style="width:240px !important" class="inputText"/></td>
								</tr>
								
								<tr>
									<th><spr:message code="sysUser.mobile"/>: </th>
									<td ><input type="text" id="mobile" name="mobile" value="${sysUser.mobile}" style="width:240px !important" class="inputText"/></td>						   
								</tr>
								
								<tr>
								    <th><spr:message code="sysUser.phone"/>: </th>
									<td ><input type="text" id="phone" name="phone" value="${sysUser.phone}"  style="width:240px !important" class="inputText"/></td>
								</tr>
														
							</table>
							<input type="hidden" name="userId" value="${sysUser.userId}" />
							<input type="hidden" id="picture" name="picture" value="${sysUser.picture}" />
					
	           </div>
	           <%--不是修改本人信息则--%>
	           <c:if test="${bySelf!=1}">
	           <div title="<spr:message code='sysUser.orgPosSel'/>" tabid="orgdetail" icon="${ctx}/styles/default/images/icon/home.png">		         	         
			           
			          <table align="center"  cellpadding="0" cellspacing="0" class="table-grid table-list">
					    <tr>
				        <td width="28%" valign="top"  style="padding-left:2px !important;">
							<div class="tbar-title">
									<span class="tbar-label"><spr:message code="sysUser.allOrg"/></span> 
					        </div>
						  <div class="panel-body" style="height:520px;overflow-y:auto;">	 
								<div style="width: 100%;">
									<select id="demensionId" style="width: 99.8% !important;">
										<c:forEach var="dem" items="${demensionList}">
											<option value="${dem.demId}" <c:if test="${dem.demId==1}">selected="selected"</c:if> >${dem.demName}</option>
										</c:forEach>
									</select>
								</div>
								<div class="tree-toolbar" id="pToolbar">
									<div class="toolBar"
										style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap">
										<div class="group">
											<a class="link reload" id="treeReFresh"><spr:message code="menu.button.refresh"/></a>
										</div>
										<div class="l-bar-separator"></div>
										<div class="group">
											<a class="link expand" id="treeExpand"><spr:message code="menu.button.expand"/></a>
										</div>
										<div class="l-bar-separator"></div>
										<div class="group">
											<a class="link collapse" id="treeCollapse"><spr:message code="menu.button.collapse"/></a>
										</div>
									</div>
			                   </div> 		  
				            <ul id="orgTree" class="ztree" style="width:200px;margin:-2; padding:-2;" >         
				            </ul>    
						</div>
						</td>
						<%--组织下的岗位列表 --%>
						<td width="28%" valign="top" style="padding-left:2px !important;">
				        <div class="tbar-title">
								<span class="tbar-label"><spr:message code="sysUser.allPos"/></span>
						</div>				         
						<div class="panel-body" style="height:520px;overflow-y:auto;">	 
							<div id="orgPosTree" class="ztree" style="width:200px;margin:-2; padding:-2;" >         
				            </div>
						</div>
						</td>
						<%--组织下的岗位列表 end--%>
						<td width="3%" valign="middle"  style="padding-left:2px !important;">
						<input type="button" id="orgPosAdd" value="<spr:message code='sysUser.add'/>" />
						<br/>
						<br/>
						<br/>
						</td>
					    <td valign="top" style="padding-left:2px !important;">
			            <div class="tbar-title">
								<span class="tbar-label"><spr:message code="sys.user.org"/></span>
				         </div>
						<div style="overflow-y:auto;">
						      <table id="orgItem" class="table-grid table-list"  cellpadding="1" cellspacing="1">
						   		<thead>
						   			
						   			<th style="text-align:center !important;"><spr:message code="sys.org.orgName"/></th>
						   			<th style="text-align:center !important;"><spr:message code="sys.pos.posName"/></th>
						    		<th style="text-align:center !important;"><spr:message code="sys.isMainPos"/></th>
						    		<th style="text-align:center !important;"><spr:message code="sys.org.isDeptManager"/></th>
						    		
						    		<th style="text-align:center !important;"><spr:message code="sys.operate"/></th>
						    	</thead>
						    	<c:forEach items="${userPosList}" var="orgItem">
						    		<tr trName="${orgItem.orgName}"  id="${orgItem.orgId}" style='cursor:pointer'>
							    		
							    		<td style="text-align: center;">
						    				${orgItem.orgName}<input type="hidden" name="orgId" value="${orgItem.orgId}">					    				
						    			</td>
						    			
						    			<td style="text-align: center;">
						    				${orgItem.posName}<input type="hidden" name="posId" value="${orgItem.posId}">					    				
						    			</td>
						    			
						    			<td style="text-align: center;">					    			
						    			 <input type="radio" name="posIdPrimary" value="${orgItem.posId}" <c:if test='${orgItem.isPrimary==1}'>checked</c:if> />
						    			</td>
						    			
						    			<td style="text-align: center;">					    			
						    			 	<input type="checkbox" name="posIdCharge" value="${orgItem.posId}"  <c:if test='${orgItem.isCharge==1}'>checked</c:if>> 
						    			</td>
						    			
						    			<td style="text-align: center;">
						    			 <a href="#" onclick="delrow('${orgItem.orgId}')" class="link del"><spr:message code="sys.remove"/></a>
						    			</td>
						    		</tr>
						    	</c:forEach>
						   	 </table>
						</div>
			            </td>
			            </tr>
					 </table>
					
	        </div>
	      
	         <div  title="<spr:message code='sysUser.roleSel'/>" tabid="roldetail" icon="${ctx}/styles/default/images/resicon/customer.png">
		       
			        <table align="center"  cellpadding="0" cellspacing="0" class="table-grid">
					   <tr>
				       <td width="28%" valign="top" style="padding-left:2px !important;">
				        <div class="tbar-title">
							 <span class="tbar-label"><spr:message code="sys.user.allRole"/></span>
						</div>	
						<div class="panel-body" style="height:520px;overflow-y:auto;">	
				    	    <div id="rolTree" class="ztree" style="width:200px;margin:-2; padding:-2;" >         
				            </div>
				        </div>
						</td>
						<td width="3%" valign="middle"  style="padding-left:2px !important;">
						<input type="button" id="rolAdd" value="<spr:message code='sysUser.add'/>" />
						<br/>
						<br/>
						<br/>
						</td>
					    <td valign="top" style="padding-left:2px !important;">
					   <div class="tbar-title">
							 <span class="tbar-label"><spr:message code="sysUser.selectedRole"/></span>
						</div>	
						<div style="overflow-y:auto;">
						  <table id="rolItem" class="table-grid"  cellpadding="1" cellspacing="1">
						   		<thead>					   			
						   			<th style="text-align:center !important;"><spr:message code="sys.user.roleName"/></th>
						    		<th style="text-align:center !important;"><spr:message code="sys.user.systemName"/></th>
						    		<th style="text-align:center !important;"><spr:message code="sys.operate"/></th>
						    	</thead>
						    	<c:forEach items="${roleList}" var="rolItem">
						    		<tr trName="${rolItem.roleName}" id="${rolItem.roleId}" style="cursor:pointer">
							    		<td style="text-align: center;">
						    				${rolItem.roleName}<input type="hidden" name="roleId" value="${rolItem.roleId}">
						    			</td>
						    			<td style="text-align: center;">
						    			    ${rolItem.systemName}
						    			</td>
						    			<td style="text-align: center;">
						    			 <a href="#" onclick="delrow('${rolItem.roleId}')" class="link del"><spr:message code="sys.remove"/></a>
						    			</td>
						    		</tr>
						    	</c:forEach>
						   	 </table>
						</div>
			            </td>
			            </tr>
					 </table>
			</div>								
	      	</c:if>
	      </div>      
	  </form>
</div>
</body>
</html>
