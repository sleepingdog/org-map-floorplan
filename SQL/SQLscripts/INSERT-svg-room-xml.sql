/* shred XML from SVG into room table */
USE sleeping_kelpiecollege;
/* declare a variable to hold the SVG to be loaded from file */
DECLARE @SVG AS XML;
SET @SVG = (SELECT CONVERT(xml, BulkColumn, 2) FROM OPENROWSET(
   BULK '\\MYBOOKLIVEDUO\sleepingdog\Projects\Coding\OrgMapFloorplan\XML\SVG\OrgMapFloorplanKCOB0-clean.svg',
   SINGLE_BLOB) AS x);
/* write a query to insert room data including multi-column primary key and SVG into Room table */
WITH XMLNAMESPACES(
	'http://www.w3.org/2000/svg' AS svg,
	DEFAULT 'http://www.w3.org/2000/svg'
		)
--Insert each Room
INSERT INTO dbo.Room(RoomID, FloorID, BuildingID, CampusID, SVG)
SELECT
	RoomSVG.value('substring(@id, 10, 3)', 'VARCHAR(5)') AS RoomID,
	RoomSVG.value('substring(@id, 7, 2)', 'VARCHAR(5)') AS FloorID,
	RoomSVG.value('substring(@id, 4, 2)', 'VARCHAR(5)') AS BuildingID,
	RoomSVG.value('substring(@id, 1, 2)', 'VARCHAR(5)') AS CampusID,
	RoomTable.RoomSVG.query('.') AS SVG -- the XML source itself
FROM @SVG.nodes('/svg:svg/svg:g[substring(@id, 1, 1) = "F"]/svg:g[substring(@id, 1, 7) = "PH-OB-F" and substring(@id, 10, 1) = "R"]') AS RoomTable(RoomSVG);
GO
SELECT *
FROM dbo.Room;
GO
