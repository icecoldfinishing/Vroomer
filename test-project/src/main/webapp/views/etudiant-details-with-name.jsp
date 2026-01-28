<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student Details with Name</title>
</head>
<body>
    <h1>Student Details</h1>
    <p>ID: ${etudiant.id}</p>
    <p>Name (from URL): ${nameFromUrl}</p>
    <p>Actual Name: ${etudiant.nom}</p>
    <p>Age: ${etudiant.age}</p>
</body>
</html>