USE [ENSE496]
GO

/****** Object:  Table [dbo].[Status_log]    Script Date: 10/10/2018 8:48:32 PM ******/
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
 CONSTRAINT [PK_Status_log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
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


