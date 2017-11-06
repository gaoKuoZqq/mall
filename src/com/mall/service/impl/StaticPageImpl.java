package com.mall.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.mall.service.IStaticPageService;

import freemarker.template.Configuration;
import freemarker.template.Template;
@Service
public class StaticPageImpl implements IStaticPageService, ServletContextAware{
    @Autowired
    private FreeMarkerConfigurer freeMarkerConfigurer;
    
    //静态化方法
	public boolean productIndex(Map<String, Object> root, Integer id) {
		// 配置对象
		Configuration configuration = freeMarkerConfigurer.getConfiguration();
		Template template = null;
		freeMarkerConfigurer.setTemplateLoaderPath("/WEB-INF/ftl/");
        freeMarkerConfigurer.setDefaultEncoding("UTF-8");
		// 读取模板到内存
		try {
			template = configuration.getTemplate("product_detail.ftl");
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
    	
       Configuration conf = freeMarkerConfigurer.getConfiguration();
       //输出流   从内存写出去  磁盘上
       Writer out = null;
       try {
           //获取Html的路径
           String path = getPath("/resources/html/" + id +  ".html");
           
           File f = new File(path);
           File parentFile = f.getParentFile();
           if(!parentFile.exists()){
               parentFile.mkdirs();
           }
           //输出流
           out = new OutputStreamWriter(new FileOutputStream(f), "UTF-8");
           System.out.println("静态化输出了");
           //处理模板
           template.process(root, out);
       } catch (Exception e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
       }finally{
           if(out != null){
               try {
                  out.close();
               } catch (IOException e) {
                  // TODO Auto-generated catch block
                  e.printStackTrace();
               }
           }
       }
	return true;
    }
    
    private ServletContext servletContext;
    
    //获取路径
    public String getPath(String name){
        return servletContext.getRealPath(name);
    }
    
    public void setServletContext(ServletContext servletContext) {
       this.servletContext = servletContext;
    }


}
