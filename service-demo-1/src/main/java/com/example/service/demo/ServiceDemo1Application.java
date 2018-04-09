package com.example.service.demo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class ServiceDemo1Application {

	public static void main(String[] args) {
		SpringApplication.run(ServiceDemo1Application.class, args);
	}
	
	@Value("${server.port}")
	private String port;
	
	@Value("${content:abc}")
	private String content;
	
	/**
	 * 返回git上application-pro中content的值
	 * @return
	 */
	@GetMapping("test")
	public String test() {
		return "port = " + port + ", content ------ " + content;
	}
	
	@GetMapping("queryAll")
	public List<Map<String,Object>> queryAll(){
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String,Object> m = null;
		for(int i = 0; i < 5; i++) {
			m = new HashMap<String,Object>();
			m.put("name", "name"+i);
			m.put("age", 24+i);
			m.put("sex", i % 2 == 0 ? "女" : "男");
			list.add(m);
		}
		return list;
	}
}
