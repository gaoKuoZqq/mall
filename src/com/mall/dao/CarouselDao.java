package com.mall.dao;

import java.util.List;

import com.mall.pojo.Carousel;

public interface CarouselDao {
	
	public Integer addCarousel(Carousel carousel);
	
	public Integer deleteCarousel(Integer carousel_id);
	
	public Integer modifyCarousel(Carousel carousel);
	
	public List<Carousel> findCarousel();
}
