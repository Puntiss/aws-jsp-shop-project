<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="com.appa.bean.ProductBean,com.appa.model.Product,java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>Brand Name</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<style>
	.label-top {
		position: absolute;
		color: #fff;
		top: 8px;
		right: 8px;
		padding: 5px 10px 5px 10px;
		font-size: .7rem;
		font-weight: 600;
		border-radius: 3px;
		text-transform: uppercase
	}
</style>
<body>
	<%
	ProductBean productBean = new ProductBean();
	String filter = (String) request.getParameter("filter");
	
	if (filter != null) {
		productBean.setFilter(filter);
		productBean.filterProducts();
	}
	
	ArrayList<String> categoryList = new ArrayList<String>();
  	for(Product p : productBean.getProducts())
  		if(!categoryList.contains(p.getCategory()))
  			categoryList.add(p.getCategory());
	
	
	%>
	<div class="container">
	
		<form action="./index.jsp" method="get">
			<nav class="navbar navbar-light bg-light justify-content-between">
				<a class="navbar-brand">Brand Name</a>		
				<div class="form-inline">
					<div class="row">
					  <div class="col-sm">
						  <input class="form-control" type="search" name="filter" style="margin-bottom: 10px;"
									placeholder="Name" <%=filter!=null?"value=\""+filter+"\"":""%> >
					  </div>
					  <div class="col-sm">
						  <div class="btn-group" style="display: block !important;">
						  <button type="button" class="btn btn-primary dropdown-toggle" style="width: 100%;" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						    Category
						  </button>
						  <div class="dropdown-menu">
						  	<table style="margin-left:10px">
							  	<%
								for(String s : categoryList){
								%>
								<tr>
									<td>
									  <input type="checkbox" value="true" name="<%=s%>Filter" id="<%=s%>Filter"
									  <% if(request.getParameter(s+"Filter")!=null && request.getParameter(s+"Filter").equals("true")) out.print("checked"); %>
									</td>	
									<td>	
									  <label class="form-check-label">
									  	<%
									  	String tmp = Character.toUpperCase(s.charAt(0)) + s.substring(1);
									  	out.print(tmp);
									  	%>
									  </label>
									 </td>	  
								</tr>	  
								<%
								}
								%>
							</table>
						    <div class="dropdown-divider"></div>
						    <table style="margin-left:10px">
						    	<tr>
						    		<td>
								    	<input type="checkbox" value="true" name="saleFilter" id="saleFilter"
								    	 <% if(request.getParameter("saleFilter")!=null && request.getParameter("saleFilter").equals("true")) out.print("checked"); %>>
								    </td>	
									<td>
										<label class="form-check-label">In Sale</label>
								   	 </td>	  
								</tr>
								<tr>
									<td>
										<input type="checkbox" value="true" name="soldOutFilter" id="soldOutFilter"
										<% if(request.getParameter("soldOutFilter")!=null && request.getParameter("soldOutFilter").equals("true")) out.print("checked"); %>>
									</td>	  
									<td>
										<label class="form-check-label">Sold Out</label>
									 </td>	  
								</tr>
							</table>
						  </div>
						</div>
					  </div>
					  <div class="col-sm"><button class="btn btn-primary my-2 my-sm-0" type="submit" style="width: 100%;"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
					    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
					    </svg></button></div>
					</div>
				</div>
			
			</nav>
				
		<div class="row">
			<%
			//Filtering Dynamically by category
			ArrayList<Product> tempFilteredProduct = new ArrayList<Product>();
			boolean haveFilter = false;
			boolean haveTypeFilter = false;
			
			for(String s : categoryList) {
				String tempFilter = s+"Filter";
				if(request.getParameter(tempFilter)!=null && request.getParameter(tempFilter).equals("true")) {
					haveFilter = true;
					if (!productBean.getFilteredProduct().isEmpty()) 
						for (Product product : productBean.getFilteredProduct()) 
							if(product.getCategory().equals(s))
								tempFilteredProduct.add(product);
				}
			}
			
			if(haveFilter)
				productBean.setFilteredProduct(tempFilteredProduct);
			
			ArrayList<Product> tempTypeFilteredProduct = new ArrayList<Product>();
			//soldout
			if(request.getParameter("soldOutFilter")!=null && request.getParameter("soldOutFilter").equals("true")) {
				haveTypeFilter = true;
				if (!productBean.getFilteredProduct().isEmpty()) 
					for (Product product : productBean.getFilteredProduct()) 
						if(product.getQtyAvaiable().equals("0"))
							tempTypeFilteredProduct.add(product);
			}
			//sale
			if(request.getParameter("saleFilter")!=null && request.getParameter("saleFilter").equals("true")) {
				haveTypeFilter = true;
				if (!productBean.getFilteredProduct().isEmpty()) 
					for (Product product : productBean.getFilteredProduct()) 
						if(!product.getCost().equals(product.getDiscountCost()))
							if(!product.getQtyAvaiable().equals("0"))
								tempTypeFilteredProduct.add(product);
			}
			
			if(haveTypeFilter)
					productBean.setFilteredProduct(tempTypeFilteredProduct);
					

			if (!productBean.getFilteredProduct().isEmpty())
				for (Product product : productBean.getFilteredProduct()) {
			%>
			<div class="col-md-4">
				<div class="card mb-4 box-shadow" style="height: 520px;overflow: hidden;">
				<%
				if(product.getQtyAvaiable().equals("0")) {
				%>
					<div class="label-top shadow-sm bg-secondary">Sold Out</div>
				<%
				}else if(!product.getCost().equals(product.getDiscountCost())) {
				%>
					<div class="label-top shadow-sm bg-success">Sale</div>
				<%
				}
				%>
					<img class="card-img-top" alt="<%=product.getName()%>image"
						style="height: 225px; width: 100%; display: block;"
						src="<%=product.getImgPath()%>" data-holder-rendered="true">
					<div class="card-body">
						<h5 class="card-title"><%=product.getName()%></h5>
						<%
						if(product.getCost().equals(product.getDiscountCost())) {
						%>
							<label class="text-primary" style="font-size:20px"><%=product.getCost()%></label>
						<%
						}else {
						%>
							<label class="text-muted" style="text-decoration-line: line-through;font-size:13px"><%=product.getCost()%></label>
							<label class="text-primary" style="font-size:20px"><%=product.getDiscountCost()%></label>
						<%
						}
						%>
						<p class="text-muted" style="font-size:12px"><%=product.getDesc()%></p>
					</div>
				</div>
			</div>

			<%
			}
			else {
			%>
			<small class="text-muted">Nessun risultato trovato!</small>
			<%
			}
			%>
		</div>
	</div>

	<footer
		class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">

		<ul class="nav col-md-4 justify-content-end">
			<li class="nav-item"><a href="#"
				class="nav-link px-2 text-muted"> <svg
						xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor" class="bi bi-instagram" viewBox="0 0 16 16">
	  					<path
							d="M8 0C5.829 0 5.556.01 4.703.048 3.85.088 3.269.222 2.76.42a3.917 3.917 0 0 0-1.417.923A3.927 3.927 0 0 0 .42 2.76C.222 3.268.087 3.85.048 4.7.01 5.555 0 5.827 0 8.001c0 2.172.01 2.444.048 3.297.04.852.174 1.433.372 1.942.205.526.478.972.923 1.417.444.445.89.719 1.416.923.51.198 1.09.333 1.942.372C5.555 15.99 5.827 16 8 16s2.444-.01 3.298-.048c.851-.04 1.434-.174 1.943-.372a3.916 3.916 0 0 0 1.416-.923c.445-.445.718-.891.923-1.417.197-.509.332-1.09.372-1.942C15.99 10.445 16 10.173 16 8s-.01-2.445-.048-3.299c-.04-.851-.175-1.433-.372-1.941a3.926 3.926 0 0 0-.923-1.417A3.911 3.911 0 0 0 13.24.42c-.51-.198-1.092-.333-1.943-.372C10.443.01 10.172 0 7.998 0h.003zm-.717 1.442h.718c2.136 0 2.389.007 3.232.046.78.035 1.204.166 1.486.275.373.145.64.319.92.599.28.28.453.546.598.92.11.281.24.705.275 1.485.039.843.047 1.096.047 3.231s-.008 2.389-.047 3.232c-.035.78-.166 1.203-.275 1.485a2.47 2.47 0 0 1-.599.919c-.28.28-.546.453-.92.598-.28.11-.704.24-1.485.276-.843.038-1.096.047-3.232.047s-2.39-.009-3.233-.047c-.78-.036-1.203-.166-1.485-.276a2.478 2.478 0 0 1-.92-.598 2.48 2.48 0 0 1-.6-.92c-.109-.281-.24-.705-.275-1.485-.038-.843-.046-1.096-.046-3.233 0-2.136.008-2.388.046-3.231.036-.78.166-1.204.276-1.486.145-.373.319-.64.599-.92.28-.28.546-.453.92-.598.282-.11.705-.24 1.485-.276.738-.034 1.024-.044 2.515-.045v.002zm4.988 1.328a.96.96 0 1 0 0 1.92.96.96 0 0 0 0-1.92zm-4.27 1.122a4.109 4.109 0 1 0 0 8.217 4.109 4.109 0 0 0 0-8.217zm0 1.441a2.667 2.667 0 1 1 0 5.334 2.667 2.667 0 0 1 0-5.334z" />
					</svg></a></li>
			<li class="nav-item"><a href="#"
				class="nav-link px-2 text-muted"><svg
						xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor" class="bi bi-facebook" viewBox="0 0 16 16">
  						<path
							d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951z" />
					</svg></a></li>
			<li class="nav-item"><a href="#"
				class="nav-link px-2 text-muted"><svg
						xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor" class="bi bi-twitter-x" viewBox="0 0 16 16">
  						<path
							d="M12.6.75h2.454l-5.36 6.142L16 15.25h-4.937l-3.867-5.07-4.425 5.07H.316l5.733-6.57L0 .75h5.063l3.495 4.633L12.601.75Zm-.86 13.028h1.36L4.323 2.145H2.865l8.875 11.633Z" />
					</svg></a></li>
			<li class="nav-item"><a href="#"
				class="nav-link px-2 text-muted">Contacts</a></li>
		</ul>
	</footer>

	
	
</body>
</html>