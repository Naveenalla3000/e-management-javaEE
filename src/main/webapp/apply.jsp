<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="jakarta.servlet.http.Part" %>
<%
    // Check if the user is logged in
    if (session.getAttribute("name") == null) {
        // Redirect to login page if not logged in
        response.sendRedirect("login.jsp");
        return; // Ensure no further processing is done
    }
%>
<html>
<head>
    <title>B-Tech Course Application</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
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
<div class="rounded-lg border bg-white text-gray-800 shadow-lg w-full max-w-2xl mx-auto mt-10">
    <div class="flex flex-col space-y-1.5 p-6 bg-blue-600 text-white">
        <h3 class="text-2xl font-semibold leading-none tracking-tight">B-Tech Course Application</h3>
        <p class="text-sm">Fill out the form below to apply for our B-Tech program at KL-University.</p>
    </div>
    <div class="p-6 space-y-6">
        <form action="apply" method="POST" enctype="multipart/form-data" class="space-y-6">
            <!-- Personal Information -->
            <fieldset class="space-y-4 border-t border-gray-200 pt-4">
                <legend class="text-lg font-semibold">Personal Information</legend>
                <div class="grid gap-4 grid-cols-2">
                    <div class="space-y-2">
                        <label class="text-sm font-medium leading-none" for="fullName">Full Name</label>
                        <input
                                class="flex h-10 w-full rounded-md border border-gray-300 bg-gray-50 px-3 py-2 text-sm placeholder-gray-500 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                id="fullName"
                                name="fullName"
                                placeholder="Enter your full name"
                                required
                        />
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium leading-none" for="dob">Date of Birth</label>
                        <input
                                class="flex h-10 w-full rounded-md border border-gray-300 bg-gray-50 px-3 py-2 text-sm placeholder-gray-500 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                id="dob"
                                name="dob"
                                type="date"
                                required
                        />
                    </div>
                </div>
                <div class="space-y-2">
                    <label class="text-sm font-medium leading-none" for="contact">Contact Details</label>
                    <input
                            class="flex h-10 w-full rounded-md border border-gray-300 bg-gray-50 px-3 py-2 text-sm placeholder-gray-500 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500"
                            id="contact"
                            name="contact"
                            type="tel"
                            placeholder="Enter your contact number"
                            required
                    />
                </div>
                <div class="space-y-2">
                    <label class="text-sm font-medium leading-none" for="address">Address</label>
                    <textarea
                            class="flex w-full rounded-md border border-gray-300 bg-gray-50 px-3 py-2 text-sm placeholder-gray-500 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500 min-h-[150px]"
                            id="address"
                            name="address"
                            placeholder="Enter your address"
                            required
                    ></textarea>
                </div>
            </fieldset>

            <!-- Educational Background -->
            <fieldset class="space-y-4 border-t border-gray-200 pt-4">
                <legend class="text-lg font-semibold">Educational Background</legend>
                <div class="grid gap-4 grid-cols-2">
                    <div class="space-y-2">
                        <label class="text-sm font-medium leading-none" for="schoolName">School Name</label>
                        <input
                                class="flex h-10 w-full rounded-md border border-gray-300 bg-gray-50 px-3 py-2 text-sm placeholder-gray-500 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                id="schoolName"
                                name="schoolName"
                                placeholder="Enter your school name"
                                required
                        />
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium leading-none" for="grades">Grades</label>
                        <input
                                class="flex h-10 w-full rounded-md border border-gray-300 bg-gray-50 px-3 py-2 text-sm placeholder-gray-500 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                id="grades"
                                name="grades"
                                placeholder="Enter your grades"
                                required
                        />
                    </div>
                </div>
                <div class="space-y-2">
                    <label class="text-sm font-medium leading-none" for="completionYear">Year of Completion</label>
                    <input
                            class="flex h-10 w-full rounded-md border border-gray-300 bg-gray-50 px-3 py-2 text-sm placeholder-gray-500 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500"
                            id="completionYear"
                            name="completionYear"
                            type="number"
                            placeholder="Enter year of completion"
                            required
                    />
                </div>
            </fieldset>

            <!-- Entrance Exam Scores -->
            <fieldset class="space-y-4 border-t border-gray-200 pt-4">
                <legend class="text-lg font-semibold">Entrance Exam Scores</legend>
                <div class="space-y-2">
                    <label class="text-sm font-medium leading-none" for="examScores">Scores</label>
                    <input
                            class="flex h-10 w-full rounded-md border border-gray-300 bg-gray-50 px-3 py-2 text-sm placeholder-gray-500 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500"
                            id="examScores"
                            name="examScores"
                            placeholder="Enter your entrance exam scores"
                    />
                </div>
            </fieldset>


            <!-- Personal Statement -->
            <fieldset class="space-y-4 border-t border-gray-200 pt-4">
                <legend class="text-lg font-semibold">Personal Statement</legend>
                <div class="space-y-2">
                    <label class="text-sm font-medium leading-none" for="personalStatement">Personal Statement</label>
                    <textarea
                            class="flex w-full rounded-md border border-gray-300 bg-gray-50 px-3 py-2 text-sm placeholder-gray-500 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500 min-h-[150px]"
                            id="personalStatement"
                            name="personalStatement"
                            placeholder="Enter your personal statement"
                    ></textarea>
                </div>
            </fieldset>

            <!-- Stream and Education Level -->
            <fieldset class="space-y-4 border-t border-gray-200 pt-4">
                <legend class="text-lg font-semibold">Stream and Education Level</legend>
                <div class="grid gap-4 grid-cols-2">
                    <div class="space-y-2">
                        <label class="text-sm font-medium leading-none" for="stream">Stream</label>
                        <input
                                class="flex h-10 w-full rounded-md border border-gray-300 bg-gray-50 px-3 py-2 text-sm placeholder-gray-500 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                id="stream"
                                name="stream"
                                placeholder="Enter your stream"
                        />
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium leading-none" for="educationLevel">Education Level</label>
                        <input
                                class="flex h-10 w-full rounded-md border border-gray-300 bg-gray-50 px-3 py-2 text-sm placeholder-gray-500 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                id="educationLevel"
                                name="educationLevel"
                                placeholder="Enter your education level"
                        />
                    </div>
                </div>
            </fieldset>


            <!-- Submit Button -->
            <button
                    type="submit"
                    class="block w-full px-4 py-2 text-center text-white bg-blue-600 rounded-lg shadow hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
            >
                Submit Application
            </button>
        </form>
    </div>
</div>
</body>
</html>
