<cfoutput>
    <cfhtmltopdf>
        <div class="d-flex displayProfiles" id="pdfContent">
            <div class="w-100">
                <table class="table" >
                    <thead>
                        <tr>
                            <th>
                                <h5><b class="tableHeading">IMAGE</b></h5>
                            </th>
                            <th>
                                <h5><b class="tableHeading">NAME</b></h5>
                            </th>
                            <th>
                                <h5><b class="tableHeading">EMAIL ID</b></h5>
                            </th>
                            <th>
                                <h5><b class="tableHeading">PHONE NUMBER</b></h5>
                            </th>
                            <th>
                                <h5><b class="tableHeading">GENDER</b></h5>
                            </th>
                            <th>
                                <h5><b class="tableHeading">DOB</b></h5>
                            </th>
                            <th>
                                <h5><b class="tableHeading">ADDRESS</b></h5>
                            </th>
                            <th>
                                <h5><b class="tableHeading">PINCODE</b></h5>
                            </th>
                            
                        </tr>
                    </thead>
                    <tbody>
                    <cfset contacts = EntityLoad("ormContactFunction")>
                    <cfloop array="#contacts#" index="contact">
                        <cfset variables.contactId = contact.getcontactId()>
                        <cfif session.intUid eq contact.getuserId()>
                            <tr class="tableRow" id="">
                            <th class="pdfImg"><img src="./assets/UploadImages/#contact.getphoto()#"  alt="userProfile" width='30' height='30'></th>
                                <th>#contact.getfirstName()# #contact.getlastName()#</th>
                                <th>#contact.getemail()#</th>
                                <th>#contact.getphone()#</th>
                                <th>#contact.getgender()#</th>
                                <th>#contact.getdob()#</th>
                                <th>#contact.getaddress()#, #contact.getstreet()#</th>
                                <th>#contact.getpincode()#</th>    
                            </tr>
                        <cfelse>
                            <cfcontinue>
                        </cfif>
                    </cfloop>
                </tbody>
            </table>
        </div>
    </cfhtmltopdf>
</cfoutput>