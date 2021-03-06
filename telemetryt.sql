USE [master]
GO
/****** Object:  Database [Dev_Telemetry]    Script Date: 10/23/2013 1:59:58 PM ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'Dev_Telemetry')
BEGIN
CREATE DATABASE [Dev_Telemetry]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Telemetry', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Telemetry.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Telemetry_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Telemetry_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
END

GO
ALTER DATABASE [Dev_Telemetry] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Dev_Telemetry].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Dev_Telemetry] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET ARITHABORT OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Dev_Telemetry] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Dev_Telemetry] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Dev_Telemetry] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Dev_Telemetry] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Dev_Telemetry] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET RECOVERY FULL 
GO
ALTER DATABASE [Dev_Telemetry] SET  MULTI_USER 
GO
ALTER DATABASE [Dev_Telemetry] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Dev_Telemetry] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Dev_Telemetry] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Dev_Telemetry] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Dev_Telemetry]
GO
/****** Object:  StoredProcedure [dbo].[LogInsert]    Script Date: 10/23/2013 1:59:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Fajardo, Neil
-- Create date: 10/09/13
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LogInsert]
	-- Add the parameters for the stored procedure here
	@UserID int,
	@ApplicationID int,
	@TelemetryData varchar(MAX)
AS
BEGIN
    
	INSERT INTO Telemetry(TelemetryID, UserID, ApplicationID, TelemetryData, CreateDate)
	VALUES(NewID(), @UserID, @ApplicationID, @TelemetryData, GetDate())

END
' 
END
GO
/****** Object:  Table [dbo].[Telemetry]    Script Date: 10/23/2013 1:59:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Telemetry]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Telemetry](
	[TelemetryID] [uniqueidentifier] NOT NULL,
	[UserID] [int] NOT NULL,
	[ApplicationID] [int] NOT NULL,
	[TelemetryData] [varchar](max) NULL,
	[CreateDate] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Telemetry] ([TelemetryID], [UserID], [ApplicationID], [TelemetryData], [CreateDate]) VALUES (N'8bbc0cd6-25c4-4deb-9ac2-cea903ddb58f', 0, 1, N'this::that::theotherthing', CAST(0x0000A2520121BD9B AS DateTime))
INSERT [dbo].[Telemetry] ([TelemetryID], [UserID], [ApplicationID], [TelemetryData], [CreateDate]) VALUES (N'65e9139d-2a16-44e1-80ba-ec174b015428', 0, 1, N'AF::event::location', CAST(0x0000A2520121C569 AS DateTime))
USE [master]
GO
ALTER DATABASE [Dev_Telemetry] SET  READ_WRITE 
GO
