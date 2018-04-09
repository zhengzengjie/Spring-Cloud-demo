package com.example.service.demo;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
@EnableFeignClients
@EnableDiscoveryClient
@RefreshScope
public class ServiceDemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(ServiceDemoApplication.class, args);
	}
	
	@Autowired
	private ServiceDemoService serviceDemoService;
	
	@Value("${server.port}")
	private String port;
	
	@Value("${content:abc}")
	private String content;
	
	/**
	 * 返回git上application-dev中content的值
	 * @return
	 */
	@GetMapping("test")
	public String test() {
		return "port = " + port + ", content ------ " + content;
	}
	
	/**
	 * 使用feign调用service-demo-1的接口
	 * @return
	 */
	@GetMapping("queryAll")
	public List<Map<String,Object>> queryAll() {
		return serviceDemoService.queryAll();
	}
}
