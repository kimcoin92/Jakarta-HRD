<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
// form에 입력한 데이터를 화면(body)에 출력하는 코드를 작성해보시오.
%>
<script>
docuement.addEventListner('DOMContentLoaded', () =>
{
	// alert("회원정보가 저장되었습니다.")
});
</script>

<%
request.setCharacterEncoding("UTF-8");
String custno = request.getParameter("custno");
String custname = request.getParameter("custname");
String phone = request.getParameter("phone");
String address = request.getParameter("address");
String joindate = request.getParameter("joindate");
String grade = request.getParameter("grade");
String city = request.getParameter("city");
String sql = "INSERT INTO MEMBER_TBL_02 VALUES('"
		+ custno + "', '"
		+ custname + "', '"
		+ phone + "', '"
		+ address + "', '"
		+ joindate + "', '"
		+ grade + "', '"
		+ city + "');";
out.print(sql);
%>
</body>
</html>