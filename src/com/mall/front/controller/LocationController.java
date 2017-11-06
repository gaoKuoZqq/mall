package com.mall.front.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mall.pojo.Location;
import com.mall.service.LocationService;

@Controller
@RequestMapping("/location")
public class LocationController {
	@Resource(name="locationService")
	LocationService locationService;
	
	@RequestMapping("findcity")
	@ResponseBody
	public List<Location> findCityByParent_id(Integer parent_id){
		return locationService.findCityByParent_id(parent_id);
	}
	
	@RequestMapping("findarea")
	@ResponseBody
	public List<Location> findAreaByParent_id(Integer parent_id){
		return locationService.findAreaByParent_id(parent_id);
	}
}
