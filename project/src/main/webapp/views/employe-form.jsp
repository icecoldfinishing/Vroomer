<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Add Employe</title>
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

    <h2>Add New Employe (Object Binding)</h2>

    <form action="/test-project/employers/add" method="post">
        <div>
            <label for="nom">Nom:</label>
            <input type="text" id="nom" name="nom" required>
        </div>
        <div>
            <label for="salaire">Salaire:</label>
            <input type="number" id="salaire" name="salaire" step="0.01" required>
        </div>
        <div>
            <label>Skills:</label><br>
            <input type="checkbox" name="skills" value="Java"> Java<br>
            <input type="checkbox" name="skills" value="Python"> Python<br>
            <input type="checkbox" name="skills" value="SQL"> SQL<br>
            <input type="checkbox" name="skills" value="Cloud"> Cloud<br>
            <input type="checkbox" name="skills" value="Frontend"> Frontend<br>
            <input type="checkbox" name="skills" value="UI/UX"> UI/UX<br>
        </div>
        <div>
            <button type="submit">Add Employe</button>
        </div>
    </form>

    <hr>
    
    <c:if test="${not empty successMessage}">
        <p style="color: green;">${successMessage}</p>
    </c:if>

    <h3>Current Employes:</h3>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Salaire</th>
                <th>Skills</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="employe" items="${employeList}">
                <tr>
                    <td>${employe.id}</td>
                    <td>${employe.nom}</td>
                    <td>${employe.salaire}</td>
                    <td>${employe.skills}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>