<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Order</title>
<%@ include file="user_header.jsp" %>

</head>
<body>
<div class="container">
<br>
 <form action="/createorder" method="post">
<label for="sell">Product List</label>
<div class="form-floating">
  <select class="form-select" id="sel1" name="sellist" onchange="updateQuantityOptions()">
    <c:forEach var="item" items="${itemList}" varStatus="loop">
      <option value="${item.productId}" data-quantity="${item.quantityOnHand}" data-price="${item.price}" <c:if test="${loop.index == 0}">selected</c:if>>${item.productName}</option>
    </c:forEach>
   
  </select>
   <br>
  <label for="sel1" class="form-label">Select Product (select one):</label>
  
   <label for="supplierID">Supplier:</label>
        <select id="supplierID" name="supplierID" required onchange="updateQuantityOptions()">
            <option value="">Select Supplier</option>
            <c:forEach var="supplier" items="${supplierList}">
                <option value="${supplier.supplierID}">${supplier.supplierName}</option>
            </c:forEach>
        </select><br><br>
</div>

<div>
  <label for="quantity">Quantity:</label>
<input type="number" id="quantity" name="quantity" value="1" min="1" onchange="updateQuantityOptions()" required><br><br>
 <p id="quantityAvailable">Available Quantity: <span id="availableQuantity"></span></p>
</div>

<p>Price: RM <span id="price"></span></p>
<p>Total Amount: RM <span id="totalAmount"></span></p>
<input type="hidden" id="productId" name="productId" value="">
<input type="hidden" id="supplierId" name="supplierId" value="">

<input type='submit' value='Create Order' class='btn btn-primary'>
</div>
</form>
</body>
</html>
<script>
function updateQuantityOptions() {
    let selectedProductId = document.getElementById("sel1").value;
    let selectedsupplierId = document.getElementById("supplierID").value;
   
    let selectedProduct = document.querySelector("option[value='" + selectedProductId + "']");
    let maxQuantity = selectedProduct.dataset.quantity;
    let price = selectedProduct.dataset.price; // get a price
    
    let quantityInput = document.getElementById("quantity");
    quantityInput.max = maxQuantity;
    
    document.getElementById("availableQuantity").textContent = maxQuantity;
    
    // show a price
    document.getElementById("price").textContent = price;
    
    // set the value of the hidden field to the selected product ID
    document.getElementById("productId").value = selectedProductId;
    document.getElementById("supplierId").value = selectedsupplierId;
    
    // count a total amount
    let totalAmount = price * quantityInput.value;
    document.getElementById("totalAmount").textContent = totalAmount;
}

function checkQuantity() {
    let quantityInput = document.getElementById("quantity");
    let maxQuantity = parseInt(quantityInput.max);
    let enteredQuantity = parseInt(quantityInput.value);
    
    if (enteredQuantity > maxQuantity) {
        alert("Quantity cannot exceed " + maxQuantity);
        quantityInput.value = maxQuantity;
    }
    
    updateTotalAmount();
}

function updateTotalAmount() {
    let priceText = document.getElementById("price").textContent;
    let price = parseFloat(parseFloat(priceText).toFixed(2)); 
    let quantity = parseInt(document.getElementById("quantity").value);
    let totalAmount = (price * quantity).toFixed(2); 
    document.getElementById("totalAmount").textContent = totalAmount;
}

// call updateQuantityOptions on page load to set the initial quantity options
window.onload = updateQuantityOptions;

document.getElementById("quantity").addEventListener("input", checkQuantity);


</script>
