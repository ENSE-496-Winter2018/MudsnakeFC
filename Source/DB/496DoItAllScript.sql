USE [master]
GO
/****** Object:  Database [ENSE496]    Script Date: 11/22/2018 1:56:18 AM ******/
CREATE DATABASE [ENSE496]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ENSE496', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ENSE496.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ENSE496_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ENSE496_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ENSE496] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ENSE496].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ENSE496] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ENSE496] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ENSE496] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ENSE496] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ENSE496] SET ARITHABORT OFF 
GO
ALTER DATABASE [ENSE496] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ENSE496] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ENSE496] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ENSE496] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ENSE496] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ENSE496] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ENSE496] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ENSE496] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ENSE496] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ENSE496] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ENSE496] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ENSE496] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ENSE496] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ENSE496] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ENSE496] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ENSE496] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ENSE496] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ENSE496] SET RECOVERY FULL 
GO
ALTER DATABASE [ENSE496] SET  MULTI_USER 
GO
ALTER DATABASE [ENSE496] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ENSE496] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ENSE496] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ENSE496] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ENSE496] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ENSE496', N'ON'
GO
ALTER DATABASE [ENSE496] SET QUERY_STORE = OFF
GO
USE [ENSE496]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 11/22/2018 1:56:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Idea_id] [int] NOT NULL,
	[User_id] [int] NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[Active] [bit] NULL,
	[Submitted_on] [datetime] NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 11/22/2018 1:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Idea_id] [int] NOT NULL,
	[User_id] [int] NOT NULL,
	[Text] [varchar](max) NOT NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_Feedback] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Idea]    Script Date: 11/22/2018 1:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Idea](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[User_id] [int] NOT NULL,
	[Title] [varchar](255) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_Idea] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Like]    Script Date: 11/22/2018 1:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Like](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Idea_id] [int] NOT NULL,
	[User_id] [int] NOT NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_Like] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 11/22/2018 1:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Recipient_id] [int] NOT NULL,
	[Message] [varchar](max) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status_log]    Script Date: 11/22/2018 1:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status_log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Current_status] [varchar](50) NULL,
	[Previous_status] [varchar](50) NULL,
	[Description] [varchar](max) NULL,
	[Idea_id] [int] NOT NULL,
	[User_id] [int] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_Status_log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subscription]    Script Date: 11/22/2018 1:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subscription](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[User_id] [int] NOT NULL,
	[Idea_id] [int] NOT NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_Subscription] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Team]    Script Date: 11/22/2018 1:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Active] [bit] NULL,
	[Leader] [int] NULL,
 CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 11/22/2018 1:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Hashed_password] [varchar](50) NOT NULL,
	[Email] [varchar](50) NULL,
	[Photo_num] [int] NULL,
	[Photo_DIR] [image] NULL,
	[Type] [varchar](50) NOT NULL,
	[Active] [bit] NULL,
	[Team_id] [int] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Idea] FOREIGN KEY([Idea_id])
REFERENCES [dbo].[Idea] ([Id])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Idea]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_User] FOREIGN KEY([User_id])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_User]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_Idea] FOREIGN KEY([Idea_id])
REFERENCES [dbo].[Idea] ([Id])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK_Feedback_Idea]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_User] FOREIGN KEY([User_id])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK_Feedback_User]
GO
ALTER TABLE [dbo].[Idea]  WITH CHECK ADD  CONSTRAINT [FK_Idea_User] FOREIGN KEY([User_id])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Idea] CHECK CONSTRAINT [FK_Idea_User]
GO
ALTER TABLE [dbo].[Like]  WITH CHECK ADD  CONSTRAINT [FK_Like_Idea] FOREIGN KEY([Idea_id])
REFERENCES [dbo].[Idea] ([Id])
GO
ALTER TABLE [dbo].[Like] CHECK CONSTRAINT [FK_Like_Idea]
GO
ALTER TABLE [dbo].[Like]  WITH CHECK ADD  CONSTRAINT [FK_Like_User] FOREIGN KEY([User_id])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Like] CHECK CONSTRAINT [FK_Like_User]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_User] FOREIGN KEY([Recipient_id])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_User]
GO
ALTER TABLE [dbo].[Status_log]  WITH CHECK ADD  CONSTRAINT [FK_Status_log_Idea] FOREIGN KEY([Idea_id])
REFERENCES [dbo].[Idea] ([Id])
GO
ALTER TABLE [dbo].[Status_log] CHECK CONSTRAINT [FK_Status_log_Idea]
GO
ALTER TABLE [dbo].[Status_log]  WITH CHECK ADD  CONSTRAINT [FK_Status_log_User] FOREIGN KEY([User_id])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Status_log] CHECK CONSTRAINT [FK_Status_log_User]
GO
ALTER TABLE [dbo].[Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Subscription_Idea] FOREIGN KEY([Idea_id])
REFERENCES [dbo].[Idea] ([Id])
GO
ALTER TABLE [dbo].[Subscription] CHECK CONSTRAINT [FK_Subscription_Idea]
GO
ALTER TABLE [dbo].[Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Subscription_User] FOREIGN KEY([User_id])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Subscription] CHECK CONSTRAINT [FK_Subscription_User]
GO
ALTER TABLE [dbo].[Team]  WITH CHECK ADD  CONSTRAINT [FK_Team_User] FOREIGN KEY([Leader])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Team] CHECK CONSTRAINT [FK_Team_User]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Team] FOREIGN KEY([Team_id])
REFERENCES [dbo].[Team] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Team]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_User] FOREIGN KEY([Id])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_User]
GO
USE [master]
GO
ALTER DATABASE [ENSE496] SET  READ_WRITE 
GO



USE [ENSE496]
GO

INSERT INTO [dbo].[Team]
           ([Name]
           ,[Active])
     VALUES
           ('Team1'
           ,1)
GO

INSERT INTO [dbo].[Team]
           ([Name]
           ,[Active])
     VALUES
           ('Team2'
           ,1)
GO

INSERT INTO [dbo].[User]
           ([Username]
           ,[Hashed_password]
           ,[Type]
           ,[Active]
           ,[Team_id])
     VALUES
           ('team1user'
           ,'pwd'
           ,'user'
           ,1
           ,1)
GO

INSERT INTO [dbo].[User]
           ([Username]
           ,[Hashed_password]
           ,[Type]
           ,[Active]
           ,[Team_id])
     VALUES
           ('team1approver'
           ,'pwd'
           ,'approver'
           ,1
           ,1)
GO

INSERT INTO [dbo].[User]
           ([Username]
           ,[Hashed_password]
           ,[Type]
           ,[Active]
           ,[Team_id])
     VALUES
           ('team2user'
           ,'pwd'
           ,'user'
           ,1
           ,2)
GO

INSERT INTO [dbo].[User]
           ([Username]
           ,[Hashed_password]
           ,[Type]
           ,[Active]
           ,[Team_id])
     VALUES
           ('team2approver'
           ,'pwd'
           ,'approver'
           ,1
           ,2)
GO



UPDATE [dbo].[Team]
   SET [Leader] = 3
 WHERE Name = 'team1'
GO

UPDATE [dbo].[Team]
   SET [Leader] = 4
 WHERE Name = 'team2'
GO


