<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Upload File</title>
</head>
<body>
    <h1>Upload a File ETU003295</h1>
    <form action="upload" method="post" enctype="multipart/form-data">
        <label for="file">Select file:</label>
        <input type="file" name="file" id="file" />
        <br/><br/>
        <button type="submit">Upload</button>
    </form>
</body>
</html>
