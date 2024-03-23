// package com.example.inventory.config;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.context.annotation.Configuration;
// import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
// import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

// import com.example.inventory.interceptor.AuthenticationInterceptor;

// @Configuration
// public class WebMvcConfig implements WebMvcConfigurer {

//     private final AuthenticationInterceptor authenticationInterceptor;

//     @Autowired
//     public WebMvcConfig(AuthenticationInterceptor authenticationInterceptor) {
//         this.authenticationInterceptor = authenticationInterceptor;
//     }

//     @Override
//     public void addInterceptors(InterceptorRegistry registry) {
//         registry.addInterceptor(authenticationInterceptor)
//                 .addPathPatterns("/protectedPage"); // 添加需要拦截的路径
//     }
// }
