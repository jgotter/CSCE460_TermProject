-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema target
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema target
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `target` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema target
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema target
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `target` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `target` ;

-- -----------------------------------------------------
-- Table `target`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Customers` (
  `custID` INT NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `streetAddress` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `zipCode` VARCHAR(5) NOT NULL,
  `phoneNum` VARCHAR(12) NULL,
  PRIMARY KEY (`custID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `target`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Orders` (
  `orderNum` INT NOT NULL AUTO_INCREMENT,
  `orderTotal` DECIMAL(9,2) NOT NULL,
  `cardType` VARCHAR(24) NULL,
  `cardNumber` VARCHAR(16) NULL,
  `orderDate` DATE NOT NULL,
  `onlineVSInStore` VARCHAR(10) NOT NULL,
  `custID` INT NOT NULL,
  PRIMARY KEY (`orderNum`),
  INDEX `ordersCutID_idx` (`custID` ASC) VISIBLE,
  CONSTRAINT `ordersCutID`
    FOREIGN KEY (`custID`)
    REFERENCES `target`.`Customers` (`custID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `target`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Department` (
  `deptID` INT NOT NULL,
  `deptName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`deptID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `target`.`Locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Locations` (
  `locID` INT NOT NULL,
  `locName` VARCHAR(45) NOT NULL,
  `streetAddress` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `zipCode` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`locID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `target`.`Vendors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Vendors` (
  `vendorID` INT NOT NULL,
  `vendorName` VARCHAR(45) NOT NULL,
  `vendorCity` VARCHAR(45) NOT NULL,
  `vendorState` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`vendorID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `target`.`Stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Stock` (
  `stockID` INT NOT NULL,
  `qty` VARCHAR(45) NOT NULL,
  `deptID` INT NOT NULL,
  `vendorID` INT NOT NULL,
  `locID` INT NOT NULL,
  PRIMARY KEY (`stockID`),
  INDEX `deptID_idx` (`deptID` ASC) VISIBLE,
  INDEX `vendorID_idx` (`vendorID` ASC) VISIBLE,
  INDEX `locID_idx` (`locID` ASC) VISIBLE,
  CONSTRAINT `deptID`
    FOREIGN KEY (`deptID`)
    REFERENCES `target`.`Department` (`deptID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `vendorID`
    FOREIGN KEY (`vendorID`)
    REFERENCES `target`.`Vendors` (`vendorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `locID`
    FOREIGN KEY (`locID`)
    REFERENCES `target`.`Locations` (`locID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `target`.`OrderDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`OrderDetails` (
  `orderNum` INT NOT NULL,
  `stockID` INT NOT NULL,
  `locID` INT NOT NULL,
  `orderQTY` INT NOT NULL,
  INDEX `stockID_idx` (`stockID` ASC) VISIBLE,
  INDEX `orderNum_idx` (`orderNum` ASC) VISIBLE,
  INDEX `locID_idx` (`locID` ASC) VISIBLE,
  CONSTRAINT `stockID`
    FOREIGN KEY (`stockID`)
    REFERENCES `target`.`Stock` (`stockID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orderNum`
    FOREIGN KEY (`orderNum`)
    REFERENCES `target`.`Orders` (`orderNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `locationID`
    FOREIGN KEY (`locID`)
    REFERENCES `target`.`Locations` (`locID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `target`.`Grocery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Grocery` (
  `itemNum` INT NOT NULL,
  `itemName` VARCHAR(45) NOT NULL,
  `deptID` INT NOT NULL,
  `stockID` INT NOT NULL,
  `expirationDate` DATE NOT NULL,
  `price` DECIMAL(9,2) NOT NULL,
  PRIMARY KEY (`itemNum`),
  INDEX `deptID_idx` (`deptID` ASC) VISIBLE,
  INDEX `stockID_idx` (`stockID` ASC) VISIBLE,
  CONSTRAINT `groceryDeptID`
    FOREIGN KEY (`deptID`)
    REFERENCES `target`.`Department` (`deptID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `groceryStockID`
    FOREIGN KEY (`stockID`)
    REFERENCES `target`.`Stock` (`stockID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `target`.`Technology`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Technology` (
  `itemNum` INT NOT NULL,
  `itemName` VARCHAR(45) NOT NULL,
  `deptID` INT NOT NULL,
  `stockID` INT NOT NULL,
  `price` DECIMAL(9,2) NOT NULL,
  PRIMARY KEY (`itemNum`),
  INDEX `deptID_idx` (`deptID` ASC) VISIBLE,
  INDEX `stockID_idx` (`stockID` ASC) VISIBLE,
  CONSTRAINT `techDeptID`
    FOREIGN KEY (`deptID`)
    REFERENCES `target`.`Department` (`deptID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `techStockID`
    FOREIGN KEY (`stockID`)
    REFERENCES `target`.`Stock` (`stockID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `target`.`Clothing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Clothing` (
  `itemNum` INT NOT NULL,
  `itemName` VARCHAR(45) NOT NULL,
  `deptID` INT NOT NULL,
  `stockID` INT NOT NULL,
  `size` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`itemNum`),
  INDEX `deptID_idx` (`deptID` ASC) VISIBLE,
  INDEX `stockID_idx` (`stockID` ASC) VISIBLE,
  CONSTRAINT `clothingDeptID`
    FOREIGN KEY (`deptID`)
    REFERENCES `target`.`Department` (`deptID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `clothingStockID`
    FOREIGN KEY (`stockID`)
    REFERENCES `target`.`Stock` (`stockID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `target`.`RedCard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`RedCard` (
  `custID` INT NOT NULL,
  `cardNumber` VARCHAR(10) NOT NULL,
  `savings` DECIMAL(9,2) NULL,
  PRIMARY KEY (`custID`),
  CONSTRAINT `custID`
    FOREIGN KEY (`custID`)
    REFERENCES `target`.`Customers` (`custID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `target`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Employee` (
  `employeeID` VARCHAR(6) NOT NULL,
  `deptID` INT NOT NULL,
  `managerID` VARCHAR(6) NULL,
  `emplyoeeDiscount` DECIMAL(3,2) NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `streetAddress` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `zipCode` VARCHAR(5) NOT NULL,
  `hoursPerWeek` DECIMAL(4,2) NOT NULL,
  `vendorID` INT NULL,
  `locID` INT NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`employeeID`),
  INDEX `deptID_idx` (`deptID` ASC) VISIBLE,
  INDEX `managerID_idx` (`managerID` ASC) VISIBLE,
  INDEX `vendorID_idx` (`vendorID` ASC) VISIBLE,
  INDEX `locationID_idx` (`locID` ASC) VISIBLE,
  CONSTRAINT `empDeptID`
    FOREIGN KEY (`deptID`)
    REFERENCES `target`.`Department` (`deptID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `managerID`
    FOREIGN KEY (`managerID`)
    REFERENCES `target`.`Employee` (`employeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `empVendorID`
    FOREIGN KEY (`vendorID`)
    REFERENCES `target`.`Vendors` (`vendorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `empLocID`
    FOREIGN KEY (`locID`)
    REFERENCES `target`.`Locations` (`locID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `target` ;

-- -----------------------------------------------------
-- Table `target`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Department` (
  `deptID` INT NOT NULL,
  `deptName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`deptID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `target`.`Locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Locations` (
  `locID` INT NOT NULL,
  `locName` VARCHAR(45) NOT NULL,
  `streetAddress` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `zipCode` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`locID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `target`.`Vendors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Vendors` (
  `vendorID` INT NOT NULL,
  `vendorName` VARCHAR(45) NOT NULL,
  `vendorCity` VARCHAR(45) NOT NULL,
  `vendorState` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`vendorID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `target`.`Stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Stock` (
  `stockID` INT NOT NULL,
  `qty` VARCHAR(45) NOT NULL,
  `deptID` INT NOT NULL,
  `vendorID` INT NOT NULL,
  `locID` INT NOT NULL,
  PRIMARY KEY (`stockID`),
  INDEX `deptID_idx` (`deptID` ASC) VISIBLE,
  INDEX `vendorID_idx` (`vendorID` ASC) VISIBLE,
  INDEX `locID_idx` (`locID` ASC) VISIBLE,
  CONSTRAINT `deptID`
    FOREIGN KEY (`deptID`)
    REFERENCES `target`.`Department` (`deptID`),
  CONSTRAINT `locID`
    FOREIGN KEY (`locID`)
    REFERENCES `target`.`Locations` (`locID`),
  CONSTRAINT `vendorID`
    FOREIGN KEY (`vendorID`)
    REFERENCES `target`.`Vendors` (`vendorID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `target`.`Clothing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Clothing` (
  `itemNum` INT NOT NULL,
  `itemName` VARCHAR(45) NOT NULL,
  `deptID` INT NOT NULL,
  `stockID` INT NOT NULL,
  `size` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`itemNum`),
  INDEX `deptID_idx` (`deptID` ASC) VISIBLE,
  INDEX `stockID_idx` (`stockID` ASC) VISIBLE,
  CONSTRAINT `clothingDeptID`
    FOREIGN KEY (`deptID`)
    REFERENCES `target`.`Department` (`deptID`),
  CONSTRAINT `clothingStockID`
    FOREIGN KEY (`stockID`)
    REFERENCES `target`.`Stock` (`stockID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `target`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Customers` (
  `custID` INT NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `streetAddress` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `zipCode` VARCHAR(5) NOT NULL,
  `phoneNum` VARCHAR(12) NULL DEFAULT NULL,
  PRIMARY KEY (`custID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `target`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Employee` (
  `employeeID` VARCHAR(6) NOT NULL,
  `deptID` INT NOT NULL,
  `managerID` VARCHAR(6) NULL DEFAULT NULL,
  `emplyoeeDiscount` DECIMAL(3,2) NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `streetAddress` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `zipCode` VARCHAR(5) NOT NULL,
  `hoursPerWeek` DECIMAL(4,2) NOT NULL,
  `vendorID` INT NULL DEFAULT NULL,
  `locID` INT NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`employeeID`),
  INDEX `deptID_idx` (`deptID` ASC) VISIBLE,
  INDEX `managerID_idx` (`managerID` ASC) VISIBLE,
  INDEX `vendorID_idx` (`vendorID` ASC) VISIBLE,
  INDEX `locationID_idx` (`locID` ASC) VISIBLE,
  CONSTRAINT `empDeptID`
    FOREIGN KEY (`deptID`)
    REFERENCES `target`.`Department` (`deptID`),
  CONSTRAINT `empLocID`
    FOREIGN KEY (`locID`)
    REFERENCES `target`.`Locations` (`locID`),
  CONSTRAINT `empVendorID`
    FOREIGN KEY (`vendorID`)
    REFERENCES `target`.`Vendors` (`vendorID`),
  CONSTRAINT `managerID`
    FOREIGN KEY (`managerID`)
    REFERENCES `target`.`Employee` (`employeeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `target`.`Grocery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Grocery` (
  `itemNum` INT NOT NULL,
  `itemName` VARCHAR(45) NOT NULL,
  `deptID` INT NOT NULL,
  `stockID` INT NOT NULL,
  `expirationDate` DATE NOT NULL,
  `price` DECIMAL(9,2) NOT NULL,
  PRIMARY KEY (`itemNum`),
  INDEX `deptID_idx` (`deptID` ASC) VISIBLE,
  INDEX `stockID_idx` (`stockID` ASC) VISIBLE,
  CONSTRAINT `groceryDeptID`
    FOREIGN KEY (`deptID`)
    REFERENCES `target`.`Department` (`deptID`),
  CONSTRAINT `groceryStockID`
    FOREIGN KEY (`stockID`)
    REFERENCES `target`.`Stock` (`stockID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `target`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Orders` (
  `orderNum` INT NOT NULL AUTO_INCREMENT,
  `orderTotal` DECIMAL(9,2) NOT NULL,
  `cardType` VARCHAR(24) NULL DEFAULT NULL,
  `cardNumber` VARCHAR(16) NULL DEFAULT NULL,
  `orderDate` DATE NOT NULL,
  `onlineVSInStore` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`orderNum`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `target`.`OrderDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`OrderDetails` (
  `orderNum` INT NOT NULL,
  `stockID` INT NOT NULL,
  `locID` INT NOT NULL,
  `orderQTY` INT NOT NULL,
  INDEX `stockID_idx` (`stockID` ASC) VISIBLE,
  INDEX `orderNum_idx` (`orderNum` ASC) VISIBLE,
  INDEX `locID_idx` (`locID` ASC) VISIBLE,
  CONSTRAINT `locationID`
    FOREIGN KEY (`locID`)
    REFERENCES `target`.`Locations` (`locID`),
  CONSTRAINT `orderNum`
    FOREIGN KEY (`orderNum`)
    REFERENCES `target`.`Orders` (`orderNum`),
  CONSTRAINT `stockID`
    FOREIGN KEY (`stockID`)
    REFERENCES `target`.`Stock` (`stockID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `target`.`RedCard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`RedCard` (
  `custID` INT NOT NULL,
  `cardNumber` VARCHAR(10) NOT NULL,
  `savings` DECIMAL(9,2) NULL DEFAULT NULL,
  PRIMARY KEY (`custID`),
  CONSTRAINT `custID`
    FOREIGN KEY (`custID`)
    REFERENCES `target`.`Customers` (`custID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `target`.`Technology`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `target`.`Technology` (
  `itemNum` INT NOT NULL,
  `itemName` VARCHAR(45) NOT NULL,
  `deptID` INT NOT NULL,
  `stockID` INT NOT NULL,
  `price` DECIMAL(9,2) NOT NULL,
  PRIMARY KEY (`itemNum`),
  INDEX `deptID_idx` (`deptID` ASC) VISIBLE,
  INDEX `stockID_idx` (`stockID` ASC) VISIBLE,
  CONSTRAINT `techDeptID`
    FOREIGN KEY (`deptID`)
    REFERENCES `target`.`Department` (`deptID`),
  CONSTRAINT `techStockID`
    FOREIGN KEY (`stockID`)
    REFERENCES `target`.`Stock` (`stockID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
