<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String cpath = request.getContextPath();
%>
<html>
<head>
    <title>Déconnexion</title>
    <style> body { font-family: Arial, sans-serif; margin: 2rem; } nav a { margin-right: 1rem; } </style>
</head>
<body>
<nav>
    <a href="<%=cpath%>/test/auth/status">Statut</a>
    <a href="<%=cpath%>/test/auth/login">Connexion</a>
</nav>
<h1>Déconnexion réussie</h1>
<p>Au revoir <strong>${username}</strong> !</p>
</body>
</html>
