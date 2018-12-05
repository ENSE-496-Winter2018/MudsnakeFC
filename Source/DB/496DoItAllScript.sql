USE [ENSE496]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 12/5/2018 3:43:15 PM ******/
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
/****** Object:  Table [dbo].[Feedback]    Script Date: 12/5/2018 3:43:16 PM ******/
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
/****** Object:  Table [dbo].[Idea]    Script Date: 12/5/2018 3:43:16 PM ******/
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
/****** Object:  Table [dbo].[Like]    Script Date: 12/5/2018 3:43:16 PM ******/
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
/****** Object:  Table [dbo].[Notification]    Script Date: 12/5/2018 3:43:16 PM ******/
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
/****** Object:  Table [dbo].[Status_log]    Script Date: 12/5/2018 3:43:16 PM ******/
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
/****** Object:  Table [dbo].[Subscription]    Script Date: 12/5/2018 3:43:16 PM ******/
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
/****** Object:  Table [dbo].[Team]    Script Date: 12/5/2018 3:43:16 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 12/5/2018 3:43:16 PM ******/
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
SET IDENTITY_INSERT [dbo].[Idea] OFF
SET IDENTITY_INSERT [dbo].[Notification] ON 

INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (13, 1, N'team1approver has approved your idea. (Idea #18)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (14, 3, N'team2approver has approved your idea. (Idea #20)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (15, 5, N'team3approver has approved your idea. (Idea #22)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (16, 5, N'team3approver has approved your idea. (Idea #23)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (17, 7, N'team4approver has declined your idea. (Idea #24)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (18, 7, N'team4approver has approved your idea. (Idea #25)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (19, 7, N'team4approver has approved your idea. (Idea #26)', 1)
INSERT [dbo].[Notification] ([Id], [Recipient_id], [Message], [Active]) VALUES (20, 7, N'team4approver has approved your idea. (Idea #27)', 1)
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
SET IDENTITY_INSERT [dbo].[Status_log] OFF
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
