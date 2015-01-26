/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package upload;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class UploadDownloadFileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private ServletFileUpload uploader = null;
	@Override
	public void init() throws ServletException{
		DiskFileItemFactory fileFactory = new DiskFileItemFactory();
		File filesDir = (File) getServletContext().getAttribute("FILES_DIR_FILE");
		fileFactory.setRepository(filesDir);
		this.uploader = new ServletFileUpload(fileFactory);
	}
        
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fileName = request.getParameter("fileName");
		if(fileName == null || fileName.equals("")){
			throw new ServletException("File Name can't be null or empty");
		}
		File file = new File(request.getServletContext().getAttribute("FILES_DIR")+File.separator+fileName);
		if(!file.exists()){
			throw new ServletException("File doesn't exists on server.");
		}
		System.out.println("File location on server::"+file.getAbsolutePath());
		ServletContext ctx = getServletContext();
		InputStream fis = new FileInputStream(file);
		String mimeType = ctx.getMimeType(file.getAbsolutePath());
		response.setContentType(mimeType != null? mimeType:"application/octet-stream");
		response.setContentLength((int) file.length());
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
		
		ServletOutputStream os       = response.getOutputStream();
		byte[] bufferData = new byte[1024];
		int read=0;
		while((read = fis.read(bufferData))!= -1){
			os.write(bufferData, 0, read);
		}
		os.flush();
		os.close();
		fis.close();
		System.out.println("File downloaded at client successfully");
	}

        @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(!ServletFileUpload.isMultipartContent(request)){
			throw new ServletException("Content type is not multipart/form-data");
		}
		
		//response.setContentType("text/html");
		PrintWriter out = response.getWriter();
                HttpSession session = request.getSession(true);
                
                /*Project fields*/
                String title = null, description = null, overview = null, url = null, course = null, filename = null;
                String user = (String)session.getAttribute("email");
                
                
                try {
			List<FileItem> fileItemsList = uploader.parseRequest(request);
			Iterator<FileItem> fileItemsIterator = fileItemsList.iterator();
			while(fileItemsIterator.hasNext()){
				FileItem fileItem = fileItemsIterator.next();
                                
                                if(fileItem.isFormField())
                                {
                                    String fieldname = fileItem.getFieldName();
                                    String fieldvalue = fileItem.getString();
                                    
                                    if("projecttitle".equals(fieldname))
                                    {
                                      title = fieldvalue;
                
                                    }
                                    else if("projectdiscription".equals(fieldname))
                                    {
                                        description = fieldvalue;
                                    }
                                    else if("projectoverview".equals(fieldname))
                                    {
                                        overview = fieldvalue;
                                    }
                                    else if("url".equals(fieldname))
                                    {
                                        url = fieldvalue;
                                    }
                                    else if("course".equals(fieldname))
                                    {
                                        course = fieldvalue;
                                    }
                                   
                                }
                                else
                                {
                                    String forencode = fileItem.getName();
                                    
                                    //encode any special character
                                    filename = URLEncoder.encode(forencode,"UTF-8");
                                    
                                    if(checkFile.exists(filename))
                                    {
                                        session.setAttribute("Alert", "true");     
                                    }
                                    else
                                    {
                                        //System.out.println("FieldName="+fileItem.getFieldName());
                                        //System.out.println("FileName="+fileItem.getName());
                                        //System.out.println("ContentType="+fileItem.getContentType());
                                        //System.out.println("Size in bytes="+fileItem.getSize());

                                        //out.write("FieldName= "+fileItem.getFieldName());
                                        //out.write(" FileName= "+fileItem.getName());
                                        //out.write(" ContentType= "+fileItem.getContentType());
                                        //out.write(" Size in bytes= "+fileItem.getSize());

                                        File file = new File(request.getServletContext().getAttribute("FILES_DIR")+File.separator+fileItem.getName());
                                 
                                        fileItem.write(file);
                                    }
                                }
			}
		} catch (FileUploadException e) {
			out.write("Exception in uploading file. Please contact with technical support");
		} catch (Exception e) {
			out.write("Exception in uploading file. Please contact with technical support");
		}
                
                
                /*Store in DB*/
                if(!checkFile.exists(filename))
                {
                    try
                    {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/repo_course",
                        "root", "yourpassword");
                        Statement st = con.createStatement();
                    //ResultSet rs;
                        st.executeUpdate("insert into courseMaterials(course, title, description, overview, user, filename) values ('"+course+"','"+title+"','"+description+"','"+overview+"','"+user+"','"+filename+"')");

                    }   
                    catch(Exception e){
                        //Database exception
                        out.write("Database Exception in uploading file. Please contact with technical support");
                    }
                    session.setAttribute("Upload", "true");
                }
                
              
                
                response.sendRedirect(request.getContextPath() + "/thoughtData/"+url);
                //response.sendRedirect("http://localhost:8080/WTechProject/thoughtData/"+url);
             
	}
}