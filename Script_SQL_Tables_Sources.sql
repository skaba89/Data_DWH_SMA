
CREATE OR REPLACE TABLE Employee (
    BusinessEntityID INT NOT NULL,
    NationalIDNumber STRING(15) NOT NULL,
    LoginID STRING(256) NOT NULL,
    OrganizationNode  STRING(50),
    OrganizationLevel  STRING(50),
    JobTitle STRING(50) NOT NULL,
    BirthDate DATE NOT NULL,
    MaritalStatus CHAR(1) NOT NULL,
    Gender CHAR(1) NOT NULL,
    HireDate DATE NOT NULL,
    SalariedFlag BOOLEAN NOT NULL,
    VacationHours SMALLINT NOT NULL,
    SickLeaveHours SMALLINT NOT NULL,
    CurrentFlag BOOLEAN NOT NULL,
    rowguid STRING NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL,
    CONSTRAINT PK_Employee_BusinessEntityID PRIMARY KEY (BusinessEntityID)
);

CREATE OR REPLACE TABLE EmployeeDepartmentHistory (
    BusinessEntityID INT NOT NULL,
    DepartmentID SMALLINT NOT NULL,
    ShiftID TINYINT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    ModifiedDate TIMESTAMP_NTZ NOT NULL,
    CONSTRAINT PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID PRIMARY KEY (BusinessEntityID, StartDate, DepartmentID, ShiftID)
);

CREATE OR REPLACE TABLE EmployeePayHistory (
    BusinessEntityID INT NOT NULL,
    RateChangeDate TIMESTAMP_NTZ NOT NULL,
    Rate FLOAT NOT NULL,
    PayFrequency NUMBER NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL,
    CONSTRAINT PK_EmployeePayHistory_BusinessEntityID_RateChangeDate PRIMARY KEY (BusinessEntityID, RateChangeDate)
);

CREATE OR REPLACE TABLE Address (
    AddressID INT AUTOINCREMENT PRIMARY KEY,
    AddressLine1 STRING(60) NOT NULL,
    AddressLine2 STRING(60),
    City STRING(30) NOT NULL,
    StateProvinceID INT NOT NULL,
    PostalCode STRING(15) NOT NULL,
    SpatialLocation GEOGRAPHY,
    rowguid STRING NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL
);

CREATE OR REPLACE TABLE BusinessEntity (
    BusinessEntityID INT AUTOINCREMENT PRIMARY KEY,
    rowguid STRING NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL
);

CREATE OR REPLACE TABLE CountryRegion (
    CountryRegionCode STRING(3) NOT NULL,
    Name STRING NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL,
    CONSTRAINT PK_CountryRegion_CountryRegionCode PRIMARY KEY (CountryRegionCode)
);

CREATE OR REPLACE TABLE Person (
    BusinessEntityID INT NOT NULL,
    PersonType CHAR(2) NOT NULL,
    NameStyle BOOLEAN NOT NULL,
    Title STRING(8),
    FirstName STRING NOT NULL,
    MiddleName STRING,
    LastName STRING NOT NULL,
    Suffix STRING(10),
    EmailPromotion INT NOT NULL,
    AdditionalContactInfo VARIANT,
    Demographics VARIANT,
    rowguid STRING NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL,
    CONSTRAINT PK_Person_BusinessEntityID PRIMARY KEY (BusinessEntityID)
);

CREATE OR REPLACE TABLE StateProvince (
    StateProvinceID INT AUTOINCREMENT PRIMARY KEY,
    StateProvinceCode CHAR(3) NOT NULL,
    CountryRegionCode STRING(3) NOT NULL,
    IsOnlyStateProvinceFlag BOOLEAN NOT NULL,
    Name STRING NOT NULL,
    TerritoryID INT NOT NULL,
    rowguid STRING NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL
);

