USE [IDM]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetUser]    Script Date: 10/23/2020 10:44:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetUser]
@Email VARCHAR(50),
@Password nVARCHAR(50)
AS
BEGIN

IF EXISTS (SELECT 1 FROM Users where Email = @Email and Password = HASHBYTES('SHA2_512', @Password+CAST(Salt AS NVARCHAR(36))) )
BEGIN
	SELECT u.ID,
			u.First_Name,
			u.Middle_Name,
			u.Last_Name,
			u.Email,
			u.Gender,
			u.Phone_Number,
			u.Salt as Token
			FROM Users u 
			where Email = @Email and Password = HASHBYTES('SHA2_512', @Password+CAST(Salt AS NVARCHAR(36)))
END
END