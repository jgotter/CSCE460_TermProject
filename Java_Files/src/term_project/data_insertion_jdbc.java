package term_project;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

public class data_insertion_jdbc {
	public main(String[] args) {
		Connection conn;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/target", "root", "");
			System.out.println("Connection Success");			
			
			insertData(conn);
			
			
			conn.close();
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
	
	
	private static void insertData(Connection conn) {
		try {
			String deptTable = "INSERT INTO `Department` (`deptID`, `deptName`) VALUES "
					+ "(1,  'Grocery'), "
					+ "(2,  'Technology'), "
					+ "(3,  'Clothing'), "
					+ "(4,  'Customer Service'), "
					+ "(5,  'Management');";
			
			String locationsTable = "INSERT INTO `Locations` (`locID`, `locName`, `streetAddress`, `city`, `state`, `zipCode`) VALUES "
					+ "(1,  'Naperville Store',    '2751 Showplace Dr',       'Naperville',   'IL', '60564'), "
					+ "(2,  'Aurora Store',        '2380 Orchard Gateway Blvd','Aurora',       'IL', '60506'), "
					+ "(3,  'Joliet Store',        '1500 Louis Joliet Rd',    'Joliet',       'IL', '60435'), "
					+ "(4,  'Schaumburg Store',    '1950 E Golf Rd',          'Schaumburg',   'IL', '60173'), "
					+ "(5,  'Oak Brook Store',     '2000 Spring Rd',          'Oak Brook',    'IL', '60523'), "
					+ "(6,  'Downtown Chicago',    '1 S State St',            'Chicago',      'IL', '60603'), "
					+ "(7,  'Evanston Store',      '1111 Chicago Ave',        'Evanston',     'IL', '60202'), "
					+ "(8,  'Bolingbrook Store',   '225 N Weber Rd',          'Bolingbrook',  'IL', '60440'), "
					+ "(9,  'Elgin Store',         '1250 Randall Rd',         'Elgin',        'IL', '60123'), "
					+ "(10, 'Lombard Store',       '1 Yorktown Center Dr',    'Lombard',      'IL', '60148');";
			
			String vendorsTable = "INSERT INTO `Vendors` (`vendorID`, `vendorName`, `vendorCity`, `vendorState`) VALUES "
					+ "(1,  'Fresh Farms Distributors', 'Chicago',       'IL'), "
					+ "(2,  'Prairie Dairy Co',         'Madison',       'WI'), "
					+ "(3,  'TechSource Wholesale',     'San Jose',      'CA'), "
					+ "(4,  'Digital Depot Supply',     'Austin',        'TX'), "
					+ "(5,  'Urban Threads Apparel',    'New York',      'NY'), "
					+ "(6,  'Midwest Denim Works',      'Indianapolis',  'IN'), "
					+ "(7,  'Sunrise Bakery Supply',    'Milwaukee',     'WI'), "
					+ "(8,  'Gadget Galaxy Inc',        'Seattle',       'WA'), "
					+ "(9,  'Lakeshore Beverages',      'Detroit',       'MI'), "
					+ "(10, 'Comfort Wear Brands',      'Atlanta',       'GA'); ";
			
			String stockTable = "INSERT INTO `Stock` (`stockID`, `qty`, `deptID`, `vendorID`, `locID`) VALUES "
					+ "(1,  '250', 1, 1,  1), "
					+ "(2,  '180', 1, 2,  2), "
					+ "(3,  '320', 1, 7,  3), "
					+ "(4,  '210', 1, 9,  4), "
					+ "(5,  '140', 1, 1,  5), "
					+ "(6,  '45',  2, 3,  1), "
					+ "(7,  '30',  2, 4,  2), "
					+ "(8,  '60',  2, 8,  6), "
					+ "(9,  '25',  2, 3,  7), "
					+ "(10, '75',  2, 4,  8), "
					+ "(11, '120', 3, 5,  1), "
					+ "(12, '95',  3, 6,  9), "
					+ "(13, '150', 3, 10, 10), "
					+ "(14, '80',  3, 5,  4), "
					+ "(15, '110', 3, 6,  5); ";
			
			String customersTable = "INSERT INTO `Customers` (`custID`, `firstName`, `lastName`, `streetAddress`, `city`, `state`, `zipCode`, `phoneNum`) VALUES "
					+ "(1,  'Emily',   'Johnson',   '412 Maple St',      'Naperville',  'IL', '60540', '630-555-0101'), "
					+ "(2,  'Michael', 'Rodriguez', '88 Oak Ave',        'Aurora',      'IL', '60505', '630-555-0102'), "
					+ "(3,  'Sarah',   'Patel',     '1205 Elm Dr',       'Joliet',      'IL', '60431', '815-555-0103'), "
					+ "(4,  'David',   'Nguyen',    '73 Lakeview Ct',    'Schaumburg',  'IL', '60194', '847-555-0104'), "
					+ "(5,  'Jessica', 'Williams',  '560 Birch Ln',      'Oak Brook',   'IL', '60523', '630-555-0105'), "
					+ "(6,  'Daniel',  'Kim',       '2210 Pine Rd',      'Chicago',     'IL', '60614', '312-555-0106'), "
					+ "(7,  'Ashley',  'Brown',     '918 Cedar Blvd',    'Evanston',    'IL', '60201', '847-555-0107'), "
					+ "(8,  'Christopher','Davis',  '34 Willow Way',     'Bolingbrook', 'IL', '60440', '630-555-0108'), "
					+ "(9,  'Megan',   'Martinez',  '147 Sunset Dr',     'Elgin',       'IL', '60120', '847-555-0109'), "
					+ "(10, 'Brandon', 'Taylor',    '665 Prairie Ave',   'Lombard',     'IL', '60148', '630-555-0110'), "
					+ "(11, 'Olivia',  'Anderson',  '29 Harbor St',      'Naperville',  'IL', '60563', NULL), "
					+ "(12, 'Ethan',   'Thomas',    '801 Ridge Rd',      'Aurora',      'IL', '60504', '630-555-0112');";
			
			String ordersTable = "INSERT INTO `Orders` (`orderNum`, `orderTotal`, `cardType`, `cardNumber`, `orderDate`, `onlineVSInStore`, `custID`) VALUES "
					+ "(1,  45.67,   'Visa',        '4111111111111111', '2026-09-01', 'In-Store', 1), "
					+ "(2,  129.99,  'MasterCard',  '5500000000000004', '2026-09-03', 'Online', 2), "
					+ "(3,  23.45,   NULL,          NULL,               '2026-09-05', 'In-Store', 11), "
					+ "(4,  899.00,  'Target Card', '3782822463100050', '2026-09-08', 'Online', 5), "
					+ "(5,  67.80,   'Debit',       '6011000000000004', '2026-09-12', 'In-Store', 3), "
					+ "(6,  15.99,   NULL,          NULL,               '2026-09-15', 'In-Store', 12), "
					+ "(7,  249.50,  'Visa',        '4012888888881881', '2026-09-18', 'Online', 4), "
					+ "(8,  78.25,   'MasterCard',  '5105105105105100', '2026-09-22', 'In-Store', 6), "
					+ "(9,  34.10,   'Debit',       '6011111111111117', '2026-09-27', 'In-Store', 7), "
					+ "(10, 1299.99, 'Target Card', '3530111333300000', '2026-10-02', 'Online', 8), "
					+ "(11, 52.30,   'Visa',        '4222222222222222', '2026-10-06', 'In-Store', 9), "
					+ "(12, 19.75,   NULL,          NULL,               '2026-10-10', 'In-Store', 10);";
			
			String orderDetailsTable = "INSERT INTO `OrderDetails` (`orderNum`, `stockID`, `locID`, `qty`) VALUES "
					+ "(1,  1,  1,  3), "
					+ "(1,  3,  3,  2), "
					+ "(2,  11, 1,  2), "
					+ "(3,  2,  2,  4), "
					+ "(4,  6,  1,  1), "
					+ "(5,  12, 9,  3), "
					+ "(6,  4,  4,  2), "
					+ "(7,  7,  2,  1), "
					+ "(7,  13, 10, 2), "
					+ "(8,  14, 4,  1), "
					+ "(9,  5,  5,  5), "
					+ "(10, 8,  6,  1), "
					+ "(10, 9,  7,  1), "
					+ "(11, 15, 5,  2), "
					+ "(12, 1,  1,  4); ";
			
			String groceryTable = "INSERT INTO `Grocery` (`itemNum`, `itemName`, `deptID`, `stockID`, `expirationDate`, `price`) VALUES "
					+ "(1001, 'Whole Milk 1 Gallon',     1, 2, '2026-11-25', 3.89), "
					+ "(1002, 'Large Eggs 12ct',         1, 2, '2026-12-05', 3.49), "
					+ "(1003, 'Sourdough Bread Loaf',    1, 3, '2026-11-22', 4.29), "
					+ "(1004, 'Honeycrisp Apples 3lb',   1, 1, '2026-12-01', 5.99), "
					+ "(1005, 'Orange Juice 52oz',       1, 4, '2026-12-15', 4.79), "
					+ "(1006, 'Cheddar Cheese Block',    1, 2, '2027-01-10', 3.99), "
					+ "(1007, 'Baby Spinach 10oz',       1, 1, '2026-11-24', 3.29), "
					+ "(1008, 'Bottled Water 24pk',      1, 4, '2027-08-30', 4.99), "
					+ "(1009, 'Chocolate Chip Cookies',  1, 3, '2027-02-14', 3.59), "
					+ "(1010, 'Frozen Pizza Pepperoni',  1, 5, '2027-03-20', 6.49); ";
			
			String technologyTable = "INSERT INTO `Technology` (`itemNum`, `itemName`, `deptID`, `stockID`, `price`) VALUES "
					+ "(2001, 'Wireless Earbuds', 2, 6, 79.99),"
					+ "(2002, '55\" 4K Smart TV', 2, 7, 399.99),"
					+ "(2003, 'Bluetooth Speaker',  2, 6, 49.99),"
					+ "(2004, 'Laptop 15.6\" 8GB', 2, 8, 649.00),"
					+ "(2005, 'Tablet 10\" 64GB', 2, 8, 249.99),"
					+ "(2006, 'USB-C Charging Cable 6ft', 2, 9, 14.99),"
					+ "(2007, 'Gaming Headset', 2, 10, 59.99),"
					+ "(2008, 'Smart Watch', 2, 9, 199.99),"
					+ "(2009, 'Wireless Mouse', 2, 10, 24.99),"
					+ "(2010, 'Portable Power Bank 10000mAh', 2, 7, 29.99);";
			
			String clothingTable = "INSERT INTO `Clothing` (`itemNum`, `itemName`, `deptID`, `stockID`, `size`) VALUES "
					+ "(3001, 'Men''s Crew Neck T-Shirt', 3, 11, 'M'),"
					+ "(3002, 'Women''s Skinny Jeans', 3, 12, 'S'),"
					+ "(3003, 'Men''s Hooded Sweatshirt', 3, 13, 'L'),"
					+ "(3004, 'Women''s Yoga Leggings', 3, 14, 'XS'),"
					+ "(3005, 'Kids'' Rain Jacket', 3, 15, 'S'),"
					+ "(3006, 'Men''s Denim Jacket', 3, 12, 'XL'),"
					+ "(3007, 'Women''s Cardigan', 3, 11, 'M'),"
					+ "(3008, 'Men''s Athletic Shorts', 3, 13, 'L'),"
					+ "(3009, 'Women''s Button-Up Blouse', 3, 14, 'M'),"
					+ "(3010, 'Unisex Fleece Pullover', 3, 15, 'XL');";
			
			
			String redCardTable = "INSERT INTO `RedCard` (`custID`, `cardNumber`, `savings`) VALUES "
					+ "(1, '7000100001', 45.20),"
					+ "(2, '7000100002', 12.75),"
					+ "(3, '7000100003', 88.40),"
					+ "(4, '7000100004', 0.00),"
					+ "(5, '7000100005', 130.15),"
					+ "(6, '7000100006', 27.60),"
					+ "(7, '7000100007', 64.30),"
					+ "(8, '7000100008', NULL),"
					+ "(9, '7000100009', 19.99),"
					+ "(10, '7000100010', 52.05);";
			
			String employeeTable = "INSERT INTO `Employee` (`employeeID`, `deptID`, `managerID`, `emplyoeeDiscount`, `firstName`, `lastName`, `streetAddress`, `city`, `state`, `zipCode`, `hoursPerWeek`, `vendorID`, `locID`, `position`) VALUES "
					+ "('E00001', 5, NULL, 0.20, 'Linda', 'Carter', '15 Lincoln Ave', 'Naperville', 'IL', '60540', 40.00, NULL, 1, 'Store Manager'),"
					+ "('E00002', 5, NULL, 0.20, 'Robert', 'Hughes', '902 Garfield St', 'Aurora', 'IL', '60505', 40.00, NULL, 2, 'Store Manager'),"
					+ "('E00003', 5, NULL, 0.20, 'Angela', 'Foster', '47 Jackson Blvd', 'Joliet', 'IL', '60435', 42.50, NULL, 3, 'Store Manager'),"
					+ "('E00004', 1, 'E00001', 0.10, 'Kevin', 'Murphy', '318 Washington Rd', 'Naperville', 'IL', '60564', 32.00, NULL, 1, 'Grocery Clerk'),"
					+ "('E00005', 4, 'E00001', 0.10, 'Priya', 'Shah', '77 Madison Ct', 'Lisle', 'IL', '60532', 28.50, 1, 1, 'Vendor Liaison'),"
					+ "('E00006', 3, 'E00001', 0.10, 'Tyler', 'Reed', '260 Monroe St', 'Naperville', 'IL', '60540', 25.00, NULL, 1, 'Sales Associate'),"
					+ "('E00007', 2, 'E00002', 0.15, 'Nina', 'Gonzalez', '5 Adams Way', 'Aurora', 'IL', '60506', 36.00, NULL, 2, 'Tech Specialist'),"
					+ "('E00008', 2, 'E00002', 0.10, 'Marcus', 'Lee', '412 Harrison Dr', 'Aurora', 'IL', '60504', 30.00, 3, 2, 'Vendor Liaison'),"
					+ "('E00009', 4, 'E00002', 0.10, 'Hannah', 'Cole', '99 Tyler Ln', 'Oswego', 'IL', '60543', 20.00, NULL, 2, 'Cashier'),"
					+ "('E00010', 3, 'E00003', 0.10, 'Samuel', 'Brooks', '186 Polk St', 'Joliet', 'IL', '60432', 35.00, 5, 3, 'Clothing Associate'),"
					+ "('E00011', 1, 'E00003', 0.10, 'Grace', 'Ortiz', '23 Fillmore Ave', 'Plainfield', 'IL', '60544', 24.00, NULL, 3, 'Stocker'),"
					+ "('E00012', 2, 'E00003', 0.15, 'Jordan', 'Pierce', '710 Pierce Rd', 'Joliet', 'IL', '60435', 38.75, NULL, 3, 'Electronics Lead');";

			Statement stmt = conn.createStatement();
			
			boolean deptTableResults = stmt.execute(deptTable);
			boolean locationsTableResults = stmt.execute(locationsTable);
			boolean vendorsTableResults = stmt.execute(vendorsTable);
			boolean stockTableResults = stmt.execute(stockTable);
			boolean customersTableResults = stmt.execute(customersTable);
			boolean ordersTableResults = stmt.execute(ordersTable);
			boolean orderDetailsTableResults = stmt.execute(orderDetailsTable);
			boolean groceryTableResults = stmt.execute(groceryTable);
			boolean technologyTableResults = stmt.execute(technologyTable);
			boolean clothingTableResults = stmt.execute(clothingTable);
			boolean redCardTableResults = stmt.execute(redCardTable);
			boolean employeeTableResults = stmt.execute(employeeTable);
			
			
			System.out.println("DB table insertion was successful");
		}
		catch(Exception e) {
			System.out.println("Error: "+e);
		}		
	}
		
		
	private static void printData(ResultSet results) {
		System.out.println();
		try {
			ResultSetMetaData data = results.getMetaData();
		
			for(int i = 1; i <= data.getColumnCount(); i++) {
				System.out.print(data.getColumnName(i) + "\t");
			}
			System.out.println();
		
			while(results.next()) {
				for(int i = 1; i <= data.getColumnCount(); i++) {
					System.out.print(results.getString(i) + "\t");
				}
				System.out.println();
			}

		}catch(Exception e) {
			System.out.println("Error Printing : " + e);
		}
	}
}
