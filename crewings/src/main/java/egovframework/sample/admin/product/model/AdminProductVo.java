package egovframework.sample.admin.product.model;

import com.system.util.SearchVo;

public class AdminProductVo  extends SearchVo{

	String idx = "";
	String name = "";
	String image = "";
	String category = "";
	String price = "";
	String location = "";
	String coment = "";
	String image_change_bool = "";
	
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getComent() {
		return coment;
	}
	public void setComent(String coment) {
		this.coment = coment;
	}
	public String getImage_change_bool() {
		return image_change_bool;
	}
	public void setImage_change_bool(String image_change_bool) {
		this.image_change_bool = image_change_bool;
	}
	
	
	
}
