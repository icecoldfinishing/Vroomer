<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String cpath = request.getContextPath();
%>
<html>
<head>
    <title>${title}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 2rem; }
        nav a { margin-right: 1rem; }
        .badge { display:inline-block; padding:.2rem .5rem; border:1px solid #ddd; border-radius:4px; }
    </style>
</head>
<body>
<nav>
    <a href="<%=cpath%>/test/auth/status">Statut</a>
    <a href="<%=cpath%>/test/auth/logout">Déconnexion</a>
    <a href="<%=cpath%>/test/auth/public">Publique</a>
</nav>
<h1>${title}</h1>
<p>Utilisateur: <strong>${username}</strong></p>
<p>Rôle courant: <span class="badge">${role}</span></p>
<p>Rôle requis pour cette page: <span class="badge">${requiredRole}</span></p>
<%
    Object allowed = request.getAttribute("allowed");
    if (allowed != null) {
%>
    <p>Rôles autorisés: <%=allowed%></p>
<%
    }
%>
</body>
</html>
