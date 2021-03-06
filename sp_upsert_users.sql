USE [IDM]
GO
/****** Object:  StoredProcedure [dbo].[sp_upsert_users]    Script Date: 10/23/2020 10:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_upsert_users]
(
@ID INT = NULL,
@First_Name VARCHAR(50),
@Middle_Name VARCHAR(50) = NULL,
@Last_Name VARCHAR(50),
@Gender VARCHAR(50),
@Email VARCHAR(50),
@Password nVARCHAR(50),
@Phone_Number BIGINT
)
AS
BEGIN

DECLARE @salt UNIQUEIDENTIFIER=NEWID()

IF EXISTS (SELECT * FROM Users WHERE Email = @Email )
BEGIN
	UPDATE Users SET First_Name = @First_Name, Middle_Name = @Middle_Name,
	Last_Name = @Last_Name, Gender = @Gender, Email = @Email, Password = @Password,
	Phone_Number = @Phone_Number WHERE ID = @ID

	END
	ELSE
	BEGIN
		INSERT INTO Users(First_Name,Middle_Name,Last_Name,Gender,Email,Password,Phone_Number,Salt) VALUES(@First_Name, @Middle_Name, @Last_Name, @Gender, @Email,
		 HASHBYTES('SHA2_512', @Password+CAST(@salt AS NVARCHAR(36))),@Phone_Number,@salt)
	END
END