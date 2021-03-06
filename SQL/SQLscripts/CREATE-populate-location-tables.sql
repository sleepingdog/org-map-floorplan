USE [sleeping_kelpiecollege]
GO
/****** Object:  Table [dbo].[Building]    Script Date: 01/06/2016 23:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Building](
	[BuildingID] [varchar](5) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[CampusID] [varchar](5) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[SVG] [xml] NULL,
	[X3D] [xml] NULL,
 CONSTRAINT [PK_Building] PRIMARY KEY CLUSTERED 
(
	[BuildingID] ASC,
	[CampusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Campus]    Script Date: 01/06/2016 23:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Campus](
	[CampusID] [varchar](5) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[SVG] [xml] NULL,
	[X3D] [xml] NULL,
 CONSTRAINT [PK_Campus] PRIMARY KEY CLUSTERED 
(
	[CampusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Floor]    Script Date: 01/06/2016 23:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Floor](
	[FloorID] [varchar](5) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[BuildingID] [varchar](5) NOT NULL,
	[CampusID] [varchar](5) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[SVG] [xml] NULL,
 CONSTRAINT [PK_Floor_1] PRIMARY KEY CLUSTERED 
(
	[FloorID] ASC,
	[BuildingID] ASC,
	[CampusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Building] ([BuildingID], [Title], [CampusID], [Description], [SVG], [X3D]) VALUES (N'CO', N'Course Orchard', N'PH', NULL, NULL, NULL)
INSERT [dbo].[Building] ([BuildingID], [Title], [CampusID], [Description], [SVG], [X3D]) VALUES (N'D', N'Dolphinarium', N'PH', NULL, NULL, NULL)
INSERT [dbo].[Building] ([BuildingID], [Title], [CampusID], [Description], [SVG], [X3D]) VALUES (N'H', N'Harbour', N'PH', NULL, NULL, NULL)
INSERT [dbo].[Building] ([BuildingID], [Title], [CampusID], [Description], [SVG], [X3D]) VALUES (N'HD', N'Hive Dome Cluster', N'PH', NULL, NULL, NULL)
INSERT [dbo].[Building] ([BuildingID], [Title], [CampusID], [Description], [SVG], [X3D]) VALUES (N'OB', N'Old Building', N'PH', NULL, NULL, NULL)
INSERT [dbo].[Building] ([BuildingID], [Title], [CampusID], [Description], [SVG], [X3D]) VALUES (N'TB', N'Tower Building', N'PH', NULL, NULL, NULL)
INSERT [dbo].[Campus] ([CampusID], [Title], [Description], [SVG], [X3D]) VALUES (N'AT', N'The Barque "Acquired Tacking"', NULL, NULL, NULL)
INSERT [dbo].[Campus] ([CampusID], [Title], [Description], [SVG], [X3D]) VALUES (N'CH', N'Celt Harbour', NULL, NULL, NULL)
INSERT [dbo].[Campus] ([CampusID], [Title], [Description], [SVG], [X3D]) VALUES (N'PH', N'Pict Harbour', NULL, NULL, NULL)
INSERT [dbo].[Campus] ([CampusID], [Title], [Description], [SVG], [X3D]) VALUES (N'PS', N'The Schooner "Privateering and Slavedriving"', NULL, NULL, NULL)
INSERT [dbo].[Floor] ([FloorID], [Title], [BuildingID], [CampusID], [Description], [SVG]) VALUES (N'F0', N'Ground', N'OB', N'PH', N'The ground floor is enclosed on West, South and East, and open on North side facing Tower Building.', NULL)
INSERT [dbo].[Floor] ([FloorID], [Title], [BuildingID], [CampusID], [Description], [SVG]) VALUES (N'F0', N'Ground', N'TB', N'PH', NULL, NULL)
INSERT [dbo].[Floor] ([FloorID], [Title], [BuildingID], [CampusID], [Description], [SVG]) VALUES (N'F1', N'First', N'OB', N'PH', NULL, NULL)
INSERT [dbo].[Floor] ([FloorID], [Title], [BuildingID], [CampusID], [Description], [SVG]) VALUES (N'F1', N'First', N'TB', N'PH', NULL, NULL)
INSERT [dbo].[Floor] ([FloorID], [Title], [BuildingID], [CampusID], [Description], [SVG]) VALUES (N'F2', N'Second', N'OB', N'PH', NULL, NULL)
INSERT [dbo].[Floor] ([FloorID], [Title], [BuildingID], [CampusID], [Description], [SVG]) VALUES (N'F2', N'Second', N'TB', N'PH', NULL, NULL)
INSERT [dbo].[Floor] ([FloorID], [Title], [BuildingID], [CampusID], [Description], [SVG]) VALUES (N'F3', N'Third', N'TB', N'PH', NULL, NULL)
INSERT [dbo].[Floor] ([FloorID], [Title], [BuildingID], [CampusID], [Description], [SVG]) VALUES (N'F4', N'Fourth', N'TB', N'PH', NULL, NULL)
INSERT [dbo].[Floor] ([FloorID], [Title], [BuildingID], [CampusID], [Description], [SVG]) VALUES (N'F5', N'Fifth', N'TB', N'PH', NULL, NULL)
INSERT [dbo].[Floor] ([FloorID], [Title], [BuildingID], [CampusID], [Description], [SVG]) VALUES (N'F6', N'Sixth', N'TB', N'PH', NULL, NULL)
INSERT [dbo].[Floor] ([FloorID], [Title], [BuildingID], [CampusID], [Description], [SVG]) VALUES (N'F7', N'Seventh', N'TB', N'PH', NULL, NULL)
ALTER TABLE [dbo].[Building]  WITH CHECK ADD  CONSTRAINT [FK_Building_Campus] FOREIGN KEY([CampusID])
REFERENCES [dbo].[Campus] ([CampusID])
GO
ALTER TABLE [dbo].[Building] CHECK CONSTRAINT [FK_Building_Campus]
GO
ALTER TABLE [dbo].[Floor]  WITH CHECK ADD  CONSTRAINT [FK_Floor_Building] FOREIGN KEY([BuildingID], [CampusID])
REFERENCES [dbo].[Building] ([BuildingID], [CampusID])
GO
ALTER TABLE [dbo].[Floor] CHECK CONSTRAINT [FK_Floor_Building]
GO
/* Now create the empty Room table, to be filled from the SVG file */

CREATE TABLE [dbo].[Room](
	[RoomID] [varchar](5) NOT NULL,
	[Title] [varchar](50) NULL,
	[FloorID] [varchar](5) NOT NULL,
	[BuildingID] [varchar](5) NOT NULL,
	[CampusID] [varchar](5) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[SVG] [xml] NULL CONSTRAINT [DF_Room_SVG]  DEFAULT (CONVERT([xml],'<svg xmlns="http://www.w3.org/2000/svg" />',0)),
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC,
	[FloorID] ASC,
	[BuildingID] ASC,
	[CampusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Room]  WITH CHECK ADD  CONSTRAINT [FK_Room_Floor] FOREIGN KEY([FloorID], [BuildingID], [CampusID])
REFERENCES [dbo].[Floor] ([FloorID], [BuildingID], [CampusID])
GO

ALTER TABLE [dbo].[Room] CHECK CONSTRAINT [FK_Room_Floor]
GO

