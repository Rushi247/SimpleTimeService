package com.example.simpletimeservice;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.Map;

@RestController
public class TimeController {

	@GetMapping("/")
	public Map<String, String> getTimeAndIp(HttpServletRequest request) {
	    Map<String, String> response = new LinkedHashMap<>();

	    // Get IP from header first
	    String ip = request.getHeader("X-Forwarded-For");
	    if (ip == null || ip.isEmpty()) {
	        ip = request.getRemoteAddr();
	    } else {
	        // In case of multiple IPs, take the first
	        ip = ip.split(",")[0].trim();
	    }

	    // Normalize local loopback
	    if ("0:0:0:0:0:0:0:1".equals(ip) || "::1".equals(ip)) {
	        ip = "127.0.0.1";
	    }

	    String timestamp = LocalDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME);
	    response.put("timestamp", timestamp);
	    response.put("ip", ip);
		
	    return response;
		
	}

}
