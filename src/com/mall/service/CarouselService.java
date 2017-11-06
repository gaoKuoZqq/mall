package com.mall.service;

import java.util.List;

import com.mall.pojo.Carousel;

public interface CarouselService {
	
	boolean addCarousel(Carousel carousel);
	
	boolean deleteCarousel(Integer carousel_id);
	
	boolean modifyCarousel(Carousel carousel);
	
	List<Carousel> findCarousel();
}
