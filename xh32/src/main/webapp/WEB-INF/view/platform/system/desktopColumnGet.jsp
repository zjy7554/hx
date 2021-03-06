<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<%@taglib prefix="spr" uri="http://www.springframework.org/tags"%>
<html>
<head>
	<title><spr:message code="desktopColumn.get.title" /></title>
	<%@include file="/commons/include/getById.jsp" %>
	<%-- <link  rel="stylesheet" type="text/css" href="${ctx}/js/codemirror/lib/codemirror.css" > --%>
	<f:link href="codemirror/lib/codemirror.css"></f:link>
	<script type="text/javascript" src="${ctx}/js/codemirror/lib/codemirror.js"></script>
	<script type="text/javascript" src="${ctx}/js/codemirror/mode/xml/xml.js"></script>
	<script type="text/javascript" src="${ctx}/js/codemirror/mode/javascript/javascript.js"></script>
    <script type="text/javascript" src="${ctx}/js/codemirror/mode/css/css.js"></script>
    <script type="text/javascript" src="${ctx}/js/codemirror/mode/htmlmixed/htmlmixed.js"></script>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=desktopColumn"></script>
	<script type="text/javascript">
		$(function() {
			var width = $("#html").width();
			var height = $("#html").height();
			editor = CodeMirror.fromTextArea(document.getElementById("html"), {
				mode: "text/html",
				tabMode: "indent",
				lineNumbers: true
			 });
			editor.setSize(width,height);
		});
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label"><spr:message code="desktopColumn.get.span" /></span>
			</div>
			<c:if test="${canReturn==0}">
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="list.ht"><span></span><spr:message code="menu.button.back" /></a></div>
				</div>
			</div>
			</c:if>
		</div>
		<div class="panel-body">
			<div class="panel-detail">
				<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<th width="20%"><spr:message code="desktopColumn.columnName" />:</th>
						<td>${desktopColumn.columnName}</td>
					</tr>
					<tr>
						<th width="20%"><spr:message code="desktopColumn.serviceMethod" />:</th>
						<td>${desktopColumn.serviceMethod}</td>
					</tr>
					<tr>
						<th width="20%"><spr:message code="desktopColumn.templateName" />:</th>
						<td>${desktopColumn.templateName}</td>
					</tr>
					<tr>
						<th width="20%"><spr:message code="desktopColumn.templateId" />:</th>
						<td>${desktopColumn.templateId}</td>
					</tr>
					<tr>
						<th width="20%"><spr:message code="desktopColumn.columnUrl" />:</th>
						<td>${desktopColumn.columnUrl}</td>
					</tr>
					<tr>
						<th width="20%"><spr:message code="desktopColumn.html" />:</th>
						<td ><textarea id="html" name="html" style="width: 90%;height: 220px;">${fn:escapeXml(desktopColumn.html)}</textarea></td>
					</tr>
				</table>
			</div>
		</div>
</div>
</body>
</html>
