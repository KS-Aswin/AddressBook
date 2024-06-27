<cfoutput>

    <cfset headings = "Title,FirstName,LastName,Gender,DOB,Photo,Address,Street,Email,Pincode,Phone,Hobbies">

    <cfset excelHeaderQuery = queryNew(headings, "varchar,varchar,varchar,varchar,date,varchar,varchar,varchar,varchar,integer,varchar,varchar")>

    <cfset excelPath = ExpandPath("./Plain_Template.xlsx")>

    <cfspreadsheet action="write" filename="#excelPath#" query="excelHeaderQuery" sheetname="headers">

    <cfheader name="Content-Disposition" value="attachment; filename=Plain_Template.xlsx">

    <cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" file="#excelPath#" deleteFile="true">
    
</cfoutput>
