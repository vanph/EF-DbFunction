USE [master]
GO
/****** Object:  Database [SampleDatabase]    Script Date: 7/20/2017 2:01:16 AM ******/
CREATE DATABASE [SampleDatabase]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SampleDatabase', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\SampleDatabase.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SampleDatabase_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\SampleDatabase_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SampleDatabase] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SampleDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SampleDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SampleDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SampleDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SampleDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SampleDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [SampleDatabase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SampleDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SampleDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SampleDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SampleDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SampleDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SampleDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SampleDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SampleDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SampleDatabase] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SampleDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SampleDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SampleDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SampleDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SampleDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SampleDatabase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SampleDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SampleDatabase] SET RECOVERY FULL 
GO
ALTER DATABASE [SampleDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [SampleDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SampleDatabase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SampleDatabase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SampleDatabase] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SampleDatabase] SET DELAYED_DURABILITY = DISABLED 
GO
USE [SampleDatabase]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_UserFullName]    Script Date: 7/20/2017 2:01:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fn_UserFullName] (@userid uniqueidentifier) 
returns varchar(210)
as 
begin
	declare @fullname varchar(210)
	
	select	@fullname = case when (p.MiddleName is null) or (p.MiddleName = '') 
						then p.FirstName + ' ' + p.Surname 
						else p.FirstName + ' ' + p.MiddleName + ' ' + p.Surname 
						end
	from Users u
	inner join Persons p on u.Personid = p.Personid
	where	u.Userid = @userid	
	
	return (@fullname);
end;


