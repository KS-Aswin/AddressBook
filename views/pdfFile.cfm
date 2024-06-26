<cfoutput>
    <cfinclude template="./header.cfm">
    <cfif session.login>
        <cfhtmltopdf>
            <div class="d-flex displayProfiles" id="pdfContent">
                <div class="col-12">
                    <table class="table">
                        <thead>
                            <tr>
                                <th><h5><b class="tableHeading col-2">IMAGE</b></h5></th>
                                <th><h5><b class="tableHeading col-2">NAME</b></h5></th>
                                <th><h5><b class="tableHeading col-2">EMAIL ID</b></h5></th>
                                <th><h5><b class="tableHeading col-2">PHONE NUMBER</b></h5></th>
                                <th><h5><b class="tableHeading col-2">GENDER</b></h5></th>
                                <th><h5><b class="tableHeading col-2">DOB</b></h5></th>
                                <th><h5><b class="tableHeading col-2">ADDRESS</b></h5></th>
                                <th><h5><b class="tableHeading col-2">PINCODE</b></h5></th>
                                <th><h5><b class="tableHeading col-2">HOBBIES</b></h5></th>
                            </tr>
                        </thead>
                        <tbody>
                            <cfset contacts = EntityLoad("ormContactFunction")>
                            <cfloop array="#contacts#" index="contact">
                                <cfif session.intUid eq contact.getuserId()>
                                    <tr class="tableRow" id="">
                                        <th class="pdfImg col-12 w-12 d-flex">
                                            <img src="../assets/UploadImages/#contact.getphoto()#" alt="userProfile" width='30' height='30'>
                                        </th>
                                        <th>#contact.getfirstName()# #contact.getlastName()#</th>
                                        <th>#contact.getemail()#</th>
                                        <th>#contact.getphone()#</th>
                                        <th>#contact.getgender()#</th>
                                        <th>#contact.getdob()#</th>
                                        <th>#contact.getaddress()#, #contact.getstreet()#</th>
                                        <th>#contact.getpincode()#</th>
                                        
                                        <th>
                                            <cfset hobbies = EntityLoad("ormHobbies", { contact = contact })>
                                            <cfif arrayLen(hobbies)>
                                                <cfloop array="#hobbies#" index="hobbie">
                                                    <cfset hobbyList = EntityLoadByPK("ormHobbyTable", hobbie.gethobbyId())>
                                                    #hobbyList.gethobbyName()# &emsp;
                                                </cfloop>
                                            </cfif>
                                        </th>
                                    </tr>
                                </cfif>
                            </cfloop>
                        </tbody>
                    </table>
                </div>
            </div>
        </cfhtmltopdf>
    <cfelse>
        <cflocation url="../index.cfm">
    </cfif>
</cfoutput>
