package com.example.service.demo;

import java.util.List;
import java.util.Map;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

@FeignClient(value="service-demo-1", fallback=ServiceDemoServiceImpl.class)
public interface ServiceDemoService {

	@GetMapping("queryAll")
	public List<Map<String,Object>> queryAll();
}
