<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String cpath = request.getContextPath();
%>
<html>
<head>
    <title>Zone administrateur</title>
    <style> body { font-family: Arial, sans-serif; margin: 2rem; } nav a { margin-right: 1rem; } </style>
</head>
<body>
<nav>
    <a href="<%=cpath%>/test/auth/status">Statut</a>
    <a href="<%=cpath%>/test/auth/public">Route publique</a>
    <a href="<%=cpath%>/test/auth/authenticated">Zone authentifiée</a>
</nav>
<h1>Zone administrateur</h1>
<p>Bienvenue <strong>${username}</strong> (rôle: <strong>${role}</strong>)</p>
<p>Cette zone est réservée aux administrateurs.</p>
</body>
</html>
