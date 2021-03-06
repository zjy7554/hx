var $lang_form={
	bpmFormTemplate	:{
		notSameName:'模板名不能同名!',
		initConfirm:'初始化表单模板将会导致自定义模板信息丢失，确定初始化吗？'
	},
	//自定义查询
	bpmFormQuery:{
		selectTreeField:{
			selectRightInput:'请选择右边的输入框!',
			selectLeftField:'请选择左边的字段!',
			selectLeftOneField:'只能选择一个左边的字段!'
		},
		displayField:'请填写映射树的字段',
		conditionVal:'请填写条件字段的值',
		rtnField:'请选择返回字段',
		expandRightArea:'请先展开右边目标区域',
		get:{
			postParam:'POST参数',
			callMethod:'调用的方法',
			callMethodTip:'该方法定义在{0}中',
			callbackMethod:'回调方法',
			callbackMethodTip:'查询的返回值{0}是{1}类的一个实例',
			otherNotes:'其他说明',
			otherNotes1:'POST的参数中{0}是页码{1}是每页条数，分页查询时需要传递这2个参数，不传表示不进行分页查询；',
			otherNotes2:'{0}是通用表单查询别名，{1}是用作查询的字段名、字段值；',
			otherNotes3:'返回值data中，{0}存放错误信息，没有出错则为空白，{1}存放了查询的结果，{2}表示是否分页(0:不分页,1:分页),{3}和{4}分别记录了查询结果的总数和分页的总页数。'
		},
		edit:{
			selectTableView:'请先选择数据库表或视图',
			waiting_msg:'正在查询，请等待...',
			alias_validate_null:'别名不能为空',
			alias_validate_zh:'别名不能为中文',
			form_edit_fail:'编辑通用表单失败'
		}
	},
	bpmFormDialog:{
		selectTableView:'请先选择数据库表或视图',
		notView:'没有找到视图!',
		notSetColumn:'当前选择的表(视图)未设置显示的列!',
		selectTreeField:{
			selectRightInput:'请选择右边的输入框!',
			selectLeftField:'请选择左边的字段!',
			selectLeftOneField:'只能选择一个左边的字段!'
		},
		displayField:'请填写映射树的字段',
		conditionVal:'请填写条件字段的值',
		rtnField:'请选择返回字段',
		expandRightArea:'请先展开右边目标区域',
		callDialog:'对话框调用说明',
		paramDialog:'对话框参数传入',
		previewDialog:'对话框调用代码预览',
		selectDS:'请选择数据源!',
		selectDialog:'请选择参数【{0}】所要绑定的对话框！',
		selectReturnValue:'请选择参数【{0}】对应的对话框返回值！',
		dynamic_incoming:'动态传入',
		dynamic_incoming_qtip:'勾选表示此参数为动态传入的参数，否则为查询参数'
	},
	bpmFormTable:{
		resetTip:'重置操作将删除物理表，并重置表的状态为未生成。是否重置该表?',
		del:{
			mainTip:'是否删除该表吗?<br/>删除将连同子表一起删除?',
			subTip:'是否删除该表吗?'
		},
		gen:{
			mainTip:'将连同子表一起生成,是否继续?',
			subTip:'是否生成该主表?',
			success:'生成成功',
			failure:'生成失败'
		},
		exportWarn:'请选择主表进行导出！',
		ExternalTables:{
			notSameMame:'主表和子表名称不能相同！',
			saveExternalTables:'保存外部表定义失败！',
			selectTable:'请先选择一个表!',
			isExist:'此表定义已经添加',
			waiting:'正在查询数据表，请等待...',
			manage:'数据源管理'
		},
		edit:{
			backTip:'自定义表已修改，是否进行保存?',
			generatorSubToMain:'确定要生成子表吗?',
			selectMainTable:'请选择所属主表！',
			selectSubTable:'请选择子表！',
			notFields:'没有添加字段信息',
			saveFailure:'添加自定义表失败'
		}
	},
	
	
	
	//editTable.js页面
	editTable:{
		control:{
			text:'单行文本框',
			textarea:'多行文本框',
			ckeditor:'富文本框',
			dictionary:'数据字典',
			userSingle:'人员选择器(单选)',
			userMulti:'人员选择器(多选)',
			roleSingle:'角色选择器(单选)',
			roleMulti:'角色选择器(多选)',
			orgSingle:'组织选择器(单选)',
			orgMulti:'组织选择器(多选)',
			posSingle:'岗位选择器(单选)',
			posMulti:'岗位选择器(多选)',
			hidedomaid:'隐藏域',
			attachement:'文件上传',
			select:'下拉选项',
			checkbox:'复选框',
			radio:'单选按钮',
			officeControl:'office控件',
			datepicker:'日期控件',
			processInstance:'流程引用',
			webSignControl:'WebSign控件',
			pictureShowControl:'图片展示控件'
		},
		varFrom:{
			formInput:'表单输入',
			scriptDisplay:'脚本运算(显示)',
			scriptHide:'脚本运算(不显示)',
			serialNumber:'流水号'
		},
		dataType:{
			varchar:'文字',
			number:'数字',
			date:'日期',
			clob:'大文本'
		},
		uniqueName:'字段已存在',
		word:'只能为字母开头,允许字母、数字和下划线',
		quotation:'不能有引号',
		tableNameRequired:'表名必填',
		tableNameMaxlength:'表名最多 20 个字符.',
		tableDescMaxlength:'注释 最多200字符.',
		fieldNameRequired:'字段名称必填',
		digits:'填写数字',
		charLenRequired:'文字长度必填',
		intLenRequired:'整数长度必填',
		decimalLenRequired:'小数长度必填'
	},
	//fieldManage.js页面
	fieldManage:{
		notCheckedRow:'还没有选中列!',
		isRequired:'该列为必填列,不能删除!'
	},
	//BpmFormTableTeam.js页面
	bpmFormTableTeam:{
		delTeam:'删除当前分组设置?',
		moveAdd: '该字段已经添加分组,请先移除再添加!',
		selectAddTeam:'请选择要添加的分组！',
		selectTeamField:'请选择分组的字段！'
	},
	index:{
		checkedField:'请选择字段!',
		NotSpaces:'索引名不能包含空格！',
		idxName:'索引名称首字符为字母,最大长度18,只能字母数字或下划线!'
		
	},
	bpmFormDef:{
		list:{
			newFormDef:'新建表单',
			publish:'确认发布吗？',
			delFormDef:'确定删除该自定义表单吗？',
			newVersion:'确认新建版本吗？',
			setCategory:'设置分类',
			selectCategory:'请选择分类',
			setVersionNo:'设置版本号',
			message:'表单绑定的流程定义列表',
			delChoFormDef:'确认删除所选自定义表单吗?',
			delResult:'删除结果如下:',
			inputVersion:'请输入版本信息!' 
		},
		newFormDef:{
			select:'请您选择要生成的表'
		},
		edit:{
			sourceModeSave:'不能在源代码模式下保存表单',
			sourceModeNextStep:'不能在源代码模式下执行下一步',
			sourceModeActive:'不能在源代码模式下切换页面',
			sourceModeDel:'不能在源代码模式下删除页面',
			newPage:'新页面',
			page1:'页面1',
			msg_save_fail:'保存表单设计失败',
			msg_valid_fail:'验证表单设计失败',
			changeTemplateSure:'确认更换模板吗?'
		},
		designEdit:{
			valid_rule_getting:'正在获取验证规则...',
			serial_number_getting:'正在获取流水号...',
			field_used:'字段名已在使中，需要引用并设置该字段吗？',
			field_abandoned:'字段名已被弃置，需要重新引用和设置该字段吗？',
			validRule:'验证规则',
			none:'无',
			value:'值',
			option:'选项',
			column:'列数',
			row:'行数',
			checkOption:'复选框选项',
			radioOption:'单选按钮选项',
			selectOption:'下拉框选项',
			selectDictionary:'选择数据字典',
			otherSetting:'其他设定',
			singleSelect:'单选',
			showCurUser:'显示当前用户',
			inputText:'按钮文本',
			directUpLoad:'直接附件上传',
			showCurOrg:'显示当前部门',
			subTable_insert_error:'子表中不能插入子表!',
			onlyone_websigncontrol:'注意:页面只允许有一个web印章控件!',
			col:'列',
			controlWidth:'控件宽度',
			controlHeight:'控件高度',
			dataFormat:'数据格式',
			field:{
				comment:'字段注释',
				name:'字段名称',
				dataType:'数据类型'
			},
			options:{
				required:'必填',
				list:'显示到列表',
				query:'作为查询条件',
				flowVar:'是否流程变量',
				reference:'作为超连接',
				webSign:'是否支持Web印章验证'				
			},
			subTable:{
				tableName:'明细表名称',
				tableDesc:'明细表注释',
				addDataTemplate:'添加数据模式',
				displaySubTable:'默认显示子表',
				blockModel:'块模式',
				inlineModel:'行模式',
				windowModel:'弹窗模式'
			},
			aboutDate:'日期相关',
			dateString:'日期字符',
			dateFormat:'格式',
			displayDate:'当前日期字符',
			displayScript:'脚本(显示)',
			valueSource:'值来源'
		},
		dataFormat:{
			varchar:{
				length:'长度'
			},
			number:{
				thousandth:'千分位',
				coin:'货币',
				rmb:'￥人民币',
				dollar:'$美元',
				decimal_:'小数位',
				integer:'整数位'
			},
			date:{
				curDate:'当前时间'
			}
		}
	},
	//pageTab.js
	pageTab:{
		insertPage:'在当前页后插入',
		delCurPage:'删除当前页',
		newPage:'新页面',
		page:'页'
	},
	//Permission.js
	permission:{
		user:'用户',
		role:'角色',
		org:'组织',
		orgMgr:'组织负责人',
		pos:'岗位',
		everyone:'所有人',
		none:'无',
		edit:'编辑',
		required:'必填',
		readonly:'只读',
		hidden:'隐藏',
		waiting_msg:'正在加载表单权限,请稍候...'
	},
	rights:{
		initRights:'这个操作删除此表单所有相关的权限,是否确定重置权限设置?'
	},
	imp:{
		selectXml:'请选择 *.xml文件进行导入!',
		importing:'正在导入中,请稍候...',
		result:'导入结果如下:',
		failure:'导入失败!'
	},
	bpmDataTemplate:{
		save:{
			sortField:'排序字段不能设置超过3个，请检查！',
			manageField:'功能按钮出现重复的类型，请检查！'
		},
		preview:'请设置完信息保存后预览!',
		edit:{
			empty:'请设置完信息保存后编辑模板!'
		},
		filter:{
			tip1:'该脚本为 groovyScript脚本 ，返回值为可执行的sql语句',
			tip2:'其中的map为系统所封装的一个参数',
			tip3:'在脚本中使用map.get("field")可以获取表单提交时所携带的field参数值，脚本应拼接并返回任意的可执行的sql语句.返回的sql中要含有ID',
			commonCondition:'普通条件',
			alert:'请输入过滤名称或key!'
		},
		editTemplate:{
			msg_edit_fail:'编辑自定'
		},
		importData:{
			waitting_msg:'正在导入中,请稍候...',
			file_validate_msg:'请选择 *.xls或.xlsx文件进行导入!'
		},
		dateRange:'日期范围'
	},
	addResourceDialog:{
		argument:'添加资源请求，要求传入适当的参数!',
		url:'添加资源请求，要求传入要添加的资源的URL!'
	},
	Export:{
		exportAll:'导出全部数据',
		exportSelected:'导出选中数据',
		exportCurrent:'导出当前页数据',
		exportField:'导出字段',
		alert:'请选择导出的!',
		notRecord:'当前页没有记录!'
	}
};