<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Applications</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-6">
<header class="px-4 lg:px-6 h-14 flex items-center bg-blue-600 text-white">
    <div class="container flex items-center justify-between">
        <a class="flex items-center justify-center" href="#">
            <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="24"
                    height="24"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    class="size-6"
            >
                <path d="m8 3 4 8 5-5 5 15H2L8 3z"></path>
            </svg>
            <span class="sr-only">Acme Inc</span>
        </a>
        <nav class="flex gap-4 sm:gap-6">
            <a class="text-sm font-medium hover:underline underline-offset-4">
                <%
                    String user = (String) session.getAttribute("name");
                    if (user != null) {
                        out.print(user); // Outputs the user's name or value stored in the session
                    } else {
                        out.print("Guest"); // Default text if no user attribute is found
                    }
                %>
            </a>
            <a class="text-sm font-medium hover:underline underline-offset-4">
                <form method="post" action="logout">
                    <button type="submit">Logout</button>
                </form>
            </a>
            <%
                String roleX = (String) session.getAttribute("role");
                String href;
                if ("admin".equals(roleX)) {
                    href = "viewall";
                } else {
                    href = "myapps";
                }
            %>
            <a href="<%= href %>" class="text-sm font-medium hover:underline underline-offset-4">
                View Applications
            </a>

        </nav>
    </div>
</header>
<h1 class="text-center text-3xl font-bold text-blue-600 mb-6 pt-4">Application List</h1>
<div class="overflow-x-auto">
    <table class="min-w-full bg-white shadow-md rounded-lg border border-gray-200">
        <thead class="bg-blue-600 text-white">
        <tr>
            <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Full Name</th>
            <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Date of Birth</th>
            <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Contact</th>
            <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Address</th>
            <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">School Name</th>
            <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Grades</th>
            <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Completion Year</th>
            <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Exam Scores</th>
            <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Stream</th>
            <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Education Level</th>
            <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Status</th>
            <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider">Action</th>
        </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
        <c:forEach var="app" items="${applications}">
            <tr>
                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${app.fullName}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${app.dob}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${app.contact}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${app.address}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${app.schoolName}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${app.grades}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${app.completionYear}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${app.examScores}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${app.stream}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${app.educationLevel}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${app.status}</td>
                <td class="px-6 py-4  whitespace-nowrap text-sm font-medium text-center">
                    <form method="post" class="mb-2" action="approve">
                        <input type="hidden" name="id" value="${app.id}">
                        <button type="submit" class="text-green-500 hover:text-green-700">Accept</button>
                    </form>
                   <form method="post" action="reject">
                        <input type="hidden" name="id" value="${app.id}">
                        <button type="submit" class="text-red-500 hover:text-green-700">Reject</button>
                   </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
