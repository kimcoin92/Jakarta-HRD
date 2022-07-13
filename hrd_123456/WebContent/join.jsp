<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="DBPKG.DBConnection" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int result = 0;
	Connection conn = null;
	Statement stmt = null;

	request.setCharacterEncoding("UTF-8");
	String custno = request.getParameter("custno");
	String custname = request.getParameter("custname");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	String joindate = request.getParameter("joindate");
	String grade = request.getParameter("grade");
	String city = request.getParameter("city");
	String sql = "INSERT INTO MEMBER_TBL_02 VALUES(" + custno + ", " +
			"'" + custname + "', " +
			"'" + phone + "', " +  
			"'" + address + "', " +
			"'" + joindate + "', " +
			"'" + grade + "', " +
			"'" + city + "')";
	
	try
	{	
		// 1. DBConnection을 한다.
		conn = DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		// 2. Statement를 가지고 온다.
		stmt = conn.createStatement();
		
		// 3. 가져온 Statement에 sql을  executeUpdate를 시킨다.
		result = stmt.executeUpdate(sql);
		
		// 4. executeUpdate의 리턴값을 조사한다.
		System.out.println("[join.jsp] sql = " + sql);
		
		if(false == conn.getAutoCommit())
		{
			System.out.println("[join.jsp] AutoCommit : disable");
			conn.commit();
		}

	}
	catch(Exception excp)
	{
		result = 0;
		System.out.println(excp.getMessage());
	}
	finally
	{
		// html로 result를 남긴다.
		out.print("<h1 id=\"id_result\">" + result + "</h1>");
		// out.print("<h1>" + result + "</h1>");
	}
%>

<script>
(function(){
	
	const result = document.querySelector("#id_result");
	
	if(result.textContent == "1")
	{
		alert("가입이 완료되었습니다!");
		
		// 나를 포함하고 있는 페이지를 다시 로딩한다.
		parent.location.reload();
	}
	
})();
</script>
</body>
</html>