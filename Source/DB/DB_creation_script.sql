USE [ENSE496]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 10/20/2018 1:23:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[Id] [int] NOT NULL,
	[Idea_id] [int] NOT NULL,
	[User_id] [int] NOT NULL,
	[Comment] [varchar](max) NOT NULL,
	[Timestamp] [int] NOT NULL,
	[Active] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 10/20/2018 1:23:58 PM ******/
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
/****** Object:  Table [dbo].[Idea]    Script Date: 10/20/2018 1:23:58 PM ******/
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
/****** Object:  Table [dbo].[Like]    Script Date: 10/20/2018 1:23:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Like](
	[Id] [int] NOT NULL,
	[Idea_id] [int] NOT NULL,
	[User_id] [int] NOT NULL,
	[Active] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 10/20/2018 1:23:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Sender_id] [int] NOT NULL,
	[Receiver_id] [int] NOT NULL,
	[Message] [varchar](max) NOT NULL,
	[Is_seen] [bit] NOT NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status_log]    Script Date: 10/20/2018 1:23:58 PM ******/
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
/****** Object:  Table [dbo].[Subscription]    Script Date: 10/20/2018 1:23:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subscription](
	[Id] [int] NOT NULL,
	[User_id] [int] NOT NULL,
	[Idea_id] [int] NOT NULL,
	[Active] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Team]    Script Date: 10/20/2018 1:23:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[Id] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 10/20/2018 1:23:58 PM ******/
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
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_NotificationReceiver_User] FOREIGN KEY([Receiver_id])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_NotificationReceiver_User]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_NotificationSender_User] FOREIGN KEY([Sender_id])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_NotificationSender_User]
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A user''s team ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'CONSTRAINT',@level2name=N'FK_User_Team'
GO
