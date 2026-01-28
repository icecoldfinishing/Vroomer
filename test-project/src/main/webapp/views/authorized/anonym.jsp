<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String cpath = request.getContextPath();
%>
<html>
<head>
    <title>Espace anonym</title>
    <style> body { font-family: Arial, sans-serif; margin: 2rem; } nav a { margin-right: 1rem; } .muted{color:#666} </style>
</head>
<body>
<nav>
    <a href="<%=cpath%>/test/auth/status">Statut</a>
    <a href="<%=cpath%>/test/auth/login">Connexion</a>
</nav>
<h1>Espace pour utilisateurs non authentifiés</h1>
<p class="muted">Vous n'êtes pas connecté, c'est parfait pour tester cette route.</p>
</body>
</html>
