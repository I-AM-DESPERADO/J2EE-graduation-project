package com.pzy.jcook.workflow.service.nofy;

import java.io.IOException;
import java.util.Map;

public interface NofyService {
	public void	send(Map<String,Object> map) throws IOException;
}
