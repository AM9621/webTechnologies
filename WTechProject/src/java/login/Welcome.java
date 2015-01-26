/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package login;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class Welcome extends HttpServlet {

    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
        String url = request.getParameter("url");
        
        //out.println("Welcome user " + session.getAttribute("email"));
        response.sendRedirect(request.getContextPath() + "/thoughtData/"+url);
        //response.sendRedirect("http://localhost:8080/WTechProject/thoughtData/"+url);
      }  
}