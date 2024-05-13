<cfquery name="contactList">
    SELECT 
        CONCAT(firstName, lastName) AS Name, email, phone,gender,dob,CONCAT(address, street) AS Address,pincode
    FROM contact
    where userId=<cfqueryparam value = "#session.intUid#" CFSQLType ='cf_sql_integer'>
</cfquery>
<cfspreadsheet action="write" filename="#ExpandPath("./assets/downloadedFiles/xlList.xlsx")#" overwrite="true" query='contactList'>
<cfheader name="Content-Disposition" value="attachment; filename=contactList.xlsx">
<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" file="#ExpandPath('./assets/downloadedFiles/contactList.xlsx')#">