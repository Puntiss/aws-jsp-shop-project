package com.appa.model;

import java.io.Serializable;

public class Product implements Serializable {

	private static final long serialVersionUID = -8530659582514557707L;

	private String id;
	private String imgPath;
	private String cost;
	private String discountCost;
	private String name;
	private String desc;
	private String category;
	private String qtyAvaiable;
	
	public Product() {
		super();
	}

	public Product(String id, String imgPath, String cost, String discountCost, String name, String desc,
			String category, String qtyAvaiable) {
		super();
		this.id = id;
		this.imgPath = imgPath;
		this.cost = cost;
		this.discountCost = discountCost;
		this.name = name;
		this.desc = desc;
		this.category = category;
		this.qtyAvaiable = qtyAvaiable;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	public String getCost() {
		return cost;
	}

	public void setCost(String cost) {
		this.cost = cost;
	}

	public String getDiscountCost() {
		return discountCost;
	}

	public void setDiscountCost(String discountCost) {
		this.discountCost = discountCost;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getQtyAvaiable() {
		return qtyAvaiable;
	}

	public void setQtyAvaiable(String qtyAvaiable) {
		this.qtyAvaiable = qtyAvaiable;
	}

	@Override
	public String toString() {
		return "Product [id=" + id + ", imgPath=" + imgPath + ", cost=" + cost + ", discountCost=" + discountCost
				+ ", name=" + name + ", desc=" + desc + ", category=" + category + ", qtyAvaiable=" + qtyAvaiable + "]";
	}

}
