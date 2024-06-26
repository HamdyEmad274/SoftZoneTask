USE [master]
GO
/****** Object:  Database [OnlineRestaurantService]    Script Date: 5/10/2024 10:02:08 PM ******/
CREATE DATABASE [OnlineRestaurantService]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OnlineRestaurantService', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\OnlineRestaurantService.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OnlineRestaurantService_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\OnlineRestaurantService_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [OnlineRestaurantService] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OnlineRestaurantService].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OnlineRestaurantService] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET ARITHABORT OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OnlineRestaurantService] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OnlineRestaurantService] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET  ENABLE_BROKER 
GO
ALTER DATABASE [OnlineRestaurantService] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OnlineRestaurantService] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [OnlineRestaurantService] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET RECOVERY FULL 
GO
ALTER DATABASE [OnlineRestaurantService] SET  MULTI_USER 
GO
ALTER DATABASE [OnlineRestaurantService] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OnlineRestaurantService] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OnlineRestaurantService] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OnlineRestaurantService] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [OnlineRestaurantService] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [OnlineRestaurantService] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'OnlineRestaurantService', N'ON'
GO
ALTER DATABASE [OnlineRestaurantService] SET QUERY_STORE = ON
GO
ALTER DATABASE [OnlineRestaurantService] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [OnlineRestaurantService]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 5/10/2024 10:02:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MenuItems]    Script Date: 5/10/2024 10:02:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuItems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[RestaurantId] [int] NOT NULL,
 CONSTRAINT [PK_MenuItems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Restaurants]    Script Date: 5/10/2024 10:02:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restaurants](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[ImageUrl] [nvarchar](max) NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[AverageRating] [decimal](5, 2) NOT NULL,
	[NumberOfComments] [int] NOT NULL,
	[NumberOfLikes] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Restaurants] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240507192122_InitialCreate', N'8.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240508155920_UpdateRestaurantModel', N'8.0.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240508174903_AddRestaurantIdToMenuItem', N'8.0.4')
GO
SET IDENTITY_INSERT [dbo].[MenuItems] ON 

INSERT [dbo].[MenuItems] ([Id], [Name], [Description], [Price], [RestaurantId]) VALUES (1, N'item1', N'randomItem', CAST(12.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[MenuItems] ([Id], [Name], [Description], [Price], [RestaurantId]) VALUES (2, N'item2', N'any description', CAST(30.00 AS Decimal(18, 2)), 1)
SET IDENTITY_INSERT [dbo].[MenuItems] OFF
GO
SET IDENTITY_INSERT [dbo].[Restaurants] ON 

INSERT [dbo].[Restaurants] ([Id], [Name], [ImageUrl], [Address], [AverageRating], [NumberOfComments], [NumberOfLikes], [Description]) VALUES (1, N'asddsa', N'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmVzdGF1cmFudHxlbnwwfHwwfHx8MA%3D%3D', N'random', CAST(3.90 AS Decimal(5, 2)), 120, 20, N'randomString')
INSERT [dbo].[Restaurants] ([Id], [Name], [ImageUrl], [Address], [AverageRating], [NumberOfComments], [NumberOfLikes], [Description]) VALUES (2, N'asddsa', N'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmVzdGF1cmFudHxlbnwwfHwwfHx8MA%3D%3D', N'string', CAST(3.90 AS Decimal(5, 2)), 120, 20, N'string')
INSERT [dbo].[Restaurants] ([Id], [Name], [ImageUrl], [Address], [AverageRating], [NumberOfComments], [NumberOfLikes], [Description]) VALUES (4, N'new Res', N'string', N'string', CAST(3.10 AS Decimal(5, 2)), 120, 12, N'string')
INSERT [dbo].[Restaurants] ([Id], [Name], [ImageUrl], [Address], [AverageRating], [NumberOfComments], [NumberOfLikes], [Description]) VALUES (5, N'New', N'sasafsa.jpg', N'afssafsa', CAST(0.00 AS Decimal(5, 2)), 0, 0, N'asdsafaf')
INSERT [dbo].[Restaurants] ([Id], [Name], [ImageUrl], [Address], [AverageRating], [NumberOfComments], [NumberOfLikes], [Description]) VALUES (6, N'tryOne', N'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA1L3Vwd2s2MTY2MTU3Ny13aWtpbWVkaWEtaW1hZ2Uta293YXBlZWouanBn.jpg', N'Egypt - banha - nada street', CAST(0.00 AS Decimal(5, 2)), 0, 0, N'random description')
INSERT [dbo].[Restaurants] ([Id], [Name], [ImageUrl], [Address], [AverageRating], [NumberOfComments], [NumberOfLikes], [Description]) VALUES (7, N'Abwahab', N'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA1L3Vwd2s2MTY2MTU3Ny13aWtpbWVkaWEtaW1hZ2Uta293YXBlZWouanBn.jpg', N'Egypt-Tanta-streetOne', CAST(0.00 AS Decimal(5, 2)), 0, 0, N'sadsafsaasfas')
SET IDENTITY_INSERT [dbo].[Restaurants] OFF
GO
/****** Object:  Index [IX_MenuItems_RestaurantId]    Script Date: 5/10/2024 10:02:09 PM ******/
CREATE NONCLUSTERED INDEX [IX_MenuItems_RestaurantId] ON [dbo].[MenuItems]
(
	[RestaurantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MenuItems] ADD  DEFAULT ((0)) FOR [RestaurantId]
GO
ALTER TABLE [dbo].[MenuItems]  WITH CHECK ADD  CONSTRAINT [FK_MenuItems_Restaurants] FOREIGN KEY([RestaurantId])
REFERENCES [dbo].[Restaurants] ([Id])
GO
ALTER TABLE [dbo].[MenuItems] CHECK CONSTRAINT [FK_MenuItems_Restaurants]
GO
ALTER TABLE [dbo].[MenuItems]  WITH CHECK ADD  CONSTRAINT [FK_MenuItems_Restaurants_RestaurantId] FOREIGN KEY([RestaurantId])
REFERENCES [dbo].[Restaurants] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MenuItems] CHECK CONSTRAINT [FK_MenuItems_Restaurants_RestaurantId]
GO
USE [master]
GO
ALTER DATABASE [OnlineRestaurantService] SET  READ_WRITE 
GO
