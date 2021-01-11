<%@page import="DAO.DBCon"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
    String fr = session.getAttribute("from").toString();
	int from = Integer.parseInt(fr);
        
    String t = request.getParameter("to");
	int to = Integer.parseInt(t);
        
    String amount = request.getParameter("amt");
    int amt =  Integer.parseInt(amount);
            
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/banktrans?serverTimezone=UTC","root","harsh123");
    Statement st =conn.createStatement();
    PreparedStatement ps = null;
    
    String sql4 = "SELECT * from users where ID="+to+"";
    ResultSet rs2 = st.executeQuery(sql4);
    if(rs2.next()){String reciver = rs2.getString("Name");
    int cubal = rs2.getInt(4);
    
    String sql5 = "SELECT * from users where ID="+from+"";
    ResultSet rs1 = st.executeQuery(sql5);
        if(rs1.next()){
    int curbal = rs1.getInt(4);

    if(amt < 0)
    {
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Negative values cannot be transferred!')");
        out.println("</script>"); 
    }
    else if(amt > curbal)
    {
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Insufficient Balance!')");
        out.println("</script>");
    }
    else if(amt == 0)
    {
        out.println("<script type=\"text/javascript\">");
        out.println("alert(' Zero value cannot be transferred!')");
        out.println("</script>"); 
    }
    else
    {
        int newbal = curbal - amt;
        out.println("<script type=\"text/javascript\">");
        out.println("alert('"+newbal+"')");
        out.println("</script>"); 
        String sql1 = "UPDATE users set curbal=? where id='"+from+"'";
        ps = conn.prepareStatement(sql1);
        ps.setInt(1,newbal);
        ps.executeUpdate();
        
        int nbal = amt + cubal;
        out.println("<script type=\"text/javascript\">");
        out.println("alert('"+nbal+"')");
        out.println("</script>"); 
        String sql2 = "UPDATE users set curbal=? where id='"+to+"'";
        ps = conn.prepareStatement(sql2);
        ps.setInt(1,nbal);
        ps.executeUpdate();
        
        String sender = rs1.getString("Name");
        
        String sql3 = "INSERT INTO transaction(`sender`, `receiver`, `balance`) VALUES (?,?,?)";
        ps = conn.prepareStatement(sql3);
        ps.setString(1,sender);
        ps.setString(2,reciver);
        ps.setDouble(3,amt);
        if((ps.executeUpdate())>0)
        {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Transaction Successful!!!');");
            out.println("location='transhistory.jsp';");
            out.println("</script>"); 
        }
        
         newbal = 0;
         nbal = 0;
         amt = 0;
    }}}

%>

    </body>
</html>
