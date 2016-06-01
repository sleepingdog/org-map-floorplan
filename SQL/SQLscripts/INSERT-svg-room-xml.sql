/* shred XML from SVG into room table */
USE sleeping_kelpiecollege;
/* declare a variable to hold the SVG to be loaded from file */
DECLARE @SVG AS XML;
SET @SVG = (SELECT CONVERT(xml, BulkColumn, 2) FROM OPENROWSET(
   BULK '\\MYBOOKLIVEDUO\sleepingdog\Projects\Coding\OrgMapFloorplan\XML\SVG\OrgMapFloorplanKCOB0-clean.svg',
   SINGLE_BLOB) AS x);
/* check that the variable now holds the SVG */
SELECT @SVG AS svg;
/* write an XQuery statement to select rooms */
SELECT @SVG.query('declare namespace svg="http://www.w3.org/2000/svg";         
    /svg:svg/svg:g[substring(@id, 1, 1) = "F"]/svg:g[substring(@id, 1, 7) = "PH-OB-F"]
') AS svg
;
/* write a query to insert room data including primary key and SVG into Room table */


