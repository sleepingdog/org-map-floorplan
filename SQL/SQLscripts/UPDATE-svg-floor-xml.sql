/* shred XML from SVG into floor table (adapted from room population script) */
USE sleeping_kelpiecollege;
/* declare a variable to hold the SVG to be loaded from file */
DECLARE @SVG AS XML;
SET @SVG = (SELECT CONVERT(xml, BulkColumn, 2) FROM OPENROWSET(
   BULK '\\MYBOOKLIVEDUO\sleepingdog\Projects\Coding\OrgMapFloorplan\XML\SVG\OrgMapFloorplanKCOB0-clean.svg',
   SINGLE_BLOB) AS x);
/* Modify the SVG variable to remove all Rooms from the Floors, as Rooms are stored separately. */
SET @SVG.modify('
  declare namespace svg="http://www.w3.org/2000/svg";  
  delete /svg:svg/svg:g[substring(@id, 1, 1) = "F"]/svg:g[substring(@id, 1, 7) = "PH-OB-F" and substring(@id, 10, 1) = "R"]
')  
/* Declare and set the variables for the chosen campus and building */
DECLARE @campusId AS VARCHAR(5) = 'PH', @buildingId AS VARCHAR(5) = 'OB';
/* write a query to insert room data including multi-column primary key and SVG into Room table */
WITH XMLNAMESPACES(
	'http://www.w3.org/2000/svg' AS svg,
	DEFAULT 'http://www.w3.org/2000/svg'
		)
/*
--Test with selection first
SELECT
	FloorSVG.value('@id', 'VARCHAR(5)') AS FloorID,
	@buildingId AS BuildingID,
	@campusId AS CampusID,
	FloorTable.FloorSVG.query('.') AS SVG -- the XML source itself minus the Room SVG nodes
FROM @SVG.nodes('/svg:svg/svg:g[substring(@id, 1, 1) = "F"]') AS FloorTable(FloorSVG);
*/
--Update each Floor
UPDATE dbo.Floor
	SET SVG = FloorTable.FloorSVG.query('.') -- the XML source itself minus the Room SVG nodes
	FROM @SVG.nodes('/svg:svg/svg:g[substring(@id, 1, 1) = "F"]') AS FloorTable(FloorSVG)
	WHERE CampusID = @campusId
		AND BuildingID = @buildingId
		AND FloorId = FloorSVG.value('@id', 'VARCHAR(5)')
;
GO
-- Ugly workaround to remove prefixes and add default namespace in SVG XML
UPDATE dbo.Floor
	SET SVG = CAST(REPLACE(REPLACE(CAST (SVG AS NVARCHAR(MAX)), 'svg:', ''), 'xmlns:svg="http://www.w3.org/2000/svg"', 'xmlns="http://www.w3.org/2000/svg"') AS XML)
;
SELECT *
FROM dbo.Floor;
GO
