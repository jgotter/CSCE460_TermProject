-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mytarget
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mytarget
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mytarget` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema target
-- -----------------------------------------------------
USE `mytarget` ;

-- -----------------------------------------------------
-- Table `mytarget`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytarget`.`Customers` (
  `custID` INT NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `streetAddress` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `zipCode` VARCHAR(5) NOT NULL,
  `phoneNum` VARCHAR(12) NULL,
  PRIMARY KEY (`custID`))
ENGINE = Innotarget;


-- -----------------------------------------------------
-- Table `mytarget`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytarget`.`Orders` (
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
    REFERENCES `mytarget`.`Customers` (`custID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = Innotarget;


-- -----------------------------------------------------
-- Table `mytarget`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytarget`.`Department` (
  `deptID` INT NOT NULL,
  `deptName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`deptID`))
ENGINE = Innotarget;


-- -----------------------------------------------------
-- Table `mytarget`.`Locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytarget`.`Locations` (
  `locID` INT NOT NULL,
  `locName` VARCHAR(45) NOT NULL,
  `streetAddress` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `zipCode` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`locID`))
ENGINE = Innotarget;


-- -----------------------------------------------------
-- Table `mytarget`.`Vendors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytarget`.`Vendors` (
  `vendorID` INT NOT NULL,
  `vendorName` VARCHAR(45) NOT NULL,
  `vendorCity` VARCHAR(45) NOT NULL,
  `vendorState` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`vendorID`))
ENGINE = Innotarget;


-- -----------------------------------------------------
-- Table `mytarget`.`Stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytarget`.`Stock` (
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
    REFERENCES `mytarget`.`Department` (`deptID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `vendorID`
    FOREIGN KEY (`vendorID`)
    REFERENCES `mytarget`.`Vendors` (`vendorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `locID`
    FOREIGN KEY (`locID`)
    REFERENCES `mytarget`.`Locations` (`locID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = Innotarget;


-- -----------------------------------------------------
-- Table `mytarget`.`OrderDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytarget`.`OrderDetails` (
  `orderNum` INT NOT NULL,
  `stockID` INT NOT NULL,
  `locID` INT NOT NULL,
  `orderQTY` INT NOT NULL,
  INDEX `stockID_idx` (`stockID` ASC) VISIBLE,
  INDEX `orderNum_idx` (`orderNum` ASC) VISIBLE,
  INDEX `locID_idx` (`locID` ASC) VISIBLE,
  CONSTRAINT `stockID`
    FOREIGN KEY (`stockID`)
    REFERENCES `mytarget`.`Stock` (`stockID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orderNum`
    FOREIGN KEY (`orderNum`)
    REFERENCES `mytarget`.`Orders` (`orderNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `locationID`
    FOREIGN KEY (`locID`)
    REFERENCES `mytarget`.`Locations` (`locID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = Innotarget;


-- -----------------------------------------------------
-- Table `mytarget`.`Grocery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytarget`.`Grocery` (
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
    REFERENCES `mytarget`.`Department` (`deptID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `groceryStockID`
    FOREIGN KEY (`stockID`)
    REFERENCES `mytarget`.`Stock` (`stockID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = Innotarget;


-- -----------------------------------------------------
-- Table `mytarget`.`Technology`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytarget`.`Technology` (
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
    REFERENCES `mytarget`.`Department` (`deptID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `techStockID`
    FOREIGN KEY (`stockID`)
    REFERENCES `mytarget`.`Stock` (`stockID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = Innotarget;


-- -----------------------------------------------------
-- Table `mytarget`.`Clothing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytarget`.`Clothing` (
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
    REFERENCES `mytarget`.`Department` (`deptID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `clothingStockID`
    FOREIGN KEY (`stockID`)
    REFERENCES `mytarget`.`Stock` (`stockID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = Innotarget;


-- -----------------------------------------------------
-- Table `mytarget`.`RedCard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytarget`.`RedCard` (
  `custID` INT NOT NULL,
  `cardNumber` VARCHAR(10) NOT NULL,
  `savings` DECIMAL(9,2) NULL,
  PRIMARY KEY (`custID`),
  CONSTRAINT `custID`
    FOREIGN KEY (`custID`)
    REFERENCES `mytarget`.`Customers` (`custID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = Innotarget;


-- -----------------------------------------------------
-- Table `mytarget`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mytarget`.`Employee` (
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
    REFERENCES `mytarget`.`Department` (`deptID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `managerID`
    FOREIGN KEY (`managerID`)
    REFERENCES `mytarget`.`Employee` (`employeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `empVendorID`
    FOREIGN KEY (`vendorID`)
    REFERENCES `mytarget`.`Vendors` (`vendorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `empLocID`
    FOREIGN KEY (`locID`)
    REFERENCES `mytarget`.`Locations` (`locID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = Innotarget;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
