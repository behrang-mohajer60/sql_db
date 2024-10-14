create database shop
on
(
name='shop_data',
filename='c:\db\shop_data.mdf',
size=8 mb,
filegrowth=50mb
)
log on
(
name='shop_log',
filename='c:\db\shop_log.ldf',
size=8 mb,
filegrowth=50mb,
maxsize=1gb
)
go
use shop
go
create table t_category
(
cat_code int constraint PK__category_code primary key identity(1001,1),
cat_name nvarchar(30) not null constraint UN__category_name unique,
)
go
create table t_company
(
co_code varchar(10) constraint PK__company_code primary key,
co_name nvarchar(30) not null constraint UN__company_name unique,
co_phone char(11),
co_address nvarchar(max)
)
go

create table t_product
(
pro_code int constraint PK__product_code primary key,
cat_code int constraint FK__cat_code foreign key references t_category(cat_code),
pro_name nvarchar(30) not null ,
pro_number int constraint CH__product_number check(pro_number>=1) constraint DF__product_number default 1,
pro_price money constraint CH__product_price check(pro_price>=1) constraint DF__product_price default 1000,
co_code varchar(10) constraint FK__product_code foreign key references t_company(co_code),
constraint UN__proname_cat_code unique(pro_name,cat_code)
)
go
create table t_customer
(
cus_name nvarchar(40) not null,
cus_lname nvarchar(50)not null,
cus_phone char(11) constraint PK__customer_fullname primary key,

)
go
create table factor
(
fa_code int constraint PK__factor_code primary key identity(1001,1),
cus_code char(11) constraint FK__cusomer_code foreign key references t_customer(cus_phone),
fa_date date constraint DF__factor_date default  getdate(),
total_offer money,
total_tax money,
total_final money 
)
go
create table t_factordetail
(
code_factor int constraint FK__factordetail_code_factor foreign key references factor(fa_code),
code_pro int constraint FK__factordetail_code_pro foreign key references t_product(pro_code),
number int constraint CH__factordetail_number check(number>=1) constraint DF__factordetail_number default 1,
price money constraint CH__factordetail_price check(price>=1) constraint DF__factordetail_price default 1000,
tax money,
offer money,
total money ,
)
