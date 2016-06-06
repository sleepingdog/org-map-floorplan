<%@ Application Language="VB" %>
<%@ Import Namespace="System.Web.Routing" %>

<script RunAt="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        RegisterRoutes(RouteTable.Routes)
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
    End Sub

    Shared Sub RegisterRoutes(routes As RouteCollection)
        routes.MapPageRoute("",
            "courses({CourseId})",
            "~/courses/course/default.aspx")
        routes.MapPageRoute("",
            "campus({campusid})/building({buildingid})",
            "~/campus/building/default.aspx")
        routes.MapPageRoute("",
            "campus({campusid})/building({buildingid})/floor({floorid})",
            "~/campus/building/floor/default.aspx")
        routes.MapPageRoute("",
            "campus({campusid})/building({buildingid})/floor({floorid})/svg",
            "~/campus/building/floor/svg.aspx")
        routes.MapPageRoute("",
            "campus({campusid})/building({buildingid})/floor({floorid})/room({roomid})",
            "~/campus/building/floor/room/default.aspx")
    End Sub
</script>
