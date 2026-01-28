<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String cpath = request.getContextPath();
%>
<html>
<head>
    <title>Route publique</title>
    <style> body { font-family: Arial, sans-serif; margin: 2rem; } nav a { margin-right: 1rem; } </style>
</head>
<body>
<nav>
    <a href="<%=cpath%>/test/auth/status">Statut</a>
    <a href="<%=cpath%>/test/auth/login">Connexion</a>
</nav>
<h1>Route publique</h1>
<p>Accessible à tous, même sans authentification.</p>
</body>
</html>