GO
/****** Object:  Table [dbo].[Persons]    Script Date: 7/20/2017 2:01:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Persons](
	[Personid] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[FirstName] [varchar](50) NOT NULL,
	[MiddleName] [varchar](50) NULL,
	[Surname] [varchar](100) NOT NULL,
	[DOB] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 7/20/2017 2:01:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[Userid] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[Personid] [uniqueidentifier] NOT NULL,
	[EmailAddress] [varchar](100) NOT NULL,
	[PasswordHash] [varchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Persons] ([Personid], [FirstName], [MiddleName], [Surname], [DOB]) VALUES (N'dd7158be-9f2f-e711-a6d9-0a730bf39e1b', N'Sean', N'', N'Paul', NULL)
INSERT [dbo].[Persons] ([Personid], [FirstName], [MiddleName], [Surname], [DOB]) VALUES (N'22b81276-a02f-e711-a6d9-0a730bf39e1b', N'Barbara', NULL, N'Santa', NULL)
INSERT [dbo].[Persons] ([Personid], [FirstName], [MiddleName], [Surname], [DOB]) VALUES (N'87397d96-a32f-e711-a6d9-0a730bf39e1b', N'Charmaine', NULL, N'Sheh', NULL)
INSERT [dbo].[Persons] ([Personid], [FirstName], [MiddleName], [Surname], [DOB]) VALUES (N'fc10c71c-bc2f-e711-a6d9-0a730bf39e1b', N'Charmaine', NULL, N'Sinatra', NULL)
INSERT [dbo].[Persons] ([Personid], [FirstName], [MiddleName], [Surname], [DOB]) VALUES (N'aa44c006-7334-e711-a6d9-0a730bf39e1b', N'Hamish', N'', N'Leighton', NULL)
INSERT [dbo].[Persons] ([Personid], [FirstName], [MiddleName], [Surname], [DOB]) VALUES (N'e624b051-3d35-e711-a6d9-0a730bf39e1b', N'Mike', N'', N'Quill', NULL)
INSERT [dbo].[Persons] ([Personid], [FirstName], [MiddleName], [Surname], [DOB]) VALUES (N'7ea225ae-4135-e711-a6d9-0a730bf39e1b', N'Anton', NULL, N'Balaz', NULL)
INSERT [dbo].[Persons] ([Personid], [FirstName], [MiddleName], [Surname], [DOB]) VALUES (N'ddf6b3fd-4335-e711-a6d9-0a730bf39e1b', N'Joel', N'Van', N'Coen', NULL)
INSERT [dbo].[Persons] ([Personid], [FirstName], [MiddleName], [Surname], [DOB]) VALUES (N'4313a50f-f444-e711-a6d9-0a730bf39e1b', N'Shaun', N'Patrick', N'Daly', NULL)
INSERT [dbo].[Persons] ([Personid], [FirstName], [MiddleName], [Surname], [DOB]) VALUES (N'5ea68a7a-ff44-e711-a6d9-0a730bf39e1b', N'Arnold', N'', N'Dvstest', NULL)
INSERT [dbo].[Persons] ([Personid], [FirstName], [MiddleName], [Surname], [DOB]) VALUES (N'3a112111-5646-e711-a6d9-0a730bf39e1b', N'Barbara', N'', N'Petzold', NULL)
INSERT [dbo].[Persons] ([Personid], [FirstName], [MiddleName], [Surname], [DOB]) VALUES (N'dafdfba8-6046-e711-a6d9-0a730bf39e1b', N'Nelly', N'', N'Sachs', CAST(N'1977-09-14 00:00:00.000' AS DateTime))
INSERT [dbo].[Persons] ([Personid], [FirstName], [MiddleName], [Surname], [DOB]) VALUES (N'a52bbb19-e64f-e711-a6d9-0a730bf39e1b', N'Big', NULL, N'Admin', NULL)
INSERT [dbo].[Persons] ([Personid], [FirstName], [MiddleName], [Surname], [DOB]) VALUES (N'037da8f2-495d-e711-a6d9-0a730bf39e1b', N'Anton', NULL, N'Unverified', NULL)
INSERT [dbo].[Users] ([Userid], [Personid], [EmailAddress], [PasswordHash]) VALUES (N'de7158be-9f2f-e711-a6d9-0a730bf39e1b', N'dd7158be-9f2f-e711-a6d9-0a730bf39e1b', N'Sean.Landlord@example.com', N'AOA/cOV+B+tPM1TYZbJ9GyG+PTXs6RClMa6RLRLILOE60Pm+Iyhm1U4YwdOW1iH/yQ==')
INSERT [dbo].[Users] ([Userid], [Personid], [EmailAddress], [PasswordHash]) VALUES (N'23b81276-a02f-e711-a6d9-0a730bf39e1b', N'22b81276-a02f-e711-a6d9-0a730bf39e1b', N'barbara.tenant@example.com', N'AL/P1HjcNImFaYCKGkT7pLh7hvAcUGLevFkbWUQ321JUYfibx115cJ5u6nTxGsXd8w==')
INSERT [dbo].[Users] ([Userid], [Personid], [EmailAddress], [PasswordHash]) VALUES (N'88397d96-a32f-e711-a6d9-0a730bf39e1b', N'87397d96-a32f-e711-a6d9-0a730bf39e1b', N'charmaine.delegate@example.com', N'ACqurP9oaTuZd8R0CU+uqoXUuB+6fbOpbsTtYb7YoN1DnpGyxHXNSIVRd2wBzpqt9Q==')
INSERT [dbo].[Users] ([Userid], [Personid], [EmailAddress], [PasswordHash]) VALUES (N'fd10c71c-bc2f-e711-a6d9-0a730bf39e1b', N'fc10c71c-bc2f-e711-a6d9-0a730bf39e1b', N'charmaine.tenant@example.com', N'AMKSwiKVXL7ZwOOahsddaGLxLvHE9CLuYGvza0VtZPvFNICFZUgD0KbLcWRhgxX/tA==')
INSERT [dbo].[Users] ([Userid], [Personid], [EmailAddress], [PasswordHash]) VALUES (N'ab44c006-7334-e711-a6d9-0a730bf39e1b', N'aa44c006-7334-e711-a6d9-0a730bf39e1b', N'Hamish.Director@example.com', N'ACjXmjBrWe6DjRE/b1O0bHz1blJeHd1PR3dEG2dOMNUBEZfIRY89luHnTdMjzRm5GQ==')
INSERT [dbo].[Users] ([Userid], [Personid], [EmailAddress], [PasswordHash]) VALUES (N'e724b051-3d35-e711-a6d9-0a730bf39e1b', N'e624b051-3d35-e711-a6d9-0a730bf39e1b', N'mike.director@example.com', N'AL9NpyIsp7i3jBMrmepL689QRgwnNAzZmOQWJf9+0JKra8gDJpvc0y+eMOziCwUNXw==')
INSERT [dbo].[Users] ([Userid], [Personid], [EmailAddress], [PasswordHash]) VALUES (N'7fa225ae-4135-e711-a6d9-0a730bf39e1b', N'7ea225ae-4135-e711-a6d9-0a730bf39e1b', N'anton.solictor@example.com', N'APsM0zlCISPUJ0M2TOBIie0FuLEgDW7t0w630GIEJ4XefZHSbHpNN5jKIIkhHtck5w==')
INSERT [dbo].[Users] ([Userid], [Personid], [EmailAddress], [PasswordHash]) VALUES (N'def6b3fd-4335-e711-a6d9-0a730bf39e1b', N'ddf6b3fd-4335-e711-a6d9-0a730bf39e1b', N'joel.guarantor@example.com', N'AHCgKY/kB1O7wX45XuFMw7asNhmk+OTwg3IGTimrLf19kWRIbw2Az44hP2ApXeRuEw==')
INSERT [dbo].[Users] ([Userid], [Personid], [EmailAddress], [PasswordHash]) VALUES (N'4413a50f-f444-e711-a6d9-0a730bf39e1b', N'4313a50f-f444-e711-a6d9-0a730bf39e1b', N'shaun.solicitor@example.com', N'ALK52qvSsy+/DT63+VI7RFI85J4ru25fvbwALykMBwVk8j2xPqERkooqNg2iXcLmKw==')
INSERT [dbo].[Users] ([Userid], [Personid], [EmailAddress], [PasswordHash]) VALUES (N'5fa68a7a-ff44-e711-a6d9-0a730bf39e1b', N'5ea68a7a-ff44-e711-a6d9-0a730bf39e1b', N'arnold.accountant@example.com', N'AJY0LSCEG/NqedOm9QjOt2uw1kMv7psrh6Kbh+9gVBMcqf+CxUuqMuEzwAbM31W5kw==')
INSERT [dbo].[Users] ([Userid], [Personid], [EmailAddress], [PasswordHash]) VALUES (N'3b112111-5646-e711-a6d9-0a730bf39e1b', N'3a112111-5646-e711-a6d9-0a730bf39e1b', N'barbara.guarantor@example.com', N'AFDTitTB/b+Bfy7UtG52ANzc1i1KLhSIzHPvTi1p9rSARljAM0Fc0pVXI2AZza2CxQ==')
INSERT [dbo].[Users] ([Userid], [Personid], [EmailAddress], [PasswordHash]) VALUES (N'dbfdfba8-6046-e711-a6d9-0a730bf39e1b', N'dafdfba8-6046-e711-a6d9-0a730bf39e1b', N'Nelly.Sachs@example.com', N'ALdF383StcG2Gw3Bdg8hN9QkY7fBJEsnQLWTq5XVhh+bZBsno/PJrZjoLvOtFckLhw==')
INSERT [dbo].[Users] ([Userid], [Personid], [EmailAddress], [PasswordHash]) VALUES (N'a62bbb19-e64f-e711-a6d9-0a730bf39e1b', N'a52bbb19-e64f-e711-a6d9-0a730bf39e1b', N'BigAdmin@example.com', N'AMWfib38V66FJl7A846N8xt4ZVZtcm8ZFQyUwtGGNhiy/owSbX0IrxD+aK5Kod/wiA==')
INSERT [dbo].[Users] ([Userid], [Personid], [EmailAddress], [PasswordHash]) VALUES (N'047da8f2-495d-e711-a6d9-0a730bf39e1b', N'037da8f2-495d-e711-a6d9-0a730bf39e1b', N'Anton.unverified@example.com', N'AANcM64PjS84cJo+fjTGvS6Vo1OetNsozWq4T7sVi6R2nPIihZGJQYOZH69nvWhKmw==')
/****** Object:  Index [PK_Persons]    Script Date: 7/20/2017 2:01:16 AM ******/
ALTER TABLE [dbo].[Persons] ADD  CONSTRAINT [PK_Persons] PRIMARY KEY NONCLUSTERED 
(
	[Personid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_Users]    Script Date: 7/20/2017 2:01:16 AM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [PK_Users] PRIMARY KEY NONCLUSTERED 
(
	[Userid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UX_User_Email]    Script Date: 7/20/2017 2:01:16 AM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UX_User_Email] UNIQUE NONCLUSTERED 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Person] FOREIGN KEY([Personid])
REFERENCES [dbo].[Persons] ([Personid])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Person]
GO
USE [master]
GO
ALTER DATABASE [SampleDatabase] SET  READ_WRITE 
GO
