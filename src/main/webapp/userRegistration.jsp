<%@ page import="java.sql.*"%>
<% 
	String userName = request.getParameter("userName"); 
	String password = request.getParameter("password"); 
	String firstName = request.getParameter("firstName"); 
	String lastName = request.getParameter("lastName"); 
	String email = request.getParameter("email");
	Class.forName ( "org.postgresql.Driver"); 
	Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/sample", "Admin", "Admin@777");
	Statement st = con.createStatement(); 
	int i = st.executeUpdate("insert into USER(first_name, last_name, email, username, password, regdate) values ('" + firstName + "','" + lastName + "','" + email + "','" + userName + "','" + password + "', CURDATE())");
	if (i > 0) { 
				response.sendRedirect("welcome.jsp"); 
			} 
	else { 
		response.sendRedirect("index.jsp"); 
		} 
%>