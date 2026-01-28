<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="java.net.URLEncoder" %>
            <html>

            <head>
                <title>Uploaded Files</title>
            </head>

            <body>
                <h1>Uploaded Files</h1>
                <ul>
                    <% List<String> files = (List<String>) request.getAttribute("files");
                            if (files != null && !files.isEmpty()) {
                            for (String fileName : files) {
                            %>
                            <li>
                                <a href="${pageContext.request.contextPath}/uploads/<%= URLEncoder.encode(fileName, "UTF-8").replace("+", "%20" ) %>">
                                    <%= fileName %>
                                </a>
                            </li>
                            <% } } else { %>
                                <li>No files uploaded yet.</li>
                                <% } %>
                </ul>
                <br />
                <a href="${pageContext.request.contextPath}/test/uploadForm">Upload another file</a>
            </body>

            </html>