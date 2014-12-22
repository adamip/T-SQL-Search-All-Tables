USE [Productions_MSCRM]
GO
/****** Object:  StoredProcedure [dbo].[SearchMyData]    Script Date: 08/01/2014 15:12:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SearchMyData]
    @DataToFind NVARCHAR(4000),
    @ExactMatch BIT = 0
AS
SET NOCOUNT ON
 
CREATE TABLE #Output(SchemaName sysname, TableName sysname, ColumnName sysname)
 
IF ISDATE(@DataToFind) = 1
    INSERT INTO #Output EXEC SearchMyData_Date @DataToFind
 
IF ISNUMERIC(@DataToFind) = 1
    INSERT INTO #Output EXEC SearchMyData_Number @DataToFind, @Exactmatch
 
INSERT INTO #Output EXEC SearchMyData_String @DataToFind, @ExactMatch
 
SELECT SchemaName, TableName, ColumnName
	FROM   #Output
	ORDER BY SchemaName,TableName, ColumnName;