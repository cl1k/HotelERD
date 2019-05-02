CREATE DATABASE IF NOT EXISTS HotelDB;

USE HotelDB;

CREATE TABLE Room (
    RoomId INT PRIMARY KEY AUTO_INCREMENT,
    RoomTypeId INT NOT NULL
);

CREATE TABLE Customer (
    CustomerId INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(45) NOT NULL,
    LastName VARCHAR(45) NOT NULL,
    PhoneNumber CHAR(10) NOT NULL,
    Email VARCHAR(45)
);

CREATE TABLE Reservation (
    ReservationId INT PRIMARY KEY AUTO_INCREMENT,
    CustomerId INT NOT NULL,
    BillingId INT NOT NULL,
    FromDate DATE,
    ToDate DATE
);

CREATE TABLE Guest (
    GuestId INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(45) NOT NULL,
    LastName VARCHAR(45) NOT NULL,
    Age TINYINT NOT NULL,
    ReservationId INT NOT NULL
);

CREATE TABLE AddOn (
    AddOnId INT PRIMARY KEY AUTO_INCREMENT,
    ItemName VARCHAR(45) NOT NULL,
    Description TEXT
);

CREATE TABLE Billing (
    BillingId INT PRIMARY KEY AUTO_INCREMENT,
    Total DECIMAL(10 , 2 ),
    Tax DECIMAL(8 , 2 )
);

CREATE TABLE Promotions (
    PromotionsId VARCHAR(45) PRIMARY KEY,
    FromDate DATE,
    ToDate DATE
);

CREATE TABLE Amenity (
    AmenityId INT PRIMARY KEY AUTO_INCREMENT,
    AmenityName VARCHAR(45),
    AmenityDetails TEXT
);

CREATE TABLE CostScaling (
    CostScalingId INT PRIMARY KEY AUTO_INCREMENT,
    Reason VARCHAR(45),
    RateIncrease DECIMAL,
    RateDecrease DECIMAL
);

CREATE TABLE RoomType (
    RoomTypeId INT PRIMARY KEY AUTO_INCREMENT,
    RoomType VARCHAR(10) NOT NULL,
    MaxOccupancy INT
);

CREATE TABLE RoomAmenities (
    RoomId INT NOT NULL,
    AmenityId INT NOT NULL
);

CREATE TABLE RoomPrice (
    RoomPriceId INT PRIMARY KEY AUTO_INCREMENT,
    RoomId INT NOT NULL,
    PricePerNight DECIMAL(5 , 2 ) NOT NULL,
    FromDate DATE,
    ToDate DATE
);

CREATE TABLE RoomReservation (
    RoomId INT NOT NULL,
    ReservationId INT NOT NULL
);

CREATE TABLE RoomPriceCostScaling (
    RoomPriceId INT NOT NULL,
    CostScalingId INT NOT NULL
);

CREATE TABLE AddOnPrice (
    AddOnPriceId INT PRIMARY KEY AUTO_INCREMENT,
    AddOnId INT NOT NULL,
    Price DECIMAL(5 , 2 ) NOT NULL,
    FromDate DATE,
    ToDate DATE
);

CREATE TABLE AddOnReservation (
    AddOnId INT NOT NULL,
    ReservationId INT NOT NULL
);

CREATE TABLE AddOnPriceCostScaling (
    AddOnPriceId INT NOT NULL,
    CostScalingId INT NOT NULL
);

CREATE TABLE AddOnPriceBilling (
    AddOnPriceId INT NOT NULL,
    BillingId INT NOT NULL,
    Details TEXT
);

CREATE TABLE BillingPromotions (
    BillingId INT NOT NULL,
    PromotionsId VARCHAR(45) NOT NULL
);

ALTER TABLE Reservation 
    ADD CONSTRAINT fk_CustomerId
        FOREIGN KEY (CustomerId)
        REFERENCES Customer(CustomerId),
    ADD CONSTRAINT fk_BillingId
        FOREIGN KEY (BillingId)
        REFERENCES Billing(BillingId);

