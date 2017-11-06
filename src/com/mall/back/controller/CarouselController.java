package com.mall.back.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mall.pojo.Carousel;
import com.mall.service.CarouselService;
@Controller
@RequestMapping("/carousel")
public class CarouselController {
	@Resource(name="carouselService")
	CarouselService carouselService;
	
	@RequestMapping("/find")
	public ModelAndView findCarousel() {
		ModelAndView modelAndView = new ModelAndView();
		List<Carousel> carouselsList = carouselService.findCarousel();
		modelAndView.addObject("carouselsList",carouselsList);
		modelAndView.setViewName("carousel_find");
		return modelAndView;
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public boolean addCarousel(Carousel carousel) {
		if ((carousel.getName() == null || carousel.getName().trim().equals("")) || 
				(carousel.getProduct_id() == null)) {
			return false;
		}
		return carouselService.addCarousel(carousel);
	}
	@RequestMapping("/goadd")
	public ModelAndView goAdd(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("carousel_add");
		return modelAndView;
	}
	
	@RequestMapping("/del")
	@ResponseBody
	public Boolean deleteCarousel(Integer carousel_id) {
		return carouselService.deleteCarousel(carousel_id);
	}
	
	@RequestMapping("/modify")
	@ResponseBody
	public boolean modifyCarousel(Carousel carousel){
		if (carousel.getProduct_id() == null) {
			return false;
		}
		return carouselService.modifyCarousel(carousel);
	}
}
