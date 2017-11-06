package com.mall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mall.dao.CarouselDao;
import com.mall.dao.ProductDao;
import com.mall.pojo.Carousel;
import com.mall.service.CarouselService;
@Service("carouselService")
public class CarouselServiceImpl implements CarouselService{
	@Resource(name="carouselDao")
	CarouselDao carouselDao;
	
	@Resource(name="productDao")
	ProductDao productDao;

	@Override
	public boolean addCarousel(Carousel carousel) {
		if (productDao.findProductById(carousel.getProduct_id()) == null) {
			return false;
		}
		return carouselDao.addCarousel(carousel) > 0;
	}

	@Override
	public boolean deleteCarousel(Integer carousel_id) {
		return carouselDao.deleteCarousel(carousel_id) > 0;
	}

	@Override
	public boolean modifyCarousel(Carousel carousel) {
		return carouselDao.modifyCarousel(carousel) > 0;
	}

	@Override
	public List<Carousel> findCarousel() {
		return carouselDao.findCarousel();
	}

}
