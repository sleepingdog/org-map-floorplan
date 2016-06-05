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
-- Modified on 2016-06-04 to add root svg element.
-- =============================================
ALTER PROCEDURE dbo.usp_FloorplanSVG
	-- Add the parameters for the stored procedure here
	@campusId VARCHAR(5), 
	@buildingId VARCHAR(5),
	@floorId VARCHAR(5),
	@roomId VARCHAR(5) = NULL, -- optionally highlight a room
	@internetType VARCHAR(25) = 'image/svg+xml'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
DECLARE @Rooms AS XML, @Floor AS XML, @Svg AS XML, @Html AS XML, @Navigation AS XML;
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
');
SET @Svg = (SELECT SVG FROM dbo.Building WHERE BuildingID = @buildingId);
SET @Svg.modify('
	declare namespace svg="http://www.w3.org/2000/svg";
	insert sql:variable("@Floor") as last
	into (svg:svg)[1]
');
IF @internetType = 'text/html'
	BEGIN
		DECLARE @Title AS NVARCHAR(255);
		SET @Title = 
			(SELECT TOP 1 Title FROM dbo.Campus WHERE CampusID = @campusId) + ' ' +
			(SELECT TOP 1 Title FROM dbo.Building WHERE BuildingID = @buildingId) + ' ' +
			(SELECT TOP 1 Title FROM dbo.Floor WHERE FloorID = @floorId) + ' floor'
		SET @Navigation = (
			SELECT '/campus' AS 'a/@href', 'Campus ' + 'PH' AS a
			UNION
			SELECT '/campus(' + CampusID + ')/building(' + BuildingID + ')/floor(' + FloorID + ')' AS 'a/@href', FloorID AS a
			FROM dbo.Floor
			WHERE CampusID = @campusId
				AND BuildingID = @buildingId
				FOR XML PATH('li'), ROOT('ul')
		);
		SET @Html = '<html><head><title>' + @Title + '</title>' +
			'<meta charset="utf-8" />
			<meta name="viewport" content="width=device-width,initial-scale=1.0" />
			<link href="/style/kelpie_styles.css" rel="stylesheet" type="text/css" />
			<link href="/style/kelpie_map.css" rel="stylesheet" type="text/css" />' +
			'</head><body><h1>' + @Title + '</h1>' + 
			'<nav>' +
			CAST(@Navigation AS NVARCHAR(MAX)) +
			'</nav>' +
			'</body></html>'
		SET @Html.modify('
			insert sql:variable("@Svg") as last
			into (html/body)[1]
		')
	END;
SELECT
	CASE @internetType
		WHEN 'image/svg+xml' THEN @Svg
		WHEN 'text/html' THEN @Html
	END;
END
/*
--Test
EXEC dbo.usp_FloorplanSVG @campusId = 'PH', @buildingId = 'OB', @floorId = 'F0';
EXEC dbo.usp_FloorplanSVG @campusId = 'PH', @buildingId = 'OB', @floorId = 'F1', @internetType = 'text/html';

*/
GO
