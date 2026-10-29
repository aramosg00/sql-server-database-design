-- CUSTOMER
CREATE TABLE CUSTOMER_T (
  CustomerID        INT           PRIMARY KEY,
  CustomerName      VARCHAR(100)  NOT NULL,
  Address           VARCHAR(200),
  City              VARCHAR(50),
  State             VARCHAR(50),
  PostalCode        VARCHAR(20),
  Country           VARCHAR(50),
  Phone             VARCHAR(20)
);

-- EMPLOYEE
CREATE TABLE EMPLOYEE_T (
  EmployeeID        INT           PRIMARY KEY,
  LastName          VARCHAR(50)   NOT NULL,
  FirstName         VARCHAR(50)   NOT NULL,
  Title             VARCHAR(100),
  HireDate          DATE,
  Address           VARCHAR(200),
  City              VARCHAR(50),
  Region            VARCHAR(50),
  PostalCode        VARCHAR(20),
  Country           VARCHAR(50),
  Phone             VARCHAR(20)
);

-- COURSE
CREATE TABLE COURSE_T (
  CourseID          INT           PRIMARY KEY,
  CourseDescription VARCHAR(200)
);

-- EMPLOYEE ↔ COURSE (M–N)
CREATE TABLE EMPLOYEE_COURSE_T (
  EmployeeID  INT           NOT NULL,
  CourseID    INT           NOT NULL,
  PRIMARY KEY (EmployeeID, CourseID),
  FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE_T(EmployeeID),
  FOREIGN KEY (CourseID)   REFERENCES COURSE_T(CourseID)
);

-- SALES REPRESENTATIVE (self-FK for Manager)
CREATE TABLE SALES_REPRESENTATIVE_T (
  SalesRepID       INT           PRIMARY KEY,
  CommissionRate   DECIMAL(5,2),
  ManagerID        INT,
  FOREIGN KEY (ManagerID) REFERENCES SALES_REPRESENTATIVE_T(SalesRepID)
);

-- PRODUCT
CREATE TABLE PRODUCT_T (
  ProductID       INT           PRIMARY KEY,
  ProdName        VARCHAR(100)  NOT NULL,
  ProdDesc        VARCHAR(500),
  UnitPrice       DECIMAL(10,2),
  UnitsInStock    INT
);

-- SUPPLIER
CREATE TABLE SUPPLIER_T (
  SupplierID      INT           PRIMARY KEY,
  SupplierName    VARCHAR(100)  NOT NULL,
  Address         VARCHAR(200),
  City            VARCHAR(50),
  PostalCode      VARCHAR(20),
  Country         VARCHAR(50),
  Phone           VARCHAR(20)
);

-- PRODUCT ↔ SUPPLIER (M–N)
CREATE TABLE PRODUCT_SUPPLIER_T (
  ProductID  INT NOT NULL,
  SupplierID INT NOT NULL,
  PRIMARY KEY (ProductID, SupplierID),
  FOREIGN KEY (ProductID)  REFERENCES PRODUCT_T(ProductID),
  FOREIGN KEY (SupplierID) REFERENCES SUPPLIER_T(SupplierID)
);

-- FACT TABLE (Time-series for product qty)
CREATE TABLE FACTTABLE_T (
  ProductID INT       NOT NULL,
  MonthYear CHAR(7)   NOT NULL,  -- e.g. '2025-04'
  ProdQty   INT,
  PRIMARY KEY (ProductID, MonthYear),
  FOREIGN KEY (ProductID) REFERENCES PRODUCT_T(ProductID)
);

-- ORDER HEADER
CREATE TABLE ORDER_T (
  OrderID     INT           PRIMARY KEY,
  OrderDate   DATE          NOT NULL,
  CustomerID  INT           NOT NULL,
  EmployeeID  INT           NOT NULL,
  OrderTotal  DECIMAL(12,2),
  FOREIGN KEY (CustomerID) REFERENCES CUSTOMER_T(CustomerID),
  FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE_T(EmployeeID)
);

-- ORDER LINE
CREATE TABLE ORDER_LINE_T (
  OrderLineID    INT           PRIMARY KEY,
  OrderID        INT           NOT NULL,
  ProductID      INT           NOT NULL,
  QtyOrdered     INT,
  QtyDelivered   INT,
  FOREIGN KEY (OrderID)   REFERENCES ORDER_T(OrderID),
  FOREIGN KEY (ProductID) REFERENCES PRODUCT_T(ProductID)
);
