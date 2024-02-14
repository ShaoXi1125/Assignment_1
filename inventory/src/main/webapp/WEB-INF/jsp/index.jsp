<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 
<title>Dashboard</title>
<%@ include file="header.jsp" %>
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
        <th colspan="2">Action</th>
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
					<td><button class="btn" onclick="editRow(this)">Edit</button></td>
					<td>
					 <form action="/delete/${item.productId}">
        				<button type="submit" class="btn btn-danger">Delete</button>
    				</form>
					</td>
                </tr>
            </c:forEach>
        </tbody>
  </table>
</div>
</body>
</html>
<script>
let editButton = null;

function editRow(button) {
    let row = button.parentNode.parentNode;
    let cells = row.getElementsByTagName("td");
    for (let i = 2; i < cells.length - 2; i++) { // Start from index 1 to skip the ID cell
        let cell = cells[i];
        let text = cell.innerText;
        cell.innerHTML = '<input type="text" value="' + text + '">';
    }
    editButton = row.querySelector('button');
    editButton.innerText = 'Save';
    editButton.setAttribute('onclick', 'saveRow(this)');
}

function saveRow(button) {
    let row = button.parentNode.parentNode;
    let cells = row.getElementsByTagName("td");
    let data = {};
    for (let i = 2; i < cells.length - 2; i++) { // Start from index 1 to skip the ID cell
        let cell = cells[i];
        let input = cell.querySelector('input');
        if (input === null) {
            continue; // Skip this cell if there is no input element
        }
        let value = input.value;
        if (i === 4) { // Check if it's the price cell
            if (!isValidPrice(value)) {
                alert('Invalid price format. Please enter a valid number.');
                return;
            }
            // Format price to two decimal places
            value = parseFloat(value).toFixed(2);
        }
        data["cell_" + i] = value;
        cell.innerHTML = value;
    }
    
    let productId = row.cells[1].innerText; // Assuming Product ID is in the second cell
    let url = '/update/' + productId; 
    let xhr = new XMLHttpRequest();
    xhr.open('POST', url, true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            console.log('Product updated successfully');
        }
    };
    xhr.send(JSON.stringify(data));
    
    editButton.innerText = 'Edit';
    editButton.setAttribute('onclick', 'editRow(this)');
}

function isValidPrice(price) {
    // Regular expression to match valid BigDecimal format
    let regex = /^\d+(\.\d+)?$/;
    return regex.test(price);
}

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

