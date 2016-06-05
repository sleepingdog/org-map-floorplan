/* For the purposes of drawing the building's floors, set a root SVG element. */
UPDATE dbo.Building
	SET SVG = '<svg xmlns="http://www.w3.org/2000/svg"
     xmlns:xlink="http://www.w3.org/1999/xlink"
     version="1.1"
     x="0"
     y="0"
     width="100%"
     height="100%"
     viewBox="0, 0, 1417.323, 1417.323"
     preserveAspectRatio="xMidYMid meet"
     zoomAndPan="magnify"
     contentScriptType="text/ecmascript"
     contentStyleType="text/css" />'
	WHERE BuildingID = 'OB';
