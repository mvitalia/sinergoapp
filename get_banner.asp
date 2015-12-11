<%
Response.ContentType = "application/json"

dim idBanner
idBanner = ""
idBanner = Request.QueryString("idCorso")


dim connessione
connessione = "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & server.MapPath("App_data/Banner.mdb") 

Dim conn 
Set conn = Server.CreateObject("ADODB.Connection") 
conn.Open connessione

Dim Banner
Dim rsBanner
Dim sqlBanner
    
        
sqlBanner = "SELECT * FROM messaggio WHERE stato='visibile'"

if idBanner <> "" then
	sqlBanner = sqlBanner & " AND ID=" & idBanner
end if

sqlBanner = sqlBanner & "ORDER BY posizione, data_inserimento"

Set rsBanner = Server.CreateObject("ADODB.Recordset")		 

rsBanner.Open sqlBanner, conn


Set Banner = jsArray()
if not rsBanner.EOF then
	while not rsBanner.EOF
		Set Banner(null)=jsObject()
		Banner(null)("ID") = rsBanner.Fields("ID")
		Banner(null)("titolo") = rsBanner.Fields("titolo")
		Banner(null)("immagine1") = rsBanner.Fields("immagine1")
		Banner(null)("user") = rsBanner.Fields("user")
		Banner(null)("posizione") = rsBanner.Fields("posizione")
		Banner(null)("data") = rsBanner.Fields("data_inserimento")
		Banner(null)("pdf") = rsBanner.Fields("pdf")
		Banner(null)("stato") = rsBanner.Fields("stato")
		Banner(null)("link") = rsBanner.Fields("link")
		Banner(null)("immagine2") = rsBanner.Fields("immagine2")
		rsBanner.MoveNext()
	wend
end if
			
     
        




%>
<!--#include file="JSON_library.asp"-->
<!--#include file="JSON_UTIL.asp"-->

<%
'QueryToJSON(conn, sql).Flush
%>
<%
Banner.Flush
%>

<% 'response.write """,""foto"""
	'	response.write ": ["
		'lista foto
	'	dim rs_foto
	'	sql_foto = "Select * From app_foto WHERE ID_attivita = " & rs.Fields("ID") 
	'	Set rs_foto = Server.CreateObject("ADODB.Recordset") 
	'	rs_foto.Open sql_foto, conn
		
	'	if not rs_foto.EOF then
	'		while not rs_foto.EOF
	'			response.write "{""immagine"""
	'			response.write ": """
	'			response.write rs_foto.Fields("immagine") 
	'			response.write """,""titolo"""
	'			response.write ": """
	'			response.write rs_foto.Fields("titolo") 
	'			response.write """,""tipologia"""
	'			response.write ": """
	'			response.write rs_foto.Fields("tipologia") 
	'			response.write """}"
				
	'			rs_foto.MoveNext
	'		wend
			
	'		rs_foto.Close
	'		set rs_foto=nothing

	'	end if
		
	'	response.write "]"
		'fine foto	
%>

<%
rsBanner.Close
conn.Close
set rsBanner=nothing
set conn=nothing
%>