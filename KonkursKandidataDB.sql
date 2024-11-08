USE [KonkursKandidatiDB]
GO
/****** Object:  Table [dbo].[IstorijaStatusa]    Script Date: 11/6/2024 11:29:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IstorijaStatusa](
	[IstorijaStatusaID] [int] IDENTITY(1,1) NOT NULL,
	[KandidatID] [int] NOT NULL,
	[StatusID] [int] NOT NULL,
	[LastUpdate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IstorijaStatusaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kandidat]    Script Date: 11/6/2024 11:29:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kandidat](
	[KandidatID] [int] IDENTITY(1,1) NOT NULL,
	[Ime] [nvarchar](100) NOT NULL,
	[Prezime] [nvarchar](100) NOT NULL,
	[JMBG] [nvarchar](13) NOT NULL,
	[DatumRodjenja] [date] NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[DodatniLinkovi] [nvarchar](500) NULL,
	[Telefon] [nvarchar](20) NULL,
	[Napomena] [nvarchar](max) NULL,
	[LastUpdate] [datetime] NULL,
	[Slika] [varbinary](max) NULL,
	[Ocena] [int] NULL,
	[StatusID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[KandidatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[JMBG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prilog]    Script Date: 11/6/2024 11:29:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prilog](
	[PrilogID] [int] IDENTITY(1,1) NOT NULL,
	[KandidatID] [int] NOT NULL,
	[TipPrilogaID] [int] NOT NULL,
	[Naziv] [nvarchar](255) NOT NULL,
	[File] [varbinary](max) NOT NULL,
	[LastUpdate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PrilogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusKandidata]    Script Date: 11/6/2024 11:29:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusKandidata](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[NazivStatusa] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipPriloga]    Script Date: 11/6/2024 11:29:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipPriloga](
	[TipPrilogaID] [int] IDENTITY(1,1) NOT NULL,
	[NazivTipa] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TipPrilogaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IstorijaStatusa] ADD  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[Kandidat] ADD  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[Prilog] ADD  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[IstorijaStatusa]  WITH CHECK ADD FOREIGN KEY([KandidatID])
REFERENCES [dbo].[Kandidat] ([KandidatID])
GO
ALTER TABLE [dbo].[IstorijaStatusa]  WITH CHECK ADD FOREIGN KEY([StatusID])
REFERENCES [dbo].[StatusKandidata] ([StatusID])
GO
ALTER TABLE [dbo].[IstorijaStatusa]  WITH CHECK ADD  CONSTRAINT [FK_IstorijaStatusa_KandidatID] FOREIGN KEY([KandidatID])
REFERENCES [dbo].[Kandidat] ([KandidatID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IstorijaStatusa] CHECK CONSTRAINT [FK_IstorijaStatusa_KandidatID]
GO
ALTER TABLE [dbo].[Kandidat]  WITH CHECK ADD FOREIGN KEY([StatusID])
REFERENCES [dbo].[StatusKandidata] ([StatusID])
GO
ALTER TABLE [dbo].[Prilog]  WITH CHECK ADD FOREIGN KEY([KandidatID])
REFERENCES [dbo].[Kandidat] ([KandidatID])
GO
ALTER TABLE [dbo].[Prilog]  WITH CHECK ADD FOREIGN KEY([TipPrilogaID])
REFERENCES [dbo].[TipPriloga] ([TipPrilogaID])
GO
ALTER TABLE [dbo].[Kandidat]  WITH CHECK ADD CHECK  (([Ocena]>=(1) AND [Ocena]<=(5)))
GO 

INSERT INTO StatusKandidata (NazivStatusa)
VALUES 
    ('Kandidat'),
    ('Kvalifikacija'),
    ('Intervju'),
    ('Uži krug'),
    ('Zaposlen'); 
GO

INSERT INTO TipPriloga (NazivTipa)
VALUES 
    ('CV'),
    ('Propratno pismo'),
    ('Sertifikat');  
GO