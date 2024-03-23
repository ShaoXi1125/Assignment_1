<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 
<title>Dashboard</title>
<%@ include file="user_header.jsp" %>
</head>
<body>
<div class="container mt-3">
   <input class="form-control" type="text" id="searchInput" placeholder="Enter search keyword" oninput="searchItems()">
</div>
<div class="container mt-3">
  <h2>Items List</h2>         
  <table class="table table-hover table-bordered">
    <thead>
      <tr>
      	<th>No</th>
        <th>Product ID</th>
        <th>Product Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Quantity On Hand</th>
      </tr>
    </thead>
   <tbody>
            <c:forEach var="item" items="${itemList}" varStatus="loop">
                <tr>
                	<td>${loop.index + 1}</td>
                    <td>${item.productId}</td>
					<td>${item.productName}</td>
					<td>${item.description}</td>
					<td>${item.price}</td>
					<td>${item.quantityOnHand}</td>
                </tr>
            </c:forEach>
        </tbody>
  </table>
</div>
</body>
</html>
<script>

function searchItems() {
    let keyword = document.getElementById("searchInput").value;
    let xhr = new XMLHttpRequest();
    let url = '/search?keyword=' + encodeURIComponent(keyword);
    xhr.open('GET', url, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            let itemList = JSON.parse(xhr.responseText);
            displaySearchResults(itemList);
        }
    };
    xhr.send();
}

function displaySearchResults(itemList) {
    let tbody = document.querySelector("tbody");
    tbody.innerHTML = ""; // Clear previous search results
    for (let i = 0; i < itemList.length; i++) {
        let item = itemList[i];
        let row = "<tr>" +
                  "<td>" + (i + 1) + "</td>" +
                  "<td>" + item.productId + "</td>" +
                  "<td>" + item.productName + "</td>" +
                  "<td>" + item.description + "</td>" +
                  "<td>" + parseFloat(item.price).toFixed(2) + "</td>" + // Format price to two decimal places
                  "<td>" + item.quantityOnHand + "</td>" +
                  "<td><button class='btn' onclick='editRow(this)'>Edit</button></td>" +
                  "<td><form action='/delete/" + item.productId + "'><button type='submit' class='btn btn-danger'>Delete</button></form></td>" +
                  "</tr>";
        tbody.innerHTML += row;
    }
}

console.error();
</script>

