package com.hotent.org.persistence.manager;

import java.util.List;

import com.hotent.base.api.Page;
import com.hotent.base.manager.api.Manager;
import com.hotent.org.persistence.model.DefaultDimension;
import com.hotent.org.persistence.query.DimensionQuery;

public interface DimensionManager extends Manager<String, DefaultDimension>{
	
	DefaultDimension getByDimKey(String dimKey);
	
	List<DefaultDimension> queryByCriteria(DimensionQuery.FindQuery query);
	
	List<DefaultDimension> queryByCriteria(DimensionQuery.FindQuery query, Page page);
	
	long queryCountByCriteria(DimensionQuery.FindQuery query);

	void updateByUpdateQuery(DimensionQuery.UpdateQuery uQuery);

	void deleteByDeleteQuery(DimensionQuery.DeleteQuery dQuery);
	
}
