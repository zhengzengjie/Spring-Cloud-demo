package com.example.client;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class UserServiceImpl implements UserService {

	@Override
	public List<Map<String, Object>> queryAll() {
		System.err.println("查询queryAll异常");
		return null;
	}

	@Override
	public List<Map<String, Object>> queryAll1() {
		System.err.println("查询queryAll1异常");
		return null;
	}

}
