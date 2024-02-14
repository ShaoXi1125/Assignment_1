<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta charset="utf-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<title>Add Items</title>
<%@ include file="header.jsp" %>
</head>
<body>

<div class="container mt-3">
  <h2>Add Product</h2>
  <form action="/additems" method="post">
    <div class="mb-3 mt-3">
      <label>Product Name</label>
      <input type="text" class="form-control" placeholder="Product Name" name="productName">
    </div>
    <div class="mb-3">
      <label>Description</label>
      <textarea class="form-control" rows="5" id="comment" name="description"></textarea>
    </div>
    <div class="mb-3 mt-3">
      <label>Price(MYR)</label>
      <input type="text" class="form-control" placeholder="Price(MYR)" name="price">
    </div>
    <div class="mb-3 mt-3">
      <label>Quantity On Hand</label>
      <input type="number" class="form-control" placeholder="Quantity On Hand" name="quantityOnHand">
    </div>

    <button type="submit" class="btn btn-primary">Submit</button>
  </form>
    
  
</div>
</body>
</html>