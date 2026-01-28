<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String cpath = request.getContextPath();
%>
<html>
<head>
	<title>Connexion</title>
	<style>
		body { font-family: Arial, sans-serif; margin: 2rem; }
		.card { max-width: 420px; padding: 1.5rem; border: 1px solid #ddd; border-radius: 8px; }
		.row { margin-bottom: .75rem; }
		label { display:block; font-weight: 600; margin-bottom: .25rem; }
		input, select { width: 100%; padding: .5rem; }
		.btn { padding: .5rem 1rem; background: #0d6efd; color: #fff; border: none; border-radius: 4px; cursor: pointer; }
		.muted { color: #666; }
		.error { color: #b00020; margin-bottom: .5rem; }
		nav a { margin-right: 1rem; }
	</style>
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<nav>
		<a href="<%=cpath%>/test/auth/status">Statut</a>
		<a href="<%=cpath%>/test/auth/public">Route publique</a>
		<a href="<%=cpath%>/test/auth/anonym-only">Anonym-only</a>
	</nav>
</head>
<body>
<h1>Connexion</h1>
<div class="card">
	<p class="muted">Connectez-vous pour tester les autorisations.</p>
	<p class="error">${error}</p>
	<form action="<%=cpath%>/test/auth/login" method="post">
		<div class="row">
			<label for="username">Nom d'utilisateur</label>
			<input type="text" id="username" name="username" placeholder="ex: admin" />
		</div>
		<div class="row">
			<label for="role">Rôle</label>
			<input type="text" id="role" name="role" placeholder="ex: manager, editor, ..." />
		</div>
		<button class="btn" type="submit">Se connecter</button>
	</form>
	<p class="muted" style="margin-top:.75rem;">Astuce: essayez admin/user.</p>
</div>
</body>
</html>
