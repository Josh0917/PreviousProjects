CREATE TABLE Customers (
Phone_Number int,
Address_id int,
Credit_Card int,
Customer_id int,
PRIMARY KEY(Customer_id));
CREATE TABLE Customer_Address (
Zip_Code varchar(255),
Street_Address varchar(255),
State varchar(255),
Address_id int,
PRIMARY KEY(Address_id),
Customer_id INT FOREIGN KEY REFERENCES Customers(Customer_id));
CREATE TABLE Orders (
order_number int,
Order_id int,
PRIMARY KEY(Order_id),
Customer_id INT FOREIGN KEY REFERENCES Customers(Customer_id));
CREATE TABLE Order_Details (
Total_cost int,
Products_Ordered varchar(255),
Tax int,
Order_description varchar(255),
Shipping_cost int,
Order_Details_id int,
PRIMARY KEY(Order_Details_id),
Order_id INT FOREIGN KEY REFERENCES Orders(Order_id));
CREATE TABLE Store(
Store_name varchar(255),
Location varchar(255),
Total_Sales int,
Product_Quantity int,
Store_id int,
PRIMARY KEY(Store_id),
Order_Details_id INT FOREIGN KEY REFERENCES Order_Details(Order_Details_id));
CREATE TABLE Products (
Product_description varchar(255),
Product_name varchar(255),
Price int,
Product_id int,
PRIMARY KEY(Product_id),
Store_id INT FOREIGN KEY REFERENCES Store(Store_id));
