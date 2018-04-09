package com.example.client;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.netflix.hystrix.EnableHystrix;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@SpringBootApplication
@EnableDiscoveryClient
@EnableFeignClients
@EnableHystrix
@Controller
public class ClientApplication {

	public static void main(String[] args) {
		SpringApplication.run(ClientApplication.class, args);
	}
	
	@Autowired
	private UserService userService;
	
	@GetMapping("/")
	public String home() {
		return "index";
	}
	
	@PostMapping("user/queryAll")
	@ResponseBody
	public List<Map<String,Object>> queryAll(){
		return userService.queryAll();
	}
	
	@PostMapping("user/queryAll1")
	@ResponseBody
	public List<Map<String,Object>> queryAll1(){
		return userService.queryAll1();
	}
}
