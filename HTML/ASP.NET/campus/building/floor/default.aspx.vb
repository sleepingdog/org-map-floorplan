Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Xml
Imports System.Xml.XPath

Partial Class campus_building_floor_default
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Get parameters from query string.
        Dim strCampus As String = Convert.ToString(Page.RouteData.Values("campusid")) 'Request.QueryString("campusid")
        Dim strBuilding As String = Convert.ToString(Page.RouteData.Values("buildingid")) 'Request.QueryString("buildingid")
        Dim strFloor As String = Convert.ToString(Page.RouteData.Values("floorid")) 'Request.QueryString("floorid")
        'Dim strRoom As String = Convert.ToString(Page.RouteData.Values("roomid")) 'Request.QueryString("roomid")
        Dim strInternetType As String = "text/html"

        Try
            'Set up SQL connection and command which returns XCRI XML, using named connection string from web.config file.
            Dim conn As SqlConnection
            conn = New SqlConnection(ConfigurationManager.ConnectionStrings("kelpiecollegeConnectionString").ConnectionString)
            Dim cmd As SqlCommand = New SqlCommand()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.CommandText = "dbo.usp_FloorplanSVG"
            cmd.Connection = conn

            'Add parameters.
            Dim sprCampus As SqlParameter = New SqlParameter()
            Dim sprBuilding As SqlParameter = New SqlParameter()
            Dim sprFloor As SqlParameter = New SqlParameter()
            'Dim sprRoom As SqlParameter = New SqlParameter()
            Dim sprInternetType As SqlParameter = New SqlParameter()
            sprCampus.ParameterName = "@campusId"
            sprCampus.SqlDbType = SqlDbType.VarChar
            sprCampus.Size = 5
            sprCampus.Direction = ParameterDirection.Input
            sprCampus.Value = strCampus
            sprBuilding.ParameterName = "@buildingId"
            sprBuilding.SqlDbType = SqlDbType.VarChar
            sprBuilding.Size = 5
            sprBuilding.Direction = ParameterDirection.Input
            sprBuilding.Value = strBuilding
            sprFloor.ParameterName = "@floorId"
            sprFloor.SqlDbType = SqlDbType.VarChar
            sprFloor.Size = 5
            sprFloor.Direction = ParameterDirection.Input
            sprFloor.Value = strFloor
            'sprRoom.ParameterName = "@roomId"
            'sprRoom.SqlDbType = SqlDbType.VarChar
            'sprRoom.Size = 5
            'sprRoom.Direction = ParameterDirection.Input
            'sprRoom.Value = strRoom
            sprInternetType.ParameterName = "@internetType"
            sprInternetType.SqlDbType = SqlDbType.VarChar
            sprInternetType.Size = 25
            sprInternetType.Direction = ParameterDirection.Input
            sprInternetType.Value = strInternetType
            cmd.Parameters.Add(sprCampus)
            cmd.Parameters.Add(sprBuilding)
            cmd.Parameters.Add(sprFloor)
            cmd.Parameters.Add(sprInternetType)

            'Open the connection.
            cmd.Connection.Open()

            'Get the XML from the stored procedure with an XmlReader and put it into the XML control to be passed to the requester.
            Dim xmlr As System.Xml.XmlReader
            xmlr = cmd.ExecuteXmlReader()
            xmlr.Read()
            Dim xpnDoc As New XPathDocument(xmlr)
            xmlFloor.XPathNavigator = xpnDoc.CreateNavigator()

            'Dispose of command and connection objects.
            cmd.Dispose()
            conn.Dispose()
        Catch ex As Exception
            'Do stuff to handle an exception.
            'lblDebug.Text += ex.Message
        End Try
    End Sub
End Class
