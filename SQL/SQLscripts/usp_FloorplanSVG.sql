-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tavis Reddick
-- Create date: 2016-06-02
-- Description:	Returns a floorplan in SVG.
-- =============================================
ALTER PROCEDURE dbo.usp_FloorplanSVG
	-- Add the parameters for the stored procedure here
	@campusId VARCHAR(5), 
	@buildingId VARCHAR(5),
	@floorId VARCHAR(5),
	@roomId VARCHAR(5) = NULL -- optionally highlight a room
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
DECLARE @Rooms AS XML, @Floor AS XML;
SET @Rooms = (SELECT (SELECT SVG) -- we don't want to add any new elements so use subquery
		FROM dbo.Room
		WHERE CampusID = @campusId
			AND BuildingID = @buildingId
			AND FloorID = @floorId
		FOR XML PATH ('')); -- we don't want to add any new elements so use empty path
SET @Floor = (SELECT SVG
	FROM dbo.Floor
	WHERE CampusID = @campusId
		AND BuildingID = @buildingId
		AND FloorID = @floorId);
SET @Floor.modify('
	declare namespace svg="http://www.w3.org/2000/svg";
	insert sql:variable("@Rooms") as last
	into (svg:g)[1]
')
;
SELECT @Floor;
END
GO
/*
--Test
EXEC dbo.usp_FloorplanSVG @campusId = 'PH', @buildingId = 'OB', @floorId = 'F0';

*/