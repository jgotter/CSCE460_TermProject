package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class TableCreation {
	
	public static void main(String[] args) {
		
		Connection conn;
		try {
			// 1. Driver loading and DB connection
			conn =
			DriverManager.getConnection("jdbc:mysql://localhost:3306/target", "root", "SlayRay@23");
			System.out.println("Connection Success");
			
			// 2. Write SQL queries
			String custTableCreation = "CREATE TABLE Customers"
					+ "(custID INT PRIMARY KEY NOT NULL AUTO_INCREMENT, "
					+ "firstName VARCHAR(45) NOT NULL, "
					+ "lastName VARCHAR(45) NOT NULL, "
					+ "streetAddress VARCHAR(45) NOT NULL, "
					+ "city VARCHAR(45) NOT NULL, "
					+ "state VARCHAR(2) NOT NULL, "
					+ "zipCode VARCHAR(5) NOT NULL, "
					+ "phoneNum VARCHAR(12) NULL);";
			
			String ordersTableCreation = "CREATE TABLE Orders"
					+ "(orderNum INT PRIMARY KEY NOT NULL AUTO_INCREMENT, "
					+ "orderTotal DECIMAL(9,2) NOT NULL, "
					+ "cardType VARCHAR(24) NULL, "
					+ "cardNumber VARCHAR(16) NULL, "
					+ "orderDate DATE NOT NULL, "
					+ "onlineVSInStore VARCHAR(10) NOT NULL, "
					+ "custID INT NOT NULL, "
					+ "foreign key (custID) references Customers (custID));";
		
			String deptTableCreation = "CREATE table Department"
					+ "(deptID INT PRIMARY KEY NOT NULL, "
					+ "deptName VARCHAR(45) NOT NULL);";
			
			String locTableCreation = "CREATE table Locations"
					+ "(locID INT PRIMARY KEY NOT NULL, "
					+ "locName VARCHAR(45) NOT NULL, "
					+ "streetAddress VARCHAR(45) NOT NULL, "
					+ "city VARCHAR(45) NOT NULL, "
					+ "state VARCHAR(2) NOT NULL, "
					+ "zipCode VARCHAR(5) NOT NULL);";
			
			String vendorsTableCreation = "CREATE table Vendors"
					+ "(vendorID INT PRIMARY KEY NOT NULL, "
					+ "vendorName VARCHAR(45) NOT NULL, "
					+ "vendorCity VARCHAR(45) NOT NULL, "
					+ "vendorState VARCHAR(2) NOT NULL);";
			
			String stockTableCreation = "CREATE table Stock"
					+ "(stockID INT PRIMARY KEY NOT NULL, "
					+ "qty VARCHAR(45) NOT NULL, "
					+ "deptID INT NOT NULL, "
					+ "vendorID INT NOT NULL, "
					+ "locID INT NOT NULL, "
					+ "Foreign key (deptID) references Department (deptID), "
					+ "Foreign key (vendorID) references Vendors (vendorID), "
					+ "Foreign key (locID) references Locations (locID));";
			
			String clothingTableCreation = "CREATE TABLE IF NOT EXISTS Clothing"
					+ "(itemNum INT PRIMARY KEY NOT NULL AUTO_INCREMENT, "
					+ "itemName VARCHAR(45) NOT NULL, "
					+ "deptID INT NOT NULL, "
					+ "stockID INT NOT NULL, "
					+ "size VARCHAR(2) NOT NULL, "
					+ "foreign key (deptID) references Department (deptID), "
					+ "foreign key (stockID) references Stock (stockID));";
			
			String empTableCreation = "CREATE TABLE IF NOT EXISTS Employee"
					+ "(employeeID VARCHAR(6) PRIMARY KEY NOT NULL, "
					+ "deptID INT NOT NULL, "
					+ "managerID VARCHAR(6) NULL DEFAULT NULL, "
					+ "emplyoeeDiscount DECIMAL(3,2) NOT NULL, "
					+ "firstName VARCHAR(45) NOT NULL, "
					+ "lastName VARCHAR(45) NOT NULL, "
					+ "streetAddress VARCHAR(45) NOT NULL, "
					+ "city VARCHAR(45) NOT NULL, "
					+ "state VARCHAR(2) NOT NULL, "
					+ "zipCode VARCHAR(5) NOT NULL, "
					+ "hoursPerWeek DECIMAL(4,2) NOT NULL, "
					+ "vendorID INT NULL DEFAULT NULL, "
					+ "locID INT NOT NULL, "
					+ "position VARCHAR(45) NOT NULL, "
					+ "foreign key (deptID) references Department (deptID), "
					+ "foreign key (locID) references Locations (locID), "
					+ "foreign key (vendorID) references Vendors (vendorID), "
					+ "foreign key (managerID) references Employee (employeeID));";
			
			String groceryTableCreation = "CREATE TABLE IF NOT EXISTS Grocery"
					+ "(itemNum INT PRIMARY KEY NOT NULL AUTO_INCREMENT, "
					+ "itemName VARCHAR(45) NOT NULL, "
					+ "deptID INT NOT NULL, "
					+ "stockID INT NOT NULL, "
					+ "expirationDate DATE NOT NULL, "
					+ "price DECIMAL(9,2) NOT NULL, "
					+ "foreign key (deptID) references Department (deptID), "
					+ "foreign key (stockID) references Stock (stockID));";
			
			String orderDetsTableCreation = "CREATE TABLE IF NOT EXISTS OrderDetails"
					+ "(orderNum INT NOT NULL, "
					+ "stockID INT NOT NULL, "
					+ "locID INT NOT NULL, "
					+ "qty INT NOT NULL, "
					+ "foreign key (locID) references Locations (locID), "
					+ "foreign key (orderNum) references Orders (orderNum), "
					+ "foreign key (stockID) references Stock (stockID));";
			
			String redCardTableCreation = "CREATE TABLE IF NOT EXISTS RedCard"
					+ "(custID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,"
					+ "cardNumber VARCHAR(10) NOT NULL,"
					+ "savings DECIMAL(9,2) NULL DEFAULT NULL,"
					+ "foreign key (custID) references Customers (custID));";
			
			String techTableCreation = "CREATE TABLE IF NOT EXISTS Technology"
					+ "(itemNum INT PRIMARY KEY NOT NULL AUTO_INCREMENT, "
					+ "itemName VARCHAR(45) NOT NULL, "
					+ "deptID INT NOT NULL, "
					+ "stockID INT NOT NULL, "
					+ "price DECIMAL(9,2) NOT NULL, "
					+ "foreign key (deptID) references Department (deptID), "
					+ "foreign key (stockID) references Stock (stockID));";
			
			// 3. Create the statement object to execute SQL queries
			Statement stmt = conn.createStatement();
						
						
			// 4. Execute SQL queries using the execute (String sql) method
			boolean custResult = stmt.execute(custTableCreation);
			boolean ordersResult = stmt.execute(ordersTableCreation);
			boolean deptResult = stmt.execute(deptTableCreation);
			boolean locResult = stmt.execute(locTableCreation);
			boolean vendorsResult = stmt.execute(vendorsTableCreation);
			boolean stockResult = stmt.execute(stockTableCreation);
			boolean clothingResult = stmt.execute(clothingTableCreation);
			boolean empResult = stmt.execute(empTableCreation);
			boolean groceryResult = stmt.execute(groceryTableCreation);
			boolean orderDetsResult = stmt.execute(orderDetsTableCreation);
			boolean redCardResult = stmt.execute(redCardTableCreation);
			boolean techResult = stmt.execute(techTableCreation);
			
			System.out.println("DB table creation is successful :)");
						
			// 5. close
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		} catch(Exception e) {
			System.out.println("Error: "+e);
		}
	}
}
