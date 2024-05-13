<cfoutput>
    <cfhtmltopdf>
        <div class="d-flex displayProfiles" id="pdfContent">
            <div class="w-100">
                <table class="table table-hover" >
                    <thead>
                        <tr>
                            <th>
                                <h5><b class="tableHeading"></b></h5>
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
                                <h5><b class="tableHeading"></b></h5>
                            </th>
                            <th>
                                <h5><b class="tableHeading"></b></h5>
                            </th>
                            <th>
                                <h5><b class="tableHeading"></b></h5>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                    <cfset contacts = EntityLoad("ormContactFunction")>
                    <cfloop array="#contacts#" index="contact">
                        <cfset variables.contactId = contact.getcontactId()>
                        <cfif session.intUid eq contact.getuserId()>
                            <tr class="tableRow" id="">
                                <th>Image</th>
                                <th>#contact.getfirstName()# #contact.getlastName()#</th>
                                <th>#contact.getemail()#</th>
                                <th>#contact.getphone()#</th>
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