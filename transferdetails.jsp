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
        h2 
        {
            margin: 0 0 30px;
            padding: 0;
            color: #fff;
            text-align: center;
        }
 body
        {
            margin:0;
            background: linear-gradient(#141e30, #243b55);
            background-repeat: no-repeat;
            background-size:100% 100%;
            background-attachment: fixed;
            position: relative;
        }
        .h
        {
            margin-top:20px;
            font-size: 55px;
            font-family: 'Lobster';
            background-color:blueviolet;
            color:white;
            overflow:hidden;
            display:block;
        }
        .input
        {
            width: 320px;
            height: 31px;
        }
        h3
        {
            color:#FC8D07;
        }
        .button{
          position: relative;
          align-items: center;
          height: 50px;
          width: 150px;
          border: none;
          outline: none;
          color: cyan;
          background: transparent;
          text-transform: uppercase;
          cursor: pointer;
          border-radius: 5px;
          overflow: hidden;
          transition: .5s;
          font-size: 20px;
          font-family: 'Raleway', sans-serif;
        }

        .button:hover {
          background: #03e9f4;
          color: #fff;
          border-radius: 5px;
          box-shadow: 0 0 5px #03e9f4,
                      0 0 25px #03e9f4,
                      0 0 50px #03e9f4,
                      0 0 100px #03e9f4;
        }
        p,pre
        {
            font-size: 16px;
        }
        label
        {
            font-family:Trebuchet MS;
            font-size: 18px;
            color:#f4f4f5;
        }
        h3
        {
            font-family:Trebuchet MS;
            color:#34495e;
        }
 </style>
    </head>
    <body>
    <jsp:include page="Navbar.jsp"/><br><br><br>
        <p><br/></p>
        <p></p>
        <table class="table table-bordered table-striped " align="center" style="color: black; box-shadow: 0 15px 25px rgba(0,0,0,.6);">
            <tr style="color: white; font-size: 16px; background-color: black; font-family: cabin;">
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Current Balance</th>
            </tr>
                <% 
                    try{
                         Class.forName("com.mysql.jdbc.Driver");
                         Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/banktrans?serverTimezone=UTC","root","harsh123");
                         Statement st =conn.createStatement();
                         String u = request.getParameter("u");
                         int num = Integer.parseInt(u);
                         String s1 = request.getParameter("u");
                         session.setAttribute("from",s1);
                         String data = "select * from users where ID='"+num+"'";
                         ResultSet rs=st.executeQuery(data);
                         while(rs.next())
                         {
                             %>
                             <tr style="color: white; font-size: 16px; font-family: arial; background: linear-gradient(#141e30, #243b55); font-family: Abril Fatface;">
                                <td><%=rs.getInt("ID")%></td>
                                <td><%=rs.getString("Name")%></td>
                                <td><%=rs.getString("Email")%></td>
                                <td><%=rs.getInt("curbal")%></td>
                                </b></tr>
                             <%
                         }
                    }
                    catch(Exception e)
                            {
                                out.println("<script type=\"text/javascript\">");
                                out.println("alert('"+e+"');");
                                out.println("location='ViewTrans.jsp';");
                                out.println("</script>");
                            }
                %>
        </table><br><br>
        <center>
           <div style="
            width: 600px;
            box-sizing: border-box;
            background: rgba(0,0,0,.5);
            box-shadow: 0 15px 25px rgba(0,0,0,.6);
            border-radius: 10px;"><br><br>
               
            <form action="transDB.jsp" method="POST">
                <h2></h2>
                <label>Transfer To: </label>&nbsp&nbsp&nbsp&nbsp&nbsp
                    <select name="to" >&nbsp&nbsp&nbsp&nbsp&nbsp
                        <option value="" disabled selected>Choose</option>
                            <%try{
                                    Connection conn = DAO.DBCon.getConnection();
                                    Statement st=conn.createStatement();
                                    ResultSet rs=st.executeQuery("select * from users");
                                    while(rs.next())
                                    {%>
                                        <option class="table" value="<%=rs.getInt("ID")%>" >

                                            <%=rs.getString("Name")%> (Balance: 
                                            <%=rs.getInt("curbal")%> ) 

                                        </option>
                                    <%}
                            %>
                        </select><br><br>
                <label>Amount: </label>&nbsp&nbsp&nbsp&nbsp&nbsp
                <input type="number" name="amt" placeholder="Enter Amount"/><br><br>
                <button type="submit"  class="button">Transfer</button><br><br>
           </form>  
            </div>
            </center>       <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
  
</body>
</html>
<%
}catch(Exception e){}
%>
