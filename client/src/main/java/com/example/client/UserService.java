package com.example.client;

import java.util.List;
import java.util.Map;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

@FeignClient(value="zuul", fallback=UserServiceImpl.class)
public interface UserService {

	@GetMapping("demo/queryAll")
	public List<Map<String,Object>> queryAll();
	
	@GetMapping("demo1/queryAll")
	public List<Map<String,Object>> queryAll1();
}
