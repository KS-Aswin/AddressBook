<cfoutput>
    <cfset local.contactData = EntityLoad("ormContactFunction")>
    <cfset local.resultMissing = EntityLoad("ormResult")>
    <cfset local.queryValue = queryNew("Title,FirstName,LastName,Gender,DOB,Photo,Address,Street,Email,Pincode,Phone,Hobbies,Results","varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar")> 
    <cfloop array=#local.resultMissing# index="value">
        <cfif session.intUid EQ value.getuserId()>
            <cfset queryAddRow(local.queryValue, 1)>
            <cfset querySetCell(local.queryValue, "Title", value.getTitle())>
            <cfset querySetCell(local.queryValue, "FirstName", value.getFirstName())>
            <cfset querySetCell(local.queryValue, "LastName", value.getLastName())>
            <cfset querySetCell(local.queryValue,"Gender",value.getGender())>
            <cfset querySetCell(local.queryValue,"DOB",value.getDOB())>
            <cfset querySetCell(local.queryValue, "Photo",value.getPhoto() )>
            <cfset querySetCell(local.queryValue,'Address',value.getAddress())>
            <cfset querySetCell(local.queryValue,'Street',value.getstreet())>
            <cfset querySetCell(local.queryValue, "Email", value.getEmail())>
            <cfset querySetCell(local.queryValue,'PinCode',value.getPincode())>
            <cfset querySetCell(local.queryValue,'Phone',value.getPhone())>
            <cfset querySetCell(local.queryValue,'Hobbies',value.getHobbies())>
            <cfset querySetCell(local.queryValue,'Results',value.getResult())>
        </cfif>
    </cfloop>
    <cfset excelFilePath = ExpandPath("./contactList.xlsx")>
    <cfspreadsheet action="write" filename="#excelFilePath#" query="local.queryValue" sheetname="contacts">
    <cfheader name="Content-Disposition" value="attachment; filename=Upload_Result.xlsx">
    <cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" file="#excelFilePath#" deleteFile="true">
</cfoutput>
</body>
</html>