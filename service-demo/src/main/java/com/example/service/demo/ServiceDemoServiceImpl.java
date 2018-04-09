package com.example.service.demo;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

/**
 * 实现接口，异常时执行此类方法
 * @author jason.zheng
 *
 */
@Component
public class ServiceDemoServiceImpl implements ServiceDemoService {

	@Override
	public List<Map<String, Object>> queryAll() {
		System.err.println("访问queryAll出错，执行impl中的方法，返回null");
		return null;
	}

}
