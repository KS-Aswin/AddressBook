<cfoutput>
    <cfif session.login>
        <cfif structKeyExists(url,"fileName")>  
            <cfset local.excelFileName="contactDetail">   
        <cfelse>
            <cfset local.excelFileName="Template_with_data">  
        </cfif>
        <cfset contacts = EntityLoad("ormContactFunction",{userId="#session.intUid#"})>
        <cfset excelQuery = queryNew("Title,FirstName,LastName,Gender,DOB,Photo,Address,Street,Email,Pincode,Phone,Hobbies","varchar,varchar,varchar,varchar,date,varchar,varchar,varchar,varchar,integer,varchar,varchar")> 
        <cfloop array="#contacts#" index="contact">
            <cfset local.title = contact.gettitle()>
            <cfset local.firstName = contact.getfirstName()>
            <cfset local.lastName =   contact.getlastName()>
            <cfset local.gender = contact.getgender()>
            <cfset local.dob = contact.getdob()>
            <cfset local.photo = contact.getphoto()>
            <cfset local.address = contact.getaddress()>
            <cfset local.street = contact.getstreet()>
            <cfset local.email = contact.getemail()>
            <cfset local.pincode = contact.getpincode()>
            <cfset local.phone = contact.getphone()>
            <cfset local.addHobby=''>
            
            <cfset hobbies = EntityLoad("ormHobbies", { contact = contact })>
            <cfif arrayLen(hobbies)>
                <cfloop array="#hobbies#" index="hobbie">
                    <cfset hobbyList = EntityLoadByPK("ormHobbyTable", hobbie.gethobbyId())>
                    <cfset local.addHobby &=hobbyList.gethobbyName()&','>
                </cfloop>
            </cfif>
            <cfset queryAddRow(excelQuery, 1)>
            <cfset querySetCell(excelQuery, "Title", local.title)>
            <cfset querySetCell(excelQuery, "FirstName", local.firstName)>
            <cfset querySetCell(excelQuery, "LastName", local.lastName)>
            <cfset querySetCell(excelQuery, "Gender", local.gender)>
            <cfset querySetCell(excelQuery, "DOB", local.dob)>
            <cfset querySetCell(excelQuery, "Photo", local.photo)>
            <cfset querySetCell(excelQuery, "Address", local.address)>
            <cfset querySetCell(excelQuery, "Street", local.street)>
            <cfset querySetCell(excelQuery, "Email", local.email)>
            <cfset querySetCell(excelQuery, "Pincode", local.pincode)>
            <cfset querySetCell(excelQuery, "Phone", local.phone)>
            <cfset querySetCell(excelQuery,'Hobbies',local.addHobby)>
        </cfloop>
        <cfset excelPath = ExpandPath("./Template_with_data.xlsx")>
        <cfspreadsheet action="write" filename="#excelPath#" query="excelQuery" sheetname="contacts">
        <cfheader name="Content-Disposition" value="attachment; filename=#local.excelFileName#.xlsx">
        <cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" file="#excelPath#" deleteFile="true">
    </cfif>
</cfoutput>