CREATE OR REPLACE TABLE Product (
    ProductID INT AUTOINCREMENT PRIMARY KEY,
    Name STRING NOT NULL,
    ProductNumber STRING(25) NOT NULL,
    MakeFlag BOOLEAN NOT NULL,
    FinishedodsFlag BOOLEAN NOT NULL,
    Color STRING(15),
    SafetyStockLevel SMALLINT NOT NULL,
    ReorderPoint SMALLINT NOT NULL,
    StandardCost FLOAT NOT NULL,
    ListPrice FLOAT NOT NULL,
    Size STRING(5),
    SizeUnitMeasureCode CHAR(3),
    WeightUnitMeasureCode CHAR(3),
    Weight DECIMAL(8, 2),
    DaysToManufacture INT NOT NULL,
    ProductLine CHAR(2),
    Class CHAR(2),
    Style CHAR(2),
    ProductSubcateryID INT,
    ProductModelID INT,
    SellStartDate TIMESTAMP_NTZ NOT NULL,
    SellEndDate TIMESTAMP_NTZ,
    DiscontinuedDate TIMESTAMP_NTZ,
    rowguid STRING NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL
);

CREATE OR REPLACE TABLE PurchaseOrderDetail (
    PurchaseOrderID INT NOT NULL,
    PurchaseOrderDetailID INT AUTOINCREMENT NOT NULL,
    DueDate TIMESTAMP_NTZ NOT NULL,
    OrderQty NUMBER NOT NULL,
    ProductID INT NOT NULL,
    UnitPrice FLOAT NOT NULL,
    ReceivedQty DECIMAL(8, 2) NOT NULL,
    RejectedQty DECIMAL(8, 2) NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL,
    CONSTRAINT PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID PRIMARY KEY (PurchaseOrderID, PurchaseOrderDetailID)
);

CREATE OR REPLACE TABLE PurchaseOrderHeader (
    PurchaseOrderID INT AUTOINCREMENT PRIMARY KEY,
    RevisionNumber TINYINT NOT NULL,
    Status NUMBER NOT NULL,
    EmployeeID INT NOT NULL,
    VendorID INT NOT NULL,
    ShipMethodID INT NOT NULL,
    OrderDate TIMESTAMP_NTZ NOT NULL,
    ShipDate TIMESTAMP_NTZ,
    SubTotal FLOAT NOT NULL,
    TaxAmt FLOAT NOT NULL,
    Freight FLOAT NOT NULL,
    TotalDue FLOAT NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL
);

CREATE OR REPLACE TABLE CountryRegionCurrency (
    CountryRegionCode STRING(3) NOT NULL,
    CurrencyCode CHAR(3) NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL,
    CONSTRAINT PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode PRIMARY KEY (CountryRegionCode, CurrencyCode)
);

CREATE OR REPLACE TABLE Currency (
    CurrencyCode CHAR(3) NOT NULL,
    Name STRING NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL,
    CONSTRAINT PK_Currency_CurrencyCode PRIMARY KEY (CurrencyCode)
);

CREATE OR REPLACE TABLE CurrencyRate (
    CurrencyRateID INT AUTOINCREMENT PRIMARY KEY,
    CurrencyRateDate TIMESTAMP_NTZ NOT NULL,
    FromCurrencyCode CHAR(3) NOT NULL,
    ToCurrencyCode CHAR(3) NOT NULL,
    AverageRate FLOAT NOT NULL,
    EndOfDayRate FLOAT NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL
);

CREATE OR REPLACE TABLE Customer (
    CustomerID INT AUTOINCREMENT PRIMARY KEY,
    PersonID INT,
    StoreID INT,
    TerritoryID INT,
    AccountNumber STRING ,
    rowguid NUMBER NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL
);

