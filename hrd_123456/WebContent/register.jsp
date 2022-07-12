<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="DBPKG.DBConnection" %>

<%
LocalDate today = LocalDate.now();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link href="register.css" rel="stylesheet" type="text/css"></link>
<meta charset="UTF-8">
<title>홈쇼핑 회원 등록</title>
</head>
<body>

	<%@ include file="header.jsp" %>
	<h2>홈쇼핑 회원 등록</h2>
	<form id="id_regForm" name="regForm" method="post">
		<table border="1">
		
		<%
		String maxCustno = "";
		
		try
		{
			// 1. 데이터베이스틑 연결한다.
			Connection conn = DBConnection.getConnection();
			
			String sql = "SELECT max(custno)+1 FROM MEMBER_TBL_02";
			
			// DBConnection을 이용하여 Query를 처리하는 객체
			Statement stmt = null; // Query를 처리하는 객체
			ResultSet rset = null; // Query의 결과를 저장하는 객체
			
			stmt = conn.createStatement();
			
			// Statement를 통해서 Query를 던진다.
			rset = stmt.executeQuery(sql);
			
			// cursor : ResultSet은 표 형식으로 논리적 구성. 커서는 이러한 논리적 표의 row를 가리키는 객체
			while(true == rset.next())
			{
				maxCustno = rset.getString(1);
			}
			
			// 각각의 인스턴스를 정리한다.
			rset.close();
			stmt.close();
			conn.close();
		}
		catch(Exception excp)
		{
			excp.printStackTrace();
		}
		
		// 2. DB를 Query를 전송한다.
		
		// 3. 결과값을 가져온다.
		%>
			<tr>
				<td>회원번호(자동발생)</td>
				<td><input type="text" id="id_custno" name="custno" value="<%= maxCustno %>" readonly></td>
			</tr>
			<tr>
				<td>회원성명</td>
				<td><input type="text" id="id_custname" name="custname"></td>
			</tr>
			<tr>
				<td>회원전화</td>
				<td><input type="text" id="id_phone" name="phone"></td>
			</tr>
			<tr>
				<td>회원주소</td>
				<td><input type="text" id="id_address" name="address"></td>
			</tr>
			<tr>
				<td>가입일자</td>
				<td><input type="text" id="id_joindate" name="joindate" value=<%= today %> readonly></td>
			</tr>
			<tr>
				<td>고객등급(A:VIP,B:일반,C:직원)</td>
				<td><input type="text" id="id_grade" name="grade"></td>
			</tr>
			<tr>
				<td>도시코드</td>
				<td><input type="text" id="id_city" name="city"></td>
			</tr>
		</table>
	</form>
	<button id="id_regMember">등록</button>
	<button id="id_inqMember">조회</button>
	
	<%@ include file="footer.jsp" %>
	
	<!-- <iframe name="hiddenframe" width="100px" height="100px" style="display:none"></iframe> -->
	<iframe name="hiddenframe" width="500px" height="500px"></iframe>
	
	<script>
	(function()
	{
		const frmReg = document.getElementById("id_regForm");
		
		const checkDataSize = function()
		{
			const arInputBox =
			[
				{box : document.getElementById("id_custname"), errMsg : "회원성명이 입력되지 않았습니다."},
				{box : document.getElementById("id_phone"),    errMsg : "회원전화가 입력되지 않았습니다."},
				{box : document.getElementById("id_address"),  errMsg : "회원주소가 입력되지 않았습니다."},
				{box : document.getElementById("id_joindate"), errMsg : "가입일자가 입력되지 않았습니다."},
				{box : document.getElementById("id_grade"),    errMsg : "고객등급이 입력되지 않았습니다."},
				{box : document.getElementById("id_city"),     errMsg : "도시코드가 입력되지 않았습니다."},
			];
			
			for(let i = 0; i < arInputBox.length; i++)
			{
				if(arInputBox[i].box.value.length === 0)
				{
					alert(arInputBox[i].errMsg);
					arInputBox[i].box.focus();
					return false;
				}
			}
			return true;
		}
		
		const btn_regMember = document.getElementById("id_regMember");
		const btn_inqMember = document.getElementById("id_inqMember");
		
		btn_regMember.addEventListener('click', () =>
		{
			if(true == checkDataSize())
			{
				// join.jsp : form 데이터를 받아서 DB에 저장하는 기능을 하는 jsp
				frmReg.action = "join.jsp";
				frmReg.target = "hiddenframe";
				frmReg.submit();
			}
		});
		
		id_inqMember.addEventListener('click', () =>
		{
			location.href = 'inquiry.jsp';
		});
	})();
	</script>
</body>
</html>