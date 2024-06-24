<cfoutput>
    <cfif session.login>
        <cfset contacts = EntityLoad("ormContactFunction")>
        <cfset excelQuery = queryNew("Fullname,Email,Phone,Gender,DOB,Address,Pincode,Photo,Hobbies","varchar,varchar,varchar,varchar,date,varchar,integer,varchar,varchar")> 
        <cfloop array="#contacts#" index="contact">
            <cfif session.intUid Eq contact.getuserId()>
                <cfset local.fullName = contact.gettitle() & "." &contact.getfirstName() & " " & contact.getlastName()>
                <cfset local.email = contact.getemail()>
                <cfset local.phone = contact.getphone()>
                <cfset local.gender = contact.getgender()>
                <cfset local.dob = contact.getdob()>
                <cfset local.address = contact.getaddress() & ", " & contact.getstreet()>
                <cfset local.pincode = contact.getpincode()>
                <cfset local.photo = contact.getphoto()>
                <cfset local.addHobby=''>
                
                <cfset hobbies = EntityLoad("ormHobbies", { contact = contact })>
                <cfif arrayLen(hobbies)>
                    <cfloop array="#hobbies#" index="hobbie">
                    <cfset hobbyList = EntityLoadByPK("ormHobbyTable", hobbie.gethobbyId())>
                    <cfset local.addHobby &= hobbyList.gethobbyName()&','>
                    </cfloop>
                <cfelse>
                </cfif>
                <cfset queryAddRow(excelQuery, 1)>
                <cfset querySetCell(excelQuery, "Fullname", local.fullName)>
                <cfset querySetCell(excelQuery, "Email", local.email)>
                <cfset querySetCell(excelQuery, "Phone", local.phone)>
                <cfset querySetCell(excelQuery, "Gender", local.gender)>
                <cfset querySetCell(excelQuery, "DOB", local.dob)>
                <cfset querySetCell(excelQuery, "Address", local.address)>
                <cfset querySetCell(excelQuery, "Pincode", local.pincode)>
                <cfset querySetCell(excelQuery, "Photo", local.photo)>
                <cfset querySetCell(excelQuery,'Hobbies',local.addHobby)>
            </cfif>
        </cfloop>
        <cfset excelPath = ExpandPath("./contactDetail.xlsx")>
        <cfspreadsheet action="write" filename="#excelPath#" query="excelQuery" sheetname="contacts">
        <cfheader name="Content-Disposition" value="attachment; filename=contactDetail.xlsx">
        <cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" file="#excelPath#" deleteFile="true">
    <cfelse>
        <cflocation  url="../index.cfm">
    </cfif>
</cfoutput>