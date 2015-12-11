<%
Response.ContentType = "application/json"

dim idCorso
idCorso = ""
idCorso = Request.QueryString("idCorso")


dim connessione
connessione = "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & server.MapPath("App_data/Corsi.mdb") 

Dim conn 
Set conn = Server.CreateObject("ADODB.Connection") 
conn.Open connessione

Dim Corsi
Dim rsCorsi
Dim sqlCorsi
    
        
sqlCorsi = "SELECT * FROM messaggio WHERE stato='visibile'"

if idCorso <> "" then
	sqlCorsi = sqlCorsi & " AND ID=" & idCorso
end if

sqlCorsi = sqlCorsi & " ORDER BY posizione ASC"

Set rsCorsi = Server.CreateObject("ADODB.Recordset")		 

rsCorsi.Open sqlCorsi, conn


Set corsi = jsArray()
if not rsCorsi.EOF then
	while not rsCorsi.EOF
		Set corsi(null)=jsObject()
		corsi(null)("ID") = rsCorsi.Fields("ID")
		corsi(null)("titolo") = rsCorsi.Fields("titolo")
		corsi(null)("immagine1") = rsCorsi.Fields("immagine1")
		corsi(null)("descrizione") = rsCorsi.Fields("descrizione")
		corsi(null)("user") = rsCorsi.Fields("user")
		corsi(null)("posizione") = rsCorsi.Fields("posizione")
		corsi(null)("data") = rsCorsi.Fields("data")
		corsi(null)("pdf") = rsCorsi.Fields("pdf")
		corsi(null)("descrizione_breve") = rsCorsi.Fields("descrizione_breve")
		corsi(null)("stato") = rsCorsi.Fields("stato")
		corsi(null)("oscurato") = rsCorsi.Fields("oscurato")
		rsCorsi.MoveNext()
	wend
end if
			
     
        




%>
<!--#include file="JSON_library.asp"-->
<!--#include file="JSON_UTIL.asp"-->

<%
'QueryToJSON(conn, sql).Flush
%>
<%
corsi.Flush
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
rsCorsi.Close
conn.Close
set rsCorsi=nothing
set conn=nothing
%>