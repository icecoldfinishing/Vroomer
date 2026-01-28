<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String cpath = request.getContextPath();
%>
<html>
<head>
    <title>Statut d'authentification</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 2rem; }
        nav a { margin-right: 1rem; }
        .muted { color: #666; }
    </style>
</head>
<body>
<nav>
    <a href="<%=cpath%>/test/auth/public">Route publique</a>
    <a href="<%=cpath%>/test/auth/anonym-only">Anonym-only</a>
    <a href="<%=cpath%>/test/auth/authenticated">Zone authentifiée</a>
    <a href="<%=cpath%>/test/auth/admin-only">Zone admin</a>
</nav>
<h1>Statut d'authentification</h1>
<p>Authentifié: ${authenticated}</p>
<p>Utilisateur: ${username}</p>
<p>Rôle: ${role}</p>
<p>Session ID: ${sessionId}</p>
<hr/>
<h2>Actions</h2>
<ul>
    <li><a href="<%=cpath%>/test/auth/login">Se connecter</a></li>
    <li><a href="<%=cpath%>/test/auth/logout">Se déconnecter</a></li>
</ul>
<p class="muted">Conseil: connectez-vous comme admin pour tester /admin-only.</p>
</body>
</html>
