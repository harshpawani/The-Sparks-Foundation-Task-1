<%@page import="DAO.DBCon"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <title>View Transactions</title>
        <style>
         body
        {
            margin:0;
            background: linear-gradient(#141e30, #243b55);
            background-repeat: no-repeat;
            background-size:100% 100%;
            background-attachment: fixed;
            position: relative;
        }
 </style>
    </head>
    <body>
    <jsp:include page="Navbar.jsp"/><br><br><br>
        <p><br/></p>
        <div class="row">
            <div class="col-md-4">
                <h2 style="color: white;">  View Transaction</h2>
            </div>
            <div class="col-md-4"></div>
        </div>
        <p></p>
        <table class="table table-bordered table-striped " align="center" style="color: black; box-shadow: 0 15px 25px rgba(0,0,0,.6);">
            <tr style="color: white; font-size: 16px; background-color: black; font-family: cabin;">
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Current Balance</th>
                <th class="text-center">Action</th>
            </tr>
                <% 
                    try{
                         Class.forName("com.mysql.jdbc.Driver");
                         Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/banktrans?serverTimezone=UTC","root","harsh123");
                         Statement st =conn.createStatement();
                         String data = "select * from users";
                         ResultSet rs=st.executeQuery(data);
                         while(rs.next())
                         {
                             %>
                             <tr style="color: white; font-size: 16px; font-family: arial; background: linear-gradient(#141e30, #243b55); font-family: Abril Fatface;">
                                <td><%=rs.getInt("ID")%></td>
                                <td><%=rs.getString("Name")%></td>
                                <td><%=rs.getString("Email")%></td>
                                <td><%=rs.getInt("curbal")%></td>
                                <td class="text-center">
                                    <a href='transferdetails.jsp?u=<%=rs.getString("id")%>' class="btn btn-warning">Transfer</a>
                                </td>
                                </b></tr>
                             <%
                         }
                    }
                    catch(Exception e)
                            {
                                out.println("<script type=\"text/javascript\">");
                                out.println("alert('"+e+"');");
                                out.println("location='viewtrans.jsp';");
                                out.println("</script>");
                            }
                %>
            
        </table>
    </body>
</html>
