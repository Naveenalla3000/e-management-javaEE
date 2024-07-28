<%--
  Created by IntelliJ IDEA.
  User: allanaveen
  Date: 28/07/24
  Time: 4:40 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Application Status</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
<div class="bg-white p-8 rounded shadow-lg max-w-md text-center">
    <h1 class="text-2xl font-bold mb-4">
        <span class="text-blue-600"><%= request.getAttribute("message") %></span> Mail sent...!
    </h1>
</div>
</body>
</html>
