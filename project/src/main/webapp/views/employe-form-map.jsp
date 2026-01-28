<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Ajouter un Employé (avec Map)</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        form { background-color: #f9f9f9; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); width: 400px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; }
        input[type="text"], input[type="number"] { width: calc(100% - 20px); padding: 10px; margin-bottom: 15px; border: 1px solid #ddd; border-radius: 4px; }
        .checkbox-group label { display: inline-block; margin-right: 15px; font-weight: normal; }
        input[type="submit"] { background-color: #4CAF50; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; margin-top: 15px; }
        input[type="submit"]:hover { background-color: #45a049; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #dddddd; text-align: left; padding: 8px; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>

    <h1>Ajouter un Nouvel Employé (avec Map)</h1>

    <c:if test="${not empty successMessage}">
        <p style="color: green; font-weight: bold;">${successMessage}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/employers/map-add" method="POST">
        <label for="nom">Nom de l'employé:</label>
        <input type="text" id="nom" name="nom" required value="Nouveau Employe Map"><br>

        <label for="salaire">Salaire:</label>
        <input type="number" id="salaire" name="salaire" required value="5500.00"><br>

        <label>Compétences (Skills):</label>
        <div class="checkbox-group">
            <label><input type="checkbox" name="skills" value="Java"> Java</label>
            <label><input type="checkbox" name="skills" value="Python"> Python</label>
            <label><input type="checkbox" name="skills" value="SQL"> SQL</label>
            <label><input type="checkbox" name="skills" value="Cloud"> Cloud</label>
            <label><input type="checkbox" name="skills" value="Frontend"> Frontend</label>
        </div>

        <input type="submit" value="Ajouter Employé avec Map">
    </form>

    <hr>

    <h2>Liste des Employés</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Salaire</th>
                <th>Compétences</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="emp" items="${employeList}">
                <tr>
                    <td>${emp.getId()}</td>
                    <td>${emp.getNom()}</td>
                    <td>${emp.getSalaire()}</td>
                    <td>
                        <c:forEach var="skill" items="${emp.getSkills()}" varStatus="loop">
                            ${skill}<c:if test="${!loop.last}">, </c:if>
                        </c:forEach>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>