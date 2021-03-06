USE [master]
GO
/****** Object:  Database [ENSE496]    Script Date: 10/1/2018 10:36:42 PM ******/
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
/****** Object:  Table [dbo].[Comment]    Script Date: 12/5/2018 9:52:16 PM ******/
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
/****** Object:  Table [dbo].[Feedback]    Script Date: 12/5/2018 9:52:17 PM ******/
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
/****** Object:  Table [dbo].[Idea]    Script Date: 12/5/2018 9:52:17 PM ******/
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
	[onSuccessStories] [bit] NULL,
 CONSTRAINT [PK_Idea] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Like]    Script Date: 12/5/2018 9:52:17 PM ******/
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
/****** Object:  Table [dbo].[Notification]    Script Date: 12/5/2018 9:52:17 PM ******/
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
/****** Object:  Table [dbo].[Status_log]    Script Date: 12/5/2018 9:52:17 PM ******/
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
/****** Object:  Table [dbo].[Subscription]    Script Date: 12/5/2018 9:52:17 PM ******/
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
/****** Object:  Table [dbo].[Team]    Script Date: 12/5/2018 9:52:17 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 12/5/2018 9:52:17 PM ******/
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
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([Id], [Idea_id], [User_id], [Comment], [Active], [Submitted_on]) VALUES (5, 41, 2, N'HAHA this idea sucks!', 1, CAST(N'2018-12-05T18:43:55.340' AS DateTime))
INSERT [dbo].[Comment] ([Id], [Idea_id], [User_id], [Comment], [Active], [Submitted_on]) VALUES (6, 41, 9, N'Please refrain from criticizing ideas unless the criticism is constructive. Keep it civil.', 1, CAST(N'2018-12-05T18:46:12.667' AS DateTime))
INSERT [dbo].[Comment] ([Id], [Idea_id], [User_id], [Comment], [Active], [Submitted_on]) VALUES (7, 41, 2, N'I AM THE BOSS AND I WILL SAY WHATEVER I WANT!', 1, CAST(N'2018-12-05T18:47:44.557' AS DateTime))
INSERT [dbo].[Comment] ([Id], [Idea_id], [User_id], [Comment], [Active], [Submitted_on]) VALUES (8, 41, 9, N'I am reporting you to Human Resources.', 1, CAST(N'2018-12-05T18:50:49.130' AS DateTime))
INSERT [dbo].[Comment] ([Id], [Idea_id], [User_id], [Comment], [Active], [Submitted_on]) VALUES (9, 41, 10, N'Thanks for sticking up for me Connor. You have have always been like a father to me.', 1, CAST(N'2018-12-05T18:53:16.530' AS DateTime))
INSERT [dbo].[Comment] ([Id], [Idea_id], [User_id], [Comment], [Active], [Submitted_on]) VALUES (10, 19, 9, N'cool', 1, CAST(N'2018-12-05T18:53:55.787' AS DateTime))
INSERT [dbo].[Comment] ([Id], [Idea_id], [User_id], [Comment], [Active], [Submitted_on]) VALUES (11, 19, 9, N'nvm', 1, CAST(N'2018-12-05T18:54:07.337' AS DateTime))
INSERT [dbo].[Comment] ([Id], [Idea_id], [User_id], [Comment], [Active], [Submitted_on]) VALUES (12, 23, 11, N'great idea!', 1, CAST(N'2018-12-05T18:56:30.680' AS DateTime))
INSERT [dbo].[Comment] ([Id], [Idea_id], [User_id], [Comment], [Active], [Submitted_on]) VALUES (13, 25, 14, N'yep', 1, CAST(N'2018-12-05T18:58:01.460' AS DateTime))
INSERT [dbo].[Comment] ([Id], [Idea_id], [User_id], [Comment], [Active], [Submitted_on]) VALUES (14, 19, 14, N'cool ', 1, CAST(N'2018-12-05T18:58:27.437' AS DateTime))
INSERT [dbo].[Comment] ([Id], [Idea_id], [User_id], [Comment], [Active], [Submitted_on]) VALUES (15, 21, 14, N'test', 1, CAST(N'2018-12-05T18:58:59.347' AS DateTime))
SET IDENTITY_INSERT [dbo].[Comment] OFF
SET IDENTITY_INSERT [dbo].[Idea] ON 

INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (18, 1, N'Usability testing', N'Test', N'Approved', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (19, 3, N'Application Development', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (20, 3, N'Server group A', N'test', N'Approved', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (21, 5, N'Broken Printer', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (22, 5, N'Replace Screen in Room 5A', N'test', N'Approved', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (23, 5, N'Migrate MDM solution', N'test', N'Approved', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (24, 7, N'Knowledge base backup', N'test', N'Declined', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (25, 7, N'New Citrix image available ', N'test', N'Approved', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (26, 7, N'Workplace safety seminar', N'test', N'Approved', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (27, 7, N'ASP.net training', N'test', N'Approved', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (28, 2, N'Streamline Idea approval process', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (29, 2, N'Archive declined ideas', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (30, 3, N'IEEE Standards', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (31, 5, N'Team building activity at 3:00', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (32, 1, N'Password recovery', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (33, 3, N'Domain name change', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (34, 8, N'Mobile friendly browsing', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (35, 8, N'Alternative test environment', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (36, 6, N'Second floor coffee machine', N'test', N'Declined', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (37, 6, N'Service Desk Forwarding', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (38, 8, N'Append adjacent data entries', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (39, 9, N'Free gum', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (40, 9, N'Firmware Install', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (41, 10, N'Draw IO ', N'test', N'Approved', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (42, 10, N'Office open source', N'test', N'Declined', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (43, 10, N'Boot menu', N'test', N'Declined', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (44, 10, N'Electrical backlog', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (45, 10, N'Shared Drivers Project', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (46, 10, N'iSpring Free Cam', N'test', N'Parked', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (47, 10, N'Bitlocker key removal', N'test', N'Approved', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (48, 12, N'Compliance Check', N'test', N'Declined', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (49, 12, N'Recycle Bin Recovery', N'test', N'Approved', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (50, 12, N'Time zone app', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (51, 11, N'BS4 Config', N'test', N'Parked', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (52, 11, N'Windows Freedom Initiative', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (53, 14, N'Regina Barcode Scanner', N'test', N'Approved', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (54, 13, N'BLUR Imaging', N'test', N'Approved', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (55, 13, N'Cloud file sharing', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (56, 1, N'Kootenay AAAA', N'test', N'Approved', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (57, 1, N'Local drive partitioning', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (58, 14, N'Chewable Formula', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (59, 14, N'Caution Hot!', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (60, 14, N'Noise Isolation', N'test', N'Pending', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (61, 14, N'Mug Stolen', N'test', N'Declined', NULL, NULL)
INSERT [dbo].[Idea] ([Id], [User_id], [Title], [Description], [Status], [Active], [onSuccessStories]) VALUES (62, 10, N'Excel Meeting', N'ke', N'Pending', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Idea] OFF
SET IDENTITY_INSERT [dbo].[Like] ON 

INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (7, 41, 2, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (8, 44, 2, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (9, 41, 9, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (10, 41, 10, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (11, 18, 9, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (12, 22, 9, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (13, 19, 9, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (14, 41, 11, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (15, 23, 11, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (16, 22, 11, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (17, 54, 11, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (18, 45, 11, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (19, 25, 11, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (20, 26, 14, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (21, 19, 14, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (22, 23, 14, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (23, 19, 10, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (24, 23, 10, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (25, 21, 10, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (26, 25, 10, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (27, 45, 10, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (28, 18, 10, 1)
INSERT [dbo].[Like] ([Id], [Idea_id], [User_id], [Active]) VALUES (29, 45, 2, 1)
SET IDENTITY_INSERT [dbo].[Like] OFF
SET IDENTITY_INSERT [dbo].[Notification] ON 

INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (13, 1, N'team1approver has approved your idea. (Idea #18)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (14, 3, N'team2approver has approved your idea. (Idea #20)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (15, 5, N'team3approver has approved your idea. (Idea #22)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (16, 5, N'team3approver has approved your idea. (Idea #23)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (17, 7, N'team4approver has declined your idea. (Idea #24)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (18, 7, N'team4approver has approved your idea. (Idea #25)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (19, 7, N'team4approver has approved your idea. (Idea #26)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (20, 7, N'team4approver has approved your idea. (Idea #27)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (21, 10, N'team1approver has declined your idea. (Idea #43)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (22, 10, N'team1approver has declined your idea. (Idea #42)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (23, 11, N'team1approver has parked your idea. (Idea #51)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (24, 1, N'team1approver has approved your idea. (Idea #56)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (25, 14, N'team1approver has approved your idea. (Idea #53)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (26, 14, N'team1approver has declined your idea. (Idea #61)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (27, 13, N'team1approver has approved your idea. (Idea #54)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (28, 12, N'team1approver has declined your idea. (Idea #48)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (29, 12, N'team1approver has approved your idea. (Idea #49)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (30, 10, N'team1approver has commented on your idea. (Idea #41)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (31, 10, N'Connor has commented on your idea. (Idea #41)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (32, 10, N'team1approver has commented on your idea. (Idea #41)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (33, 10, N'Connor has commented on your idea. (Idea #41)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (34, 3, N'Connor has commented on your idea. (Idea #19)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (35, 3, N'Connor has commented on your idea. (Idea #19)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (36, 5, N'Demitri has commented on your idea. (Idea #23)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (37, 7, N'Nate has commented on your idea. (Idea #25)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (38, 3, N'Nate has commented on your idea. (Idea #19)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (39, 5, N'Nate has commented on your idea. (Idea #21)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (40, 10, N'team1approver has parked your idea. (Idea #46)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (41, 10, N'team1approver has approved your idea. (Idea #41)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (42, 10, N'team1approver has approved your idea. (Idea #47)', 1)
SET IDENTITY_INSERT [dbo].[Notification] OFF
SET IDENTITY_INSERT [dbo].[Status_log] ON 

INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (6, N'Approved', N'Pending', N'Good', 18, 2, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (7, N'Approved', N'Pending', N'test', 20, 4, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (8, N'Approved', N'Pending', N'test', 22, 6, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (9, N'Approved', N'Pending', N'test', 23, 6, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (10, N'Declined', N'Pending', N'nbad', 36, 6, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (11, N'Declined', N'Pending', N'tets', 24, 8, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (12, N'Approved', N'Pending', N's', 25, 8, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (13, N'Approved', N'Pending', N'good
', 26, 8, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (14, N'Approved', N'Pending', N'r', 27, 8, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (15, N'Declined', N'Pending', N'sucks', 43, 2, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (16, N'Declined', N'Pending', N'not relevant.', 42, 2, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (17, N'Parked', N'Pending', N'parked', 51, 2, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (18, N'Approved', N'Pending', N'dffd', 56, 2, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (19, N'Approved', N'Pending', N'd', 53, 2, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (20, N'Declined', N'Pending', N'd', 61, 2, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (21, N'Approved', N'Pending', N'Z', 54, 2, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (22, N'Declined', N'Pending', N's', 48, 2, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (23, N'Approved', N'Pending', N'c', 49, 2, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (24, N'Parked', N'Pending', N'not yet', 46, 2, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (25, N'Approved', N'Pending', N'ygh', 41, 2, NULL)
INSERT [dbo].[Status_log] ([Id], [Current_status], [Previous_status], [Description], [Idea_id], [User_id], [Active]) VALUES (26, N'Approved', N'Pending', N'good', 47, 2, NULL)
SET IDENTITY_INSERT [dbo].[Status_log] OFF
SET IDENTITY_INSERT [dbo].[Subscription] ON 

INSERT [dbo].[Subscription] ([Id], [User_id], [Idea_id], [Active]) VALUES (11, 2, 18, 1)
SET IDENTITY_INSERT [dbo].[Subscription] OFF
SET IDENTITY_INSERT [dbo].[Team] ON 

INSERT [dbo].[Team] ([Id], [Name], [Active], [Leader]) VALUES (1, N'Team1', 1, 2)
INSERT [dbo].[Team] ([Id], [Name], [Active], [Leader]) VALUES (2, N'Team2', 1, 4)
INSERT [dbo].[Team] ([Id], [Name], [Active], [Leader]) VALUES (3, N'Team3', 1, 6)
INSERT [dbo].[Team] ([Id], [Name], [Active], [Leader]) VALUES (4, N'Team4', 1, 8)
SET IDENTITY_INSERT [dbo].[Team] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [Username], [Hashed_password], [Email], [Photo_num], [Photo_DIR], [Type], [Active], [Team_id]) VALUES (1, N'team1user', N'pwd', NULL, NULL, NULL, N'user', 1, 1)
INSERT [dbo].[User] ([Id], [Username], [Hashed_password], [Email], [Photo_num], [Photo_DIR], [Type], [Active], [Team_id]) VALUES (2, N'team1approver', N'pwd', NULL, NULL, NULL, N'approver', 1, 1)
INSERT [dbo].[User] ([Id], [Username], [Hashed_password], [Email], [Photo_num], [Photo_DIR], [Type], [Active], [Team_id]) VALUES (3, N'team2user', N'pwd', NULL, NULL, NULL, N'user', 1, 2)
INSERT [dbo].[User] ([Id], [Username], [Hashed_password], [Email], [Photo_num], [Photo_DIR], [Type], [Active], [Team_id]) VALUES (4, N'team2approver', N'pwd', NULL, NULL, NULL, N'approver', 1, 2)
INSERT [dbo].[User] ([Id], [Username], [Hashed_password], [Email], [Photo_num], [Photo_DIR], [Type], [Active], [Team_id]) VALUES (5, N'team3user', N'pwd', NULL, NULL, NULL, N'user', 1, 3)
INSERT [dbo].[User] ([Id], [Username], [Hashed_password], [Email], [Photo_num], [Photo_DIR], [Type], [Active], [Team_id]) VALUES (6, N'team3approver', N'pwd', NULL, NULL, NULL, N'approver', 1, 3)
INSERT [dbo].[User] ([Id], [Username], [Hashed_password], [Email], [Photo_num], [Photo_DIR], [Type], [Active], [Team_id]) VALUES (7, N'team4user', N'pwd', NULL, NULL, NULL, N'user', 1, 4)
INSERT [dbo].[User] ([Id], [Username], [Hashed_password], [Email], [Photo_num], [Photo_DIR], [Type], [Active], [Team_id]) VALUES (8, N'team4approver', N'pwd', NULL, NULL, NULL, N'approver', 1, 4)
INSERT [dbo].[User] ([Id], [Username], [Hashed_password], [Email], [Photo_num], [Photo_DIR], [Type], [Active], [Team_id]) VALUES (9, N'Connor', N'pwd', NULL, NULL, NULL, N'user', 1, 1)
INSERT [dbo].[User] ([Id], [Username], [Hashed_password], [Email], [Photo_num], [Photo_DIR], [Type], [Active], [Team_id]) VALUES (10, N'Zain', N'pwd', NULL, NULL, NULL, N'user', 1, 1)
INSERT [dbo].[User] ([Id], [Username], [Hashed_password], [Email], [Photo_num], [Photo_DIR], [Type], [Active], [Team_id]) VALUES (11, N'Demitri', N'pwd', NULL, NULL, NULL, N'user', 1, 1)
INSERT [dbo].[User] ([Id], [Username], [Hashed_password], [Email], [Photo_num], [Photo_DIR], [Type], [Active], [Team_id]) VALUES (12, N'Hao', N'pwd', NULL, NULL, NULL, N'user', 1, 1)
INSERT [dbo].[User] ([Id], [Username], [Hashed_password], [Email], [Photo_num], [Photo_DIR], [Type], [Active], [Team_id]) VALUES (13, N'Jin', N'pwd', NULL, NULL, NULL, N'user', 1, 1)
INSERT [dbo].[User] ([Id], [Username], [Hashed_password], [Email], [Photo_num], [Photo_DIR], [Type], [Active], [Team_id]) VALUES (14, N'Nate', N'pwd', NULL, NULL, NULL, N'user', 1, 1)
SET IDENTITY_INSERT [dbo].[User] OFF
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
