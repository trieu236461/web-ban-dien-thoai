USE [master]
GO
/****** Object:  Database [WebApplication1]    Script Date: 2017-04-27 9:57:35 PM ******/
CREATE DATABASE [WebApplication1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WebApplication1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\WebApplication1.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'WebApplication1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\WebApplication1_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [WebApplication1] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WebApplication1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WebApplication1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WebApplication1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WebApplication1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WebApplication1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WebApplication1] SET ARITHABORT OFF 
GO
ALTER DATABASE [WebApplication1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WebApplication1] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [WebApplication1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WebApplication1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WebApplication1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WebApplication1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WebApplication1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WebApplication1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WebApplication1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WebApplication1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WebApplication1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WebApplication1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WebApplication1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WebApplication1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WebApplication1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WebApplication1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WebApplication1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WebApplication1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WebApplication1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [WebApplication1] SET  MULTI_USER 
GO
ALTER DATABASE [WebApplication1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WebApplication1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WebApplication1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WebApplication1] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [WebApplication1]
GO
/****** Object:  StoredProcedure [dbo].[account_login]    Script Date: 2017-04-27 9:57:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[account_login] (@username varchar(100),@password varchar(100))

as
begin
declare @stage bit
declare @count int
select @count = count(*) from Account where Username = @username and Password = @password
if @count>0 set @stage=1
else set @stage = 0 

select @stage
end
GO
/****** Object:  StoredProcedure [dbo].[Sp_Category_Insert]    Script Date: 2017-04-27 9:57:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_Category_Insert]
@Name Nvarchar(100),
@Alias Varchar(100),
@ParentID int,
@Order int,
@Status bit
as
begin
Insert into Category(Name,Alias,ParentID,CreateDate,[Order],Status)
values (@Name,@Alias,@ParentID,GETDATE(),@Order,@Status)

end
GO
/****** Object:  StoredProcedure [dbo].[sp_Category_ListAll]    Script Date: 2017-04-27 9:57:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_Category_ListAll]
as
begin

select *from Category where Status = 1
order by [Order] asc
end
GO
/****** Object:  StoredProcedure [dbo].[timkiem]    Script Date: 2017-04-27 9:57:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[timkiem]
@ten nvarchar(100)
as
begin 
select *from Product where Name like N'%'+@ten+'%'

end
GO
/****** Object:  Table [dbo].[Account]    Script Date: 2017-04-27 9:57:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Account](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NULL,
	[Group_Account] [int] NULL,
	[Name] [nvarchar](150) NULL,
	[Address] [nvarchar](250) NULL,
	[Phone] [varchar](15) NULL,
	[Sex] [nvarchar](7) NULL,
	[Email] [varchar](150) NULL,
 CONSTRAINT [PK_Account_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Category]    Script Date: 2017-04-27 9:57:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Category](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
	[Alias] [varchar](50) NULL,
	[ParentID] [int] NULL,
	[CreateBy] [varchar](150) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](150) NULL,
	[CreateDate] [datetime] NULL,
	[Order] [int] NULL,
	[Status] [bit] NULL,
	[Showonhome] [bit] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MoreImages]    Script Date: 2017-04-27 9:57:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MoreImages](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Images] [varchar](250) NULL,
	[Product_ID] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 2017-04-27 9:57:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[Name] [nvarchar](150) NULL,
	[Manufactory] [nvarchar](150) NULL,
	[Descriptions] [nvarchar](550) NULL,
	[Alias] [varchar](50) NULL,
	[Quantity] [int] NULL,
	[CategoryID] [int] NULL,
	[Images] [nvarchar](250) NULL,
	[MoreImages] [xml] NULL,
	[CreateDate] [datetime] NULL,
	[Price] [decimal](18, 0) NULL,
	[Warranty] [int] NULL,
	[Detail] [ntext] NULL,
	[Status] [bit] NULL,
	[Tophot] [datetime] NULL,
	[PromotionPrice] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Category_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Category_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_Status]  DEFAULT ((1)) FOR [Status]
GO
USE [master]
GO
ALTER DATABASE [WebApplication1] SET  READ_WRITE 
GO