CREATE OR REPLACE TABLE SalesOrderDetail (
    SalesOrderID INT NOT NULL,
    SalesOrderDetailID INT AUTOINCREMENT NOT NULL,
    CarrierTrackingNumber STRING(25),
    OrderQty NUMBER NOT NULL,
    ProductID INT NOT NULL,
    SpecialOfferID INT NOT NULL,
    UnitPrice FLOAT NOT NULL,
    UnitPriceDiscount FLOAT NOT NULL,
    LineTotal FLOAT ,
    rowguid STRING NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL,
    CONSTRAINT PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID PRIMARY KEY (SalesOrderID, SalesOrderDetailID)
);

CREATE OR REPLACE TABLE SalesOrderHeader (
    SalesOrderID INT AUTOINCREMENT PRIMARY KEY,
    RevisionNumber NUMBER NOT NULL,
    OrderDate TIMESTAMP_NTZ NOT NULL,
    DueDate TIMESTAMP_NTZ NOT NULL,
    ShipDate TIMESTAMP_NTZ,
    Status NUMBER NOT NULL,
    OnlineOrderFlag BOOLEAN NOT NULL,
    SalesOrderNumber STRING ,
    PurchaseOrderNumber STRING,
    AccountNumber STRING,
    CustomerID INT NOT NULL,
    SalesPersonID INT,
    TerritoryID INT,
    BillToAddressID INT NOT NULL,
    ShipToAddressID INT NOT NULL,
    ShipMethodID INT NOT NULL,
    CreditCardID INT,
    CreditCardApprovalCode VARCHAR(15),
    CurrencyRateID INT,
    SubTotal FLOAT NOT NULL,
    TaxAmt FLOAT NOT NULL,
    Freight FLOAT NOT NULL,
    TotalDue FLOAT ,
    Comment STRING(128),
    rowguid STRING NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL
);

CREATE OR REPLACE TABLE SalesTerritory (
    TerritoryID INT AUTOINCREMENT PRIMARY KEY,
    Name STRING NOT NULL,
    CountryRegionCode STRING(3) NOT NULL,
    Groupe STRING(50) NOT NULL,
    SalesYTD FLOAT NOT NULL,
    SalesLastYear FLOAT NOT NULL,
    CostYTD FLOAT NOT NULL,
    CostLastYear FLOAT NOT NULL,
    rowguid STRING NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL
);

CREATE OR REPLACE TABLE SalesTerritoryHistory (
    BusinessEntityID INT NOT NULL,
    TerritoryID INT NOT NULL,
    StartDate TIMESTAMP_NTZ NOT NULL,
    EndDate TIMESTAMP_NTZ,
    rowguid STRING NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL,
    CONSTRAINT PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID PRIMARY KEY (BusinessEntityID, StartDate, TerritoryID)
);

CREATE OR REPLACE TABLE Store (
    BusinessEntityID INT NOT NULL,
    Name STRING NOT NULL,
    SalesPersonID INT,
    Demographics VARIANT,
    rowguid STRING NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL,
    CONSTRAINT PK_Store_BusinessEntityID PRIMARY KEY (BusinessEntityID)
);


1- sur le champ AccountNumber dans la table customer 
Dans la tble Customer il faut appliquer la règle de gestion suivante
GENERATED ALWAYS AS ('AW' || LPAD(CustomerID::STRING, 8, '0')) STORED

pour chaque magasin on fait du LPAD de 8 caractères sur l'id customer et ajouter AW au debut de la valeur

2- SUr le champ LineTotal dans la table SalesOrderDetail
LineTotal FLOAT GENERATED ALWAYS AS (COALESCE((UnitPrice * (1.0 - UnitPriceDiscount)) * OrderQty, 0.0)) VIRTUAL,

3- Sur le champ SalesOrderNumber dans la table SalesOrderHeader
SalesOrderNumber STRING GENERATED ALWAYS AS ('SO' || LPAD(SalesOrderID::STRING, 8, '0')) STORED dans la table SalesOrder

Sur le champ TotalDue dans la table SalesOrderHeader
TotalDue FLOAT GENERATED ALWAYS AS (COALESCE(SubTotal + TaxAmt + Freight, 0)) STORED,