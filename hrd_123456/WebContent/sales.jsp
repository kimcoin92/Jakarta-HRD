<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DBPKG.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원매출조회</title>
</head>
<body>
	<%@ include file="header.jsp" %>
	<h2>회원매출조회</h2>
	<!--
	1. 매출이 있는 회원만 출력한다.
	2. 회원별로 매출의 합을 출력한다.
	3. 매출이 높은 사람이 가장 위로(정렬)둔다.
	
	예) 테이블을 만든다.
	회원번호, 회원성명, 고객등급, 매출
	100001, 김행복, VIP, 8000
	
	MEMBER_TBL_02 : 회원번호, 회원성명, 고객등급
	MONEY_TBL_02 : 회원별 price의 합
	
	LEFTJOIN으로 전체 리스트에서 매출이 있는 회원만 추려낸다.
	GROUP BY로 중복되는 리스트를 하나로 만든다.
	-->
	<table border="1">
	<%
	Connection conn = null;
	Statement  stmt = null;
	ResultSet  rset = null;
	
	String custno = "";
	String custname = "";
	String grade = "";
	String price = "";
	
	try
	{
		conn = DBConnection.getConnection();
		
		String sql = "SELECT me.custno, me.custname, me.grade, sum(price)"
				   + "FROM MEMBER_TBL_02 me INNER JOIN MONEY_TBL_02 mo"
			       + "ON me.custno=mo.custno"
			       + "GROUP BY me.custno, me.custname, me.grade"
			       + "ORDER BY sum(price) DESC;";
		
		stmt = conn.createStatement();
		rset = stmt.executeQuery(sql);
		
		while(rset.next())
		{
			custno = rset.getString(1);
			custname = rset.getString(2);
			grade = rset.getString(3);
			price = rset.getString(4);
			
			switch(grade)
			{
				case "A": grade = "VIP"; break;
				case "B": grade = "일반"; break;
				case "C": grade = "직원"; break;
			}
			%>
			<tr>
				<th>회원번호</th>
				<th>회원이름</th>
				<th>회원등급</th>
				<th>매출</th>
			</tr>
			<tr>
				<td><%= custno %></td>
				<td><%= custname %></td>
				<td><%= grade %></td>
				<td><%= price %></td>
			</tr>
			<%
			
		}
	}
	catch(Exception excp)
	{
		System.out.println(excp.getMessage());
		excp.printStackTrace();
	}
	%>
	</table>
	
	<%@ include file="footer.jsp" %>
</body>
</html>