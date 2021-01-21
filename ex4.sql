-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specialist` (
  `Field_area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Field_area`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical` (
  `Overtime_rate` INT NOT NULL,
  PRIMARY KEY (`Overtime_rate`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor` (
  `Name` VARCHAR(45) NOT NULL,
  `Date_of_birth` DATE NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` INT NULL,
  `Salary` INT NULL,
  `Specialist_Field_area` VARCHAR(45) NOT NULL,
  `Medical_Overtime_rate` INT NOT NULL,
  PRIMARY KEY (`Name`),
  INDEX `fk_Doctor_Specialist_idx` (`Specialist_Field_area` ASC),
  INDEX `fk_Doctor_Medical1_idx` (`Medical_Overtime_rate` ASC),
  CONSTRAINT `fk_Doctor_Specialist`
    FOREIGN KEY (`Specialist_Field_area`)
    REFERENCES `mydb`.`Specialist` (`Field_area`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctor_Medical1`
    FOREIGN KEY (`Medical_Overtime_rate`)
    REFERENCES `mydb`.`Medical` (`Overtime_rate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` INT NULL,
  `Date_of_birth` DATE NULL,
  `Doctor_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`),
  INDEX `fk_Patient_Doctor1_idx` (`Doctor_Name` ASC),
  CONSTRAINT `fk_Patient_Doctor1`
    FOREIGN KEY (`Doctor_Name`)
    REFERENCES `mydb`.`Doctor` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment` (
  `Date` DATE NOT NULL,
  `Time` VARCHAR(45) NULL,
  `Patient_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Date`),
  INDEX `fk_Appointment_Patient1_idx` (`Patient_Name` ASC),
  CONSTRAINT `fk_Appointment_Patient1`
    FOREIGN KEY (`Patient_Name`)
    REFERENCES `mydb`.`Patient` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `Total` INT NOT NULL,
  `Patient_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Total`),
  INDEX `fk_Bill_Patient1_idx` (`Patient_Name` ASC),
  CONSTRAINT `fk_Bill_Patient1`
    FOREIGN KEY (`Patient_Name`)
    REFERENCES `mydb`.`Patient` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `Details` INT NOT NULL,
  `Method` VARCHAR(45) NULL,
  PRIMARY KEY (`Details`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill_has_Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill_has_Payment` (
  `Bill_Total` INT NOT NULL,
  `Payment_Details` INT NOT NULL,
  PRIMARY KEY (`Bill_Total`, `Payment_Details`),
  INDEX `fk_Bill_has_Payment_Payment1_idx` (`Payment_Details` ASC),
  INDEX `fk_Bill_has_Payment_Bill1_idx` (`Bill_Total` ASC),
  CONSTRAINT `fk_Bill_has_Payment_Bill1`
    FOREIGN KEY (`Bill_Total`)
    REFERENCES `mydb`.`Bill` (`Total`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bill_has_Payment_Payment1`
    FOREIGN KEY (`Payment_Details`)
    REFERENCES `mydb`.`Payment` (`Details`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
