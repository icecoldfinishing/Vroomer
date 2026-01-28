<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Liste des Employés</title>
    <style>
        table { width: 50%; border-collapse: collapse; }
        th, td { border: 1px solid #dddddd; text-align: left; padding: 8px; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>

    <h1>Liste des Employés</h1>

    <c:if test="${not empty successMessage}">
        <p style="color: green; font-weight: bold;">${successMessage}</p>
    </c:if>

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
