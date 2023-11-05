<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.ZoneId" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="ja_JP" />

<%!
private static Map eventMap = new HashMap();
static{
    eventMap.put("20230101","元日");
    eventMap.put("20230109","成人の日");
    eventMap.put("20230211","建国記念日");
    eventMap.put("20230223","天皇誕生日");
    eventMap.put("20230321","春分の日");
    eventMap.put("20230429","昭和の日");
    eventMap.put("20230503","憲法記念日");
    eventMap.put("20230504","みどりの日");
    eventMap.put("20230505","こどもの日");
    eventMap.put("20230717","海の日");
    eventMap.put("20230811","山の日");
    eventMap.put("20230918","敬老の日");
    eventMap.put("20230923","秋分の日");
    eventMap.put("20231009","スポーツの日");
    eventMap.put("20231103","文化の日");
    eventMap.put("20231123","勤労感謝の日");
    eventMap.put("20240101","元日");
    eventMap.put("20240109","成人の日");
    eventMap.put("20240211","建国記念日");
    eventMap.put("20240223","天皇誕生日");
}
%>

<%
String year = (String)request.getParameter("year");
String month = (String)request.getParameter("month");
String day = (String)request.getParameter("day");
LocalDate localDate = null;
if (year == null || month == null || day == null){
    localDate = LocalDate.now();
    year = String.valueOf(localDate.getYear());
    month = String.valueOf(localDate.getMonthValue());
    day = String.valueOf(localDate.getDayOfMonth());
} else {
    localDate = LocalDate.of(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day));
}
String[] dates = { year, month, day };

session.setAttribute("dates", dates);
session.setAttribute("date", Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));

String event = (String)eventMap.get(year + month + day);
session.setAttribute("event", event);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>calendar</title>
        <style>ul {list-style: none}</style>
    </head>
    <body>
        <form method="POST" action="/jsp/calendar.jsp">
            <ul>
                <li>
                    <input type="text" name="year" value="${param['year']}" />
                    <label for="year">年</label>
                    <input type="text" name="month" value="${param['month']}" />
                    <label for="month">月</label>
                    <input type="text" name="day" value="${param['day']}" />
                    <label for="day">日</label>
                </li>
                <li>
                    <input type="submit" value="送信"/>
                </li>
                <li>
                    <c:out value="${fn:join(dates, '/')}" />(<fmt:formatDate value="${date}" pattern="E" />)
                </li>
                <li>
                    <c:out value="${event}" />
                </li>
            </ul>    
        </form>
    </body>
</html>