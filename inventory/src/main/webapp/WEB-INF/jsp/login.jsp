<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<title>Login</title>

</head>
<body>
	<div class='container mb-3'>
        <h1>Login</h1>
       
        <form action="/login" method="post" name="login_form">
            <div class="mb-3 mt-3">
                <label for="username">Username</label>
                <input type="text" class="form-control" id="username" placeholder="Enter Username" name="username">
              </div>
              <div class="mb-3">
                <label for="pwd">Password:</label>
                <input type="password" class="form-control" placeholder="Enter password" name="password">
              </div>
        
            <input type="submit"  class="btn btn-primary" value="Login">
        </form>
    </div>
</body>
</html>
