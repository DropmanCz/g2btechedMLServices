
drop table if exists Models.ModelVersions
go
CREATE TABLE [Models].[ModelVersions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[ModelStream] [varbinary](max) NOT NULL,
	[PredictedUnits] [nvarchar](10) NOT NULL,
 CONSTRAINT [pk_ModelVersions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [Models].[ModelVersions] ADD  CONSTRAINT [df_ModelVersions_CreationDate]  DEFAULT (sysdatetime()) FOR [CreationDate]
GO


