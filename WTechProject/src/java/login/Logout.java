/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package login;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;


public class Logout extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        
        response.setContentType("text/html;charset=UTF-8");
        //PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);
  
        if (session != null) {
            session.invalidate();
        }
        
        String url = request.getParameter("url");
        
        response.sendRedirect(request.getContextPath() + "/thoughtData/"+url);
        //response.sendRedirect("http://localhost:8080/WTechProject/thoughtData/"+url); 
       
    }  
    
   /*  @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
    out.println("Username or Password incorrect");
    }*/
}