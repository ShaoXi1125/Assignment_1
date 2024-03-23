<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>User Registration</title>
</head>
<body>
    <div class="container mb-3">
        <form action="/register" method="post">
            <div class="mb-3 mt-3">
                <label for="username">Username:</label>
                <input class="form-control" type="text" id="username" name="username" required>
            </div>
       
            <div class="mb-3">
                <label for="password">Password:</label>
                <input class="form-control" type="password" id="password" name="password" required>
            </div>
       
            <div class="mb-3">
                <label for="role">Role:</label>
                <select class="form-select" aria-label="Role" name="role">
                    <option selected>Open this select menu</option>
                    <option value="Admin">Admin</option>
                    <option value="User">User</option>
                </select>
                <br><br>
            </div>
       

            <input class="btn btn-primary" type="submit" value="Register">
            <input class="btn btn-danger" type="button" value="Back" onclick="window.location.href='/'">

        </form>
    </div>
 
</body>
</html>
