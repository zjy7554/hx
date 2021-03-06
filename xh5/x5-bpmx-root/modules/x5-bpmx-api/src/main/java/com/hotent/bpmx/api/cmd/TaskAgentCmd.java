package com.hotent.bpmx.api.cmd;

import java.util.List;

import com.hotent.bpmx.api.model.identity.BpmIdentity;

/**
 * 
 * 描述：任务代理
 * 构建组：x5-bpmx-api
 * 作者：csx
 * 邮箱:chensx@jee-soft.cn
 * 日期:2013-11-8-下午3:08:20
 * 版权：广州宏天软件有限公司版权所有
 */
public interface TaskAgentCmd extends AbstractTaskActionCmd{

	/**
	 * 
	 * @return 
	 * List<BpmIdentity>
	 * @exception 
	 * @since  1.0.0
	 */
	public List<BpmIdentity> getBpmIdentities();
	
	/**
	 * 代理与取消代理
	 * 默认为代理="agent"
	 * 取消代理="cancel-agent"
	 * @return 
	 * @return String
	 * @exception 
	 * @since  1.0.0
	 */
	public String getAgentCmdType();
	/**
	 * 备注
	 * @return 
	 * @return String
	 * @exception 
	 * @since  1.0.0
	 */
	public String getComment();
}
