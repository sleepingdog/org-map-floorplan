<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="xs xd" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> 2016-06-01</xd:p>
            <xd:p><xd:b>Author:</xd:b> Tavis Reddick</xd:p>
            <xd:p>Takes a SVG document exported from Autodesk Graphic and refactors it.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:output indent="yes" media-type="image/svg+xml" method="xml" xml:space="default" />
    <xsl:include href="copy.xslt" />
    <xsl:param name="debug" as="xs:boolean" select="false()" />
    <xsl:variable name="floorColour" select="'#003300'" />
    <xsl:variable name="floorStyleName" select="'floor'" />
    <xsl:variable name="roomStyleName" select="'room'" />
    <xsl:variable name="doorStyleName" select="'door'" />
    <xsl:variable name="waypointStyleName" select="'waypoint'" />
    <xsl:template match="/">
        <!-- Copy the original SVG document using copy.xslt, except where matches are found below. -->
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="svg:svg">
        <xsl:copy>
            <xsl:if test="$debug = true()">
                <xsl:attribute name="class" select="'debug'" />
            </xsl:if>
            <xsl:copy-of select="@*" />
            <xsl:element name="defs">
                <xsl:element name="style">
                    <xsl:attribute name="type" select="'text/css'"/>
                    <xsl:text>
                    .floor {
                        fill: #003300;
                        stroke: #666635;
                        stroke-width: 1;
                    }
                    .room {
                        fill: #DBDBDB;
                    }
                    .waypoint {
                        fill: #CCCC00;
                    }
                    .door {
                        fill: #993333;
                    }
                    .debug #F0 {
                        display: none;
                    }
                    .debug #F2 {
                        display: none;
                    }
                    .debug #Atrium {
                        display: none;
                    }
                </xsl:text>
                </xsl:element>
            </xsl:element>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="svg:svg/svg:defs"/><!-- remove existing defs, it will be replaced -->
    <xsl:template match="svg:path/@clip-path"/><!-- remove clip paths -->
    <xsl:template match="svg:path/@filter"/><!-- remove filters -->
    <xsl:template match="svg:g[svg:g/svg:path[position() = 1 and @fill]][ends-with(svg:text/svg:tspan, 'East') or ends-with(svg:text/svg:tspan, 'West') or ends-with(svg:text/svg:tspan, 'North') or ends-with(svg:text/svg:tspan, 'South')]">
        <!-- floor wing sections -->
        <xsl:element name="g" namespace="http://www.w3.org/2000/svg">
            <xsl:attribute name="id" select="svg:text/svg:tspan" />
            <xsl:element name="path">
                <xsl:attribute name="d" select="svg:g[position() = 1]/svg:path[position() = 2]/@d"/>
                <xsl:attribute name="class" select="$floorStyleName"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="svg:g[svg:g/svg:path/@stroke-dasharray]"></xsl:template><!-- remove corner rampways -->
    <xsl:template match="svg:g[matches(svg:g[1]/svg:text[1]/svg:tspan[1], 'PH-OB-F[0-2]-R')]">
        <!-- rooms -->
        <xsl:element name="g" namespace="http://www.w3.org/2000/svg">
            <xsl:attribute name="id" select="svg:g[1]/svg:text/svg:tspan" />
            <xsl:element name="path">
                <xsl:attribute name="d" select="svg:g[1]/svg:g[1]/svg:path[1]/@d"/>
                <xsl:attribute name="class" select="$roomStyleName"/>
            </xsl:element>
            <xsl:element name="path">
                <xsl:attribute name="d" select="svg:g[2]/svg:g[1]/svg:path[1]/@d | svg:g[2]/svg:path[1]/@d"/><!-- For some reason, floor 1 rooms have a different structure. -->
                <xsl:attribute name="class" select="$waypointStyleName"/>
            </xsl:element>
            <xsl:element name="path">
                <xsl:attribute name="d" select="svg:g[3]/svg:path[1]/@d | svg:path[1]/@d"/><!-- For some reason, floor 1 rooms have a different structure. -->
                <xsl:attribute name="class" select="$doorStyleName"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
