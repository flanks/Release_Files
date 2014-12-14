-- MySQL Script generated by MySQL Workbench
-- 12/14/14 12:19:16
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema a3wasteland
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema a3wasteland
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `a3wasteland` DEFAULT CHARACTER SET latin1 ;
USE `a3wasteland` ;

-- -----------------------------------------------------
-- Table `a3wasteland`.`ServerInstance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a3wasteland`.`ServerInstance` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `WarchestMoneyBLUFOR` FLOAT NOT NULL DEFAULT 0,
  `WarchestMoneyOPFOR` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2;


-- -----------------------------------------------------
-- Table `a3wasteland`.`AdminLog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a3wasteland`.`AdminLog` (
  `ServerID` INT UNSIGNED NOT NULL,
  `Time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PlayerName` VARCHAR(256) CHARACTER SET 'utf8' NOT NULL,
  `PlayerUID` VARCHAR(32) NOT NULL,
  `BattlEyeGUID` VARCHAR(32) NULL,
  `ActionType` VARCHAR(128) NOT NULL,
  `ActionValue` VARCHAR(1024) NOT NULL,
  INDEX `fk_AdminLog_ServerInstance_idx` (`ServerID` ASC),
  CONSTRAINT `fk_AdminLog_ServerInstance`
    FOREIGN KEY (`ServerID`)
    REFERENCES `a3wasteland`.`ServerInstance` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `a3wasteland`.`AntihackLog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a3wasteland`.`AntihackLog` (
  `ServerID` INT UNSIGNED NOT NULL,
  `Time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PlayerName` VARCHAR(256) CHARACTER SET 'utf8' NOT NULL,
  `PlayerUID` VARCHAR(32) NOT NULL,
  `BattlEyeGUID` VARCHAR(32) NULL,
  `HackType` VARCHAR(128) NOT NULL,
  `HackValue` VARCHAR(1024) NOT NULL,
  `KickOnJoin` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
  `AdminNote` VARCHAR(4096) CHARACTER SET 'utf8' NULL,
  INDEX `fk_AntihackLog_ServerInstance_idx` (`ServerID` ASC),
  INDEX `idx_AntihackLog_kickOnJoin` (`PlayerUID` ASC, `KickOnJoin` DESC),
  CONSTRAINT `fk_AntihackLog_ServerInstance`
    FOREIGN KEY (`ServerID`)
    REFERENCES `a3wasteland`.`ServerInstance` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `a3wasteland`.`DBInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a3wasteland`.`DBInfo` (
  `Name` VARCHAR(128) NOT NULL,
  `Value` VARCHAR(1024) NOT NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `a3wasteland`.`PlayerInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a3wasteland`.`PlayerInfo` (
  `UID` VARCHAR(32) NOT NULL,
  `CreationDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `Name` VARCHAR(256) CHARACTER SET 'utf8' NULL,
  `LastSide` VARCHAR(128) NULL,
  `BankMoney` FLOAT NOT NULL DEFAULT 0,
  `BattlEyeGUID` VARCHAR(32) NULL,
  PRIMARY KEY (`UID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `a3wasteland`.`ServerMap`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a3wasteland`.`ServerMap` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `WorldName` VARCHAR(128) NOT NULL,
  `Environment` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `idx_ServerMap_uniqueWorldEnv` (`WorldName` ASC, `Environment` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 2;


-- -----------------------------------------------------
-- Table `a3wasteland`.`PlayerSave`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a3wasteland`.`PlayerSave` (
  `PlayerUID` VARCHAR(32) NOT NULL,
  `MapID` INT UNSIGNED NOT NULL,
  `CreationDate` TIMESTAMP NULL,
  `LastModified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Position` VARCHAR(256) NOT NULL DEFAULT '[]',
  `Direction` FLOAT NOT NULL DEFAULT 0,
  `Damage` FLOAT NOT NULL DEFAULT 0,
  `HitPoints` VARCHAR(1024) NOT NULL DEFAULT '[]',
  `Hunger` FLOAT NOT NULL DEFAULT 100,
  `Thirst` FLOAT NOT NULL DEFAULT 100,
  `Money` FLOAT NOT NULL DEFAULT 0,
  `CurrentWeapon` VARCHAR(128) NOT NULL DEFAULT '\"\"',
  `Stance` VARCHAR(128) NOT NULL DEFAULT '\"\"',
  `Headgear` VARCHAR(128) NOT NULL DEFAULT '\"\"',
  `Goggles` VARCHAR(128) NOT NULL DEFAULT '\"\"',
  `Uniform` VARCHAR(128) NOT NULL DEFAULT '\"\"',
  `Vest` VARCHAR(128) NOT NULL DEFAULT '\"\"',
  `Backpack` VARCHAR(128) NOT NULL DEFAULT '\"\"',
  `UniformWeapons` VARCHAR(1024) NOT NULL DEFAULT '[]',
  `UniformItems` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `UniformMagazines` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `VestWeapons` VARCHAR(1024) NOT NULL DEFAULT '[]',
  `VestItems` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `VestMagazines` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `BackpackWeapons` VARCHAR(2048) NOT NULL DEFAULT '[]',
  `BackpackItems` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `BackpackMagazines` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `PrimaryWeapon` VARCHAR(128) NOT NULL DEFAULT '\"\"',
  `SecondaryWeapon` VARCHAR(128) NOT NULL DEFAULT '\"\"',
  `HandgunWeapon` VARCHAR(128) NOT NULL DEFAULT '\"\"',
  `PrimaryWeaponItems` VARCHAR(512) NOT NULL DEFAULT '[]',
  `SecondaryWeaponItems` VARCHAR(512) NOT NULL DEFAULT '[]',
  `HandgunItems` VARCHAR(512) NOT NULL DEFAULT '[]',
  `AssignedItems` VARCHAR(512) NOT NULL DEFAULT '[]',
  `LoadedMagazines` VARCHAR(1024) NOT NULL DEFAULT '[]',
  `WastelandItems` VARCHAR(1024) NOT NULL DEFAULT '[]',
  PRIMARY KEY (`PlayerUID`, `MapID`),
  INDEX `fk_PlayerSave_ServerMap_idx` (`MapID` ASC),
  CONSTRAINT `fk_PlayerSave_PlayerInfo`
    FOREIGN KEY (`PlayerUID`)
    REFERENCES `a3wasteland`.`PlayerInfo` (`UID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PlayerSave_ServerMap`
    FOREIGN KEY (`MapID`)
    REFERENCES `a3wasteland`.`ServerMap` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `a3wasteland`.`ServerObjects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a3wasteland`.`ServerObjects` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ServerID` INT UNSIGNED NOT NULL,
  `MapID` INT UNSIGNED NOT NULL,
  `CreationDate` TIMESTAMP NULL,
  `LastInteraction` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Class` VARCHAR(128) NOT NULL DEFAULT 'nil',
  `Position` VARCHAR(256) NOT NULL DEFAULT 'nil',
  `Direction` VARCHAR(256) NOT NULL DEFAULT '[]',
  `Locked` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  `Damage` FLOAT NOT NULL DEFAULT 0,
  `AllowDamage` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
  `Variables` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `Weapons` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `Magazines` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `Items` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `Backpacks` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `TurretMagazines` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `AmmoCargo` FLOAT NOT NULL DEFAULT 0,
  `FuelCargo` FLOAT NOT NULL DEFAULT 0,
  `RepairCargo` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_ServerObjects_ServerInstance_idx` (`ServerID` ASC),
  INDEX `fk_ServerObjects_ServerMap_idx` (`MapID` ASC),
  CONSTRAINT `fk_ServerObjects_ServerInstance`
    FOREIGN KEY (`ServerID`)
    REFERENCES `a3wasteland`.`ServerInstance` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ServerObjects_ServerMap`
    FOREIGN KEY (`MapID`)
    REFERENCES `a3wasteland`.`ServerMap` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 12;


-- -----------------------------------------------------
-- Table `a3wasteland`.`ServerVehicles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a3wasteland`.`ServerVehicles` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ServerID` INT UNSIGNED NOT NULL,
  `MapID` INT UNSIGNED NOT NULL,
  `CreationDate` TIMESTAMP NULL,
  `LastUsed` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Class` VARCHAR(128) NOT NULL DEFAULT 'nil',
  `Position` VARCHAR(256) NOT NULL DEFAULT 'nil',
  `Direction` VARCHAR(256) NOT NULL DEFAULT '[]',
  `Velocity` VARCHAR(256) NOT NULL DEFAULT '[]',
  `Flying` TINYINT(1) NOT NULL DEFAULT 0,
  `Damage` FLOAT NOT NULL DEFAULT 0,
  `Fuel` FLOAT NOT NULL DEFAULT 0,
  `HitPoints` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `Variables` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `Textures` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `Weapons` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `Magazines` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `Items` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `Backpacks` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `TurretMagazines` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `TurretMagazines2` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `TurretMagazines3` VARCHAR(4096) NOT NULL DEFAULT '[]',
  `AmmoCargo` FLOAT NOT NULL DEFAULT 0,
  `FuelCargo` FLOAT NOT NULL DEFAULT 0,
  `RepairCargo` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_ServerVehicles_ServerInstance_idx` (`ServerID` ASC),
  INDEX `fk_ServerVehicles_ServerMap_idx` (`MapID` ASC),
  CONSTRAINT `fk_ServerVehicles_ServerInstance`
    FOREIGN KEY (`ServerID`)
    REFERENCES `a3wasteland`.`ServerInstance` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ServerVehicles_ServerMap`
    FOREIGN KEY (`MapID`)
    REFERENCES `a3wasteland`.`ServerMap` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 12;


-- -----------------------------------------------------
-- Table `a3wasteland`.`PlayerStats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a3wasteland`.`PlayerStats` (
  `PlayerUID` VARCHAR(32) NOT NULL,
  `LastModified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `PlayerKills` INT UNSIGNED NOT NULL DEFAULT 0,
  `AIKills` INT UNSIGNED NOT NULL DEFAULT 0,
  `TeamKills` INT UNSIGNED NOT NULL DEFAULT 0,
  `DeathCount` INT UNSIGNED NOT NULL DEFAULT 0,
  `ReviveCount` INT UNSIGNED NOT NULL DEFAULT 0,
  `CaptureCount` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`PlayerUID`),
  CONSTRAINT `fk_PlayerStats_PlayerInfo`
    FOREIGN KEY (`PlayerUID`)
    REFERENCES `a3wasteland`.`PlayerInfo` (`UID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
