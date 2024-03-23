// package com.example.inventory.interceptor;

// import javax.servlet.http.HttpServletRequest;
// import javax.servlet.http.HttpServletResponse;

// import org.springframework.web.servlet.HandlerInterceptor;
// import org.springframework.web.servlet.ModelAndView;

// public class AuthenticationInterceptor implements HandlerInterceptor {
//     @Override
//     public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//         String requestURI = request.getRequestURI();
//         if (requestURI.contains("/dashboard") || requestURI.contains("/additems")) {
//             if (request.getSession().getAttribute("username") == null) {
//                 response.sendRedirect("/protectedPage");
//                 return false;
//             }
//         }
//         return true;
//     }

//     @Override
//     public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    
//     }

//     @Override
//     public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
 
//     }
    
// }
