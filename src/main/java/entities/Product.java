package entities;

public class Product {
    
    private int id;
    private String productUId;
    private String productName;
    private int categoryId;
    private String description;
    private double price;
    private int quantity;
    private String productImg;

    public Product() {
        
    }
    
    public Product(String productUId, String productName, int categoryId, String description, double price, int quantity, String productImg) {
        this.productUId = productUId;
        this.productName = productName;
        this.categoryId = categoryId;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.productImg = productImg;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProductUId() {
        return productUId;
    }

    public void setProductUId(String productUId) {
        this.productUId = productUId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getProductImg() {
        return productImg;
    }

    public void setProductImg(String productImg) {
        this.productImg = productImg;
    }
}
