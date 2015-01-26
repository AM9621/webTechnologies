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


public class Login extends HttpServlet {

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
      
        String email = request.getParameter("email");
        out.println(email);
        
        String pass = request.getParameter("pass");
        
        String url = request.getParameter("url");
         
        
        HttpSession session = request.getSession(true);
        
        
        
        if(Validate.checkUser(email, pass))
        {
            
            session.setAttribute("email", email);
            session.setAttribute("Login", "true");
            //setting session to expiry in 30 mins
            session.setMaxInactiveInterval(30*60);
            RequestDispatcher rs = request.getRequestDispatcher("Welcome");
            rs.forward(request, response);
        }
        else
        {
           
            session.setAttribute("Loginfail", "true");
            response.sendRedirect(request.getContextPath() + "/thoughtData/"+url);
            //response.sendRedirect("http://localhost:8080/WTechProject/thoughtData/"+url);
        }
       
    }  
    
   /*  @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
    out.println("Username or Password incorrect");
    }*/
}