<cfoutput>
<cfif session.login>
    <div class="download d-flex align-items-center justify-content-center mb-4">
        <div class="downloadContainer d-flex align-items-center justify-content-end py-3 gap-4 pe-5">
            <img src="./assets/images/pdf.png" class="downloadIcon" alt="pdf">
            <img src="./assets/images/xl.png" class="downloadIcon" alt="xlsheet">
            <img src="./assets/images/print.png" class="downloadIcon pe-5" alt="print">
        </div>
    </div>
    <div class="d-flex gap-2 align-items-start justify-content-center mb-4 ">    
        <div class="profileUser d-flex flex-column align-items-center justify-content-center p-4 gap-2 me-3">            
            <img src="./assets/images/userProfile.png" class="userProfile " alt="userProfile">
            <h4 class="userName mb-0 ">#session.strfullName#</h4>
            <button type="button" class="createContact m-0" data-bs-toggle="modal" data-bs-target="##myModal">CREATE CONTACT</button>
            <div class="modal bd-example-modal-lg fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="myModal">
                <div class="modal-dialog modal-lg p-1">
                    <div class="modal-content d-flex ps-3 formBorder modalFullBody">
                        <div class="d-flex justify-content-between gap-3 ">
                            <div class="ps-5 py-5 d-flex flex-column justify-content-between formSide gap-3">
                                <div class="d-flex align-items-center justify-content-center addMsgStyle p-2">
                                    <h5 class="mb-0" id="addMsg"><b></b></h5>
                                </div>
                                <div class="createAccount d-flex align-items-center justify-content-center p-2">
                                    <h4 class="mb-0"><b>CREATE ACCOUNT</b></h4>
                                </div>
                                <div class="personalContact">
                                    <h4 class="mb-0">Personal Contact</h4>
                                </div>
                                <form action="" method="post"  enctype="multipart/form-data">
                                    <div class="formData d-flex flex-column gap-4">
                                        <div class="d-flex gap-3">
                                            <div class="d-flex flex-column">
                                                <label for="strTitle">Title*</label>
                                                <div class="dropdown d-flex justify-content-start">
                                                    <select id="strTitle" name ="strTitle" class="form-select form-select-sm">
                                                        <option selected value=""></option>
                                                        <option value="Miss" <cfif variables.strTitle eq "Miss">selected</cfif> >Miss</option>
                                                        <option value="Mister" <cfif variables.strTitle eq "Mister">selected</cfif> >Mister</option>
                                                    </select>
                                                </div> 
                                            </div>
                                            <div class="nameInput d-flex flex-column">                                            
                                                <label for="strFirstName">First Name*</label>
                                                <input type="text" id="strFirstName" name="strFirstName" placeholder="Your First Name" value="#variables.strFirstName#">
                                            </div>
                                            <div class="nameInput d-flex flex-column">                                            
                                                <label for="strLastName">Last Name*</label>
                                                <input type="text" id="strLastName" name="strLastName" placeholder="Your Last Name" value="#variables.strLastName#">
                                            </div>
                                        </div>
                                        <div class="d-flex gap-3">
                                            <div class="d-flex flex-column">
                                                <label for="strGender">Gender*</label>
                                                <div class="dropdown d-flex justify-content-start">
                                                    <select id="strGender" name = "strGender" class="form-select form-select-sm">
                                                        <option selected value=""></option>
                                                        <option value="Male" <cfif variables.strGender eq "Male">selected</cfif> >Male</option>
                                                        <option value="Female" <cfif variables.strGender eq "Female">selected</cfif> >Female</option>
                                                        <option value="Other" <cfif variables.strGender eq "Other">selected</cfif> >Other</option>
                                                    </select>
                                                </div> 
                                            </div>
                                            <div class="d-flex flex-column">                                            
                                                <label for="strDate">Date Of Birth*</label>
                                                <input type="date" id="strDate" name="strDate" value="#variables.strDate#">
                                            </div>
                                        </div>
                                        <div class="d-flex gap-3">
                                            <div class="d-flex flex-column ">                                            
                                                <label class="fs-7" for="strUploadFile">Upload Photo*</label>
                                                <input type="file" id="strUploadFile" name="strUploadFile"  value="#variables.strUploadFile#">
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div class="contactHead ">
                                    <h4 class="mb-0 fs-5 ">Contact Details</h4>
                                </div>
                                <div class="d-flex gap-3">
                                    <div class="addressInput d-flex flex-column">
                                        <label for="strAddress">Address*</label>
                                        <input type="text" id="strAddress" name="strAddress" value="#variables.strAddress#">
                                    </div>
                                    <div class="addressInput d-flex flex-column">
                                        <label for="strStreet">Street*</label>
                                        <input type="text" id="strStreet" name="strStreet" value="#variables.strStreet#">
                                    </div>
                                </div>
                                <div class="d-flex gap-3">
                                    <div class="addressInput d-flex flex-column">
                                        <label for="intPhoneNumber">Phone Number*</label>
                                        <input type="text" id="intPhoneNumber" name="intPhoneNumber" value="#variables.intPhoneNumber#">
                                    </div>
                                    <div class="addressInput d-flex flex-column">
                                        <label for="strEmailId">Email*</label>
                                        <input type="text" id="strEmailId" name="strEmailId" value="#variables.strEmailId#">
                                    </div>
                                </div>
                                <div class="d-flex gap-3">
                                    <div class="addressInput d-flex flex-column">
                                        <label for="intPinCode">Pincode*</label>
                                        <input type="text" id="intPinCode" name="intPinCode" value="#variables.intPinCode#">
                                    </div>
                                </div>
                                <div class="d-flex align-items-center justify-content-start gap-5">
                                    <button type="button" class="createContact closeBtn m-0 me-4" id="formSubmit">SUBMIT</button>
                                    <button type="button" class="createContact closeBtn m-0 ms-5" data-bs-dismiss="modal">CLOSE</button>
                                </div>
                            </div>
                            <div class="modalProfile d-flex align-items-start justify-content-center mt-5 p-5">
                                <img src="./assets/images/modalProfile.png" class="userProfile mt-5" alt="userProfile">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="d-flex displayProfiles">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th><h5><b class="tableHeading"></b></h5></th>
                        <th><h5><b class="tableHeading">NAME</b></h5></th>
                        <th><h5><b class="tableHeading">EMAIL ID</b></h5></th>
                        <th><h5><b class="tableHeading">PHONE NUMBER</b></h5></th>
                        <th><h5><b class="tableHeading"></b></h5></th>
                        <th><h5><b class="tableHeading"></b></h5></th>
                        <th><h5><b class="tableHeading"></b></h5></th>
                    </tr>
                </thead>
                <tbody>
                    <cfset contacts = EntityLoad("ormContactFunction")>
                    <cfloop array="#contacts#" index="contact">
                        <tr class="tableRow" id="">
                            <th>Image</th>
                            <th>#contact.getfirstName()# #contact.getlastName()#</th>
                            <th>#contact.getemail()#</th>
                            <th>#contact.getphone()#</th>
                            <th><button type="button" class="listBtn m-0" data-bs-toggle="modal" data-bs-target="##myModal">EDIT</button></th>
                            <th><button class="listBtn m-0" id=" ">DELETE</button></th>
                            <th>
                                <button type="button" class="listBtn m-0" data-bs-toggle="modal" data-bs-target="##viewAccount">
                                    VIEW
                                </button>
                                <div class="modal bd-example-modal-lg fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="viewAccount">
                                    <div class="modal-dialog modal-lg p-1">
                                        <div class="modal-content d-flex ps-3 formBorder">
                                            <div class="d-flex justify-content-between gap-3">
                                                <div class="ps-5 py-5 d-flex flex-column justify-content-between formSide gap-3">
                                                    <div class="createAccount d-flex align-items-center justify-content-center mb-4 p-2">
                                                        <h4 class="mb-0"><b>CONTACT DETAILS</b></h4>
                                                    </div>
                                                    <div class="viewContactDetails d-flex align-items-center ">
                                                        <div class="d-flex justify-content-between w-50">
                                                            <p class="mb-0">Name</p>
                                                            <p class="mb-0">:</p>
                                                        </div>
                                                        <p class="mb-0"></p>
                                                    </div>
                                                    <div class="viewContactDetails d-flex align-items-center ">
                                                        <div class="d-flex justify-content-between w-50">
                                                            <p class="mb-0">Gender</p>
                                                            <p class="mb-0">:</p>
                                                        </div>
                                                        <p class="mb-0"></p>
                                                    </div>
                                                    <div class="viewContactDetails d-flex align-items-center ">
                                                        <div class="d-flex justify-content-between w-50">
                                                            <p class="mb-0">Date of Birth</p>
                                                            <p class="mb-0">:</p>
                                                        </div>
                                                        <p class="mb-0"></p>
                                                    </div>
                                                    <div class="viewContactDetails d-flex align-items-center ">
                                                        <div class="d-flex justify-content-between w-50">
                                                            <p class="mb-0">Address</p>
                                                            <p class="mb-0">:</p>
                                                        </div>
                                                        <p class="mb-0"></p>
                                                    </div>
                                                    <div class="viewContactDetails d-flex align-items-center ">
                                                        <div class="d-flex justify-content-between w-50">
                                                            <p class="mb-0">Pincode</p>
                                                            <p class="mb-0">:</p>
                                                        </div>
                                                        <p class="mb-0"></p>
                                                    </div>
                                                    <div class="viewContactDetails d-flex align-items-center ">
                                                        <div class="d-flex justify-content-between w-50">
                                                            <p class="mb-0">Email Id</p>
                                                            <p class="mb-0">:</p>
                                                        </div>
                                                        <p class="mb-0"></p>
                                                    </div>
                                                    <div class="viewContactDetails d-flex align-items-center ">
                                                        <div class="d-flex justify-content-between w-50">
                                                            <p class="mb-0">Phone</p>
                                                            <p class="mb-0">:</p>
                                                        </div>
                                                        <p class="mb-0"></p>
                                                    </div>
                                                    <div class="d-flex align-items-center justify-content-center">
                                                        <button type="button" class="createContact closeBtn m-0" data-bs-dismiss="modal">CLOSE</button>
                                                    </div>
                                                </div>
                                                <div class="modalProfile d-flex align-items-center justify-content-center p-5">
                                                    <img src="./assets/images/modalProfile.png" class="userProfile " alt="userProfile">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </th>
                        </tr>
                    </cfloop>
                </tbody>
            </table>
        </div>
    </div>
</cfif>
</cfoutput>