ALTER TABLE RoomReservation
    ADD CONSTRAINT pk_RoomReservation
        PRIMARY KEY (RoomId, ReservationId),
    ADD CONSTRAINT fk_RoomReservation_Room
        FOREIGN KEY (RoomId)
        REFERENCES Room(RoomId),
    ADD CONSTRAINT fk_RoomReservation_Reservation
        FOREIGN KEY (ReservationId)
        REFERENCES Reservation(ReservationId);

ALTER TABLE AddOnReservation
    ADD CONSTRAINT pk_AddOnReservation
        PRIMARY KEY (AddOnId, ReservationId),
    ADD CONSTRAINT fk_AddOnReservation_AddOn
        FOREIGN KEY (AddOnId)
        REFERENCES AddOn(AddOnId),
    ADD CONSTRAINT fk_AddOnReservation_Reservation
        FOREIGN KEY (ReservationId)
        REFERENCES Reservation(ReservationId);

ALTER TABLE AddOnPrice
    ADD CONSTRAINT fk_AddOnId
        FOREIGN KEY (AddOnId)
        REFERENCES AddOn(AddOnId);

ALTER TABLE AddOnPriceCostScaling
    ADD CONSTRAINT pk_AddOnPriceCostScaling
        PRIMARY KEY (AddOnPriceId, CostScalingId),
    ADD CONSTRAINT fk_AddOnPriceCostScaling_AddOnPrice
        FOREIGN KEY (AddOnPriceId)
        REFERENCES AddOnPrice(AddOnPriceId),
    ADD CONSTRAINT fk_AddOnPriceCostScaling_CostScaling
        FOREIGN KEY (CostScalingId)
        REFERENCES CostScaling(CostScalingId);

ALTER TABLE RoomPriceCostScaling
    ADD CONSTRAINT pk_RoomPriceCostScaling
        PRIMARY KEY (RoomPriceId, CostScalingId),
    ADD CONSTRAINT fk_RoomPriceCostScaling_RoomPrice
        FOREIGN KEY (RoomPriceId)
        REFERENCES RoomPrice(RoomPriceId),
    ADD CONSTRAINT fk_RoomPriceCostScaling_CostScaling
        FOREIGN KEY (CostScalingId)
        REFERENCES CostScaling(CostScalingId);

ALTER TABLE AddOnPriceBilling
    ADD CONSTRAINT pk_AddOnPriceBilling
        PRIMARY KEY (AddOnPriceId, BillingId),
    ADD CONSTRAINT fk_AddOnPriceBilling_AddOnPrice
        FOREIGN KEY (AddOnPriceId)
        REFERENCES AddOnPrice(AddOnPriceId),
    ADD CONSTRAINT fk_AddOnPriceBilling_Billing
        FOREIGN KEY (BillingId)
        REFERENCES Billing(BillingId);

ALTER TABLE BillingPromotions
    ADD CONSTRAINT pk_BillingPromotions
        PRIMARY KEY (BillingId, PromotionsId),
    ADD CONSTRAINT fk_BillingPromotions_Billing
        FOREIGN KEY (BillingId)
        REFERENCES Billing(BillingId),
    ADD CONSTRAINT fk_BillingPromotions_Promotions
        FOREIGN KEY (PromotionsId)
        REFERENCES Promotions(PromotionsId);

ALTER TABLE RoomAmenities
    ADD CONSTRAINT pk_RoomAmenities
        PRIMARY KEY (RoomId, AmenityId),
    ADD CONSTRAINT fk_RoomAmenities_Room
        FOREIGN KEY (RoomId)
        REFERENCES Room(RoomId),
    ADD CONSTRAINT fk_RoomAmenities_Amenity
        FOREIGN KEY (AmenityId)
        REFERENCES Amenity(AmenityId);

ALTER TABLE Room
    ADD CONSTRAINT fk_RoomType
        FOREIGN KEY (RoomTypeId)
        REFERENCES RoomType(RoomTypeId);

ALTER TABLE RoomPrice
    ADD CONSTRAINT fk_Room
        FOREIGN KEY (RoomId)
        REFERENCES Room(RoomId);