package com.appa.bean;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.appa.model.Product;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class ProductBean implements Serializable {

	private static final long serialVersionUID = -5599127794612971896L;
	private ArrayList<Product> products = new ArrayList<Product>();
	private ArrayList<Product> filteredProduct = new ArrayList<Product>();
	private String filter;

	public ProductBean() {
		super();
		try {
			System.out.println("retrieveAll()");
			setProducts((ArrayList<Product>) retrieveAll());
			setFilteredProduct(new ArrayList<Product>(getProducts()));
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void filterProducts() {

		setFilteredProduct(new ArrayList<Product>());
		
		if (this.filter != null) {
			
			System.out.println("Filer: " + this.filter);
			
			for (Product p : getProducts())
				if (p.getName().toLowerCase().contains(this.filter.toLowerCase()))
					getFilteredProduct().add(p);
			
		}else {
			setFilteredProduct(new ArrayList<Product>(getProducts()));
		}

	}
	
	final private String apiDeployLink = ""; 

	public List<Product> retrieveAll() throws ClientProtocolException, IOException {
		HttpClient httpClient = HttpClients.createDefault();
		HttpGet request = new HttpGet(apiDeployLink+"/api/products/retrieveAll");

		HttpResponse response = httpClient.execute(request);

		//System.out.println("Response: " + response);
		if (response.getStatusLine().getStatusCode() == 200) {
			String jsonResponse = EntityUtils.toString(response.getEntity());
			ObjectMapper objectMapper = new ObjectMapper();
			return objectMapper.readValue(jsonResponse, new TypeReference<List<Product>>() {});
		}
		return null;
	}

	public ArrayList<Product> getProducts() {
		return products;
	}

	public void setProducts(ArrayList<Product> products) {
		this.products = products;
	}

	public ArrayList<Product> getFilteredProduct() {
		return filteredProduct;
	}

	public void setFilteredProduct(ArrayList<Product> filteredProduct) {
		this.filteredProduct = filteredProduct;
	}

	public String getFilter() {
		return filter;
	}

	public void setFilter(String filter) {
		this.filter = filter;
	}

}
