<cfoutput>
    <cfif session.login>
        <div class="download d-flex align-items-center justify-content-center mb-4">
            <div class="downloadContainer d-flex align-items-center justify-content-end py-3 gap-4 pe-5">
                <a href='?action=pdfFile'><img src="./assets/images/pdf.png" class="downloadIcon" id="pdf" alt="pdf"></a>
                 <a href='?action=xlFile'><img src="./assets/images/xl.png" class="downloadIcon" id="xl" alt="xlsheet"></a>
                <img src="./assets/images/print.png" class="downloadIcon pe-5" id="print" alt="print">
            </div>
        </div>
        <div class="d-flex gap-2 align-items-start justify-content-center mb-4 ">
            <div class="profileUser d-flex flex-column align-items-center justify-content-center p-4 gap-2 me-3">
                <img src="./assets/UploadImages/#session.userImg#" id="userIdImg" class="userProfile " alt="userProfile">
                <h4 class="userName mb-0" id="nameSOS"><b>#session.strfullName#</b></h4>
                <button type="button" id="createContactButton" class="createContact m-0" data-bs-toggle="modal" data-bs-target="##myModal">CREATE CONTACT</button>
                <button type="button" id="createExcelContact" class="createExcelContact m-0" data-bs-toggle="modal" data-bs-target="##excelModal">CREATE ACCOUNT USING EXCEL</button>
                <div class="modal bd-example-modal-lg fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="excelModal">
                    <div class="modal-dialog modal-lg p-1">
                        <form action="" method="post" id="myFormExcel" enctype="multipart/form-data">
                            <div class="modal-content d-flex flex-column p-5">
                                <div class="d-flex align-items-center justify-content-center addMsgStyle p-2">
                                    <h6 class="mb-0" id="excelMsg"><b></b></h6>
                                </div>
                                <div class="personalContact">
                                    <h4 class="mb-0">Upload Excel File</h4>
                                </div>
                                <div class="d-flex flex-column mt-3 gap-1">
                                    <div class="d-flex flex-column ">                                            
                                        <label class="fs-7" for="strUploadExleFile">Upload Excel*</label>
                                        <input type="file" id="strUploadExleFile" src="" name="strUploadExleFile" value="" accept=".xlsx,.xls">
                                    </div>
                                    <div class="d-flex mt-3 align-items-center justify-content-start">
                                        <button type="button" class="createContact closeBtn  m-0" id="formExcelSubmit">SUBMIT</button>
                                        <button type="button" class="closeBtn  m-0 ms-1" data-bs-dismiss="modal">CLOSE</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                
                <div class="modal bd-example-modal-lg fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="myModal">
                    <div class="modal-dialog modal-lg p-1">
                        <div class="modal-content d-flex ps-3 formBorder modalFullBody">
                            <div class="d-flex justify-content-between gap-3 ">
                                <div class="ps-5 py-5 d-flex flex-column justify-content-between formSide gap-3">
                                    <div class="d-flex align-items-center justify-content-center addMsgStyle p-2">
                                        <h5 class="mb-0" id="addMsg"><b></b></h5>
                                    </div>
                                    <div class="createAccount d-flex align-items-center justify-content-center p-2">
                                        <h4 class="mb-0" id="heading"><b>CREATE ACCOUNT</b></h4>
                                    </div>
                                    <div class="personalContact">
                                        <h4 class="mb-0">Personal Contact</h4>
                                    </div>
                                    <form action="" method="post" id="myFormValues" enctype="multipart/form-data">
                                        <div class="formData d-flex flex-column gap-4">
                                            <div class="d-flex gap-3">
                                                <div class="d-flex flex-column">
                                                <input type="hidden" name="intContactId" id="intContactId" value="0">
                                                    <label for="strTitle">Title*</label>
                                                    <div class="dropdown d-flex justify-content-start">
                                                        <select id="strTitle" value="" name ="strTitle" class="form-select form-select-sm">
                                                            <option selected value=""></option>
                                                            <option value="Miss">Miss</option>
                                                            <option value="Mr">Mr</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="nameInput d-flex flex-column">                                            
                                                    <label for="strFirstName">First Name*</label>
                                                    <input type="text" id="strFirstName" name="strFirstName" value="" placeholder="Your First Name" >
                                                </div>
                                                <div class="nameInput d-flex flex-column">                                            
                                                    <label for="strLastName">Last Name*</label>
                                                    <input type="text" id="strLastName" name="strLastName" value="" placeholder="Your Last Name">
                                                </div>
                                            </div>
                                            <div class="d-flex gap-3">
                                                <div class="d-flex flex-column">
                                                    <label for="strGender">Gender*</label>
                                                    <div class="dropdown d-flex justify-content-start">
                                                        <select id="strGender" name = "strGender" value="" class="form-select form-select-sm">
                                                            <option selected value=""></option>
                                                            <option value="Male">Male</option>
                                                            <option value="Female">Female</option>
                                                            <option value="Other">Other</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="d-flex flex-column">                                            
                                                    <label for="strDate">Date Of Birth*</label>
                                                    <input type="date" id="strDate" name="strDate" value="">
                                                </div>
                                            </div>
                                            <div class="d-flex gap-3">
                                                <div class="d-flex flex-column ">                                            
                                                    <label class="fs-7" for="strUploadFile">Upload Photo*</label>
                                                    <input type="file" id="strUploadFile" src="" name="strUploadFile" value="" accept=".png,.jpg,.jpeg,.webp,image/png">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="contactHead mt-3">
                                            <h4 class="mb-0 fs-5 ">Contact Details</h4>
                                        </div>
                                        <div class="d-flex mt-3 gap-3">
                                            <div class="addressInput d-flex flex-column">
                                                <label for="strAddress">Address*</label>
                                                <input type="text" id="strAddress" name="strAddress" value="">
                                            </div>
                                            <div class="addressInput d-flex flex-column">
                                                <label for="strStreet">Street*</label>
                                                <input type="text" id="strStreet" name="strStreet" value="">
                                            </div>
                                        </div>
                                        <div class="d-flex mt-3 gap-3">
                                            <div class="addressInput d-flex flex-column">
                                                <label for="intPhoneNumber">Phone Number*</label>
                                                <input type="text" id="intPhoneNumber" name="intPhoneNumber" value="">
                                            </div>
                                            <div class="addressInput d-flex flex-column">
                                                <label for="strEmailId">Email*</label>
                                                <input type="text" id="strEmailId" name="strEmailId" value="">
                                            </div>
                                        </div>
                                        <div class="d-flex mt-3 gap-3">
                                            <div class="addressInput d-flex flex-column">
                                                <label for="intPinCode">Pincode*</label>
                                                <input type="text" id="intPinCode" name="intPinCode" value="">
                                            </div>
                                        </div>
                                        <div class="d-flex mt-3 align-items-center justify-content-start gap-5">
                                            <button type="button" class="createContact closeBtn m-0 me-4" id="formSubmit">SUBMIT</button>
                                            <button type="button" class="createContact closeBtn m-0 ms-5" data-bs-dismiss="modal">CLOSE</button>
                                        </div>
                                    
                                    </form>
                                </div>
                                <div class="modalProfile mt-3 d-flex align-items-start justify-content-center mt-5 p-5">
                                    <img src="./assets/images/modalProfile.png" class="modalImg mt-5" alt="userProfile">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="d-flex displayProfiles" >
                <div class="w-100" id="pdfContent">
                    <table class="table mb-0">
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
                                        <th><img src="./assets/UploadImages/#contact.getphoto()#" alt="Profile" class='userProfilePic'></th>
                                        <th>#contact.getfirstName()# #contact.getlastName()#</th>
                                        <th>#contact.getemail()#</th>
                                        <th>#contact.getphone()#</th>
                                        <th><button type="button" class="listBtn editBtn m-0"  data-id="#variables.contactId#" data-bs-toggle="modal" data-bs-target="##myModal">EDIT</button></th>
                                        <th><button type="button" class="listBtn deleteBtn m-0" data-id="#variables.contactId#">DELETE</button></th>
                                        <th>
                                            <button type="button" class="listBtn viewBtn m-0" data-id="#variables.contactId#" data-bs-toggle="modal" data-bs-target="##viewAccount">VIEW</button>
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
                                                                        <p class="mb-0 me-3">:</p>
                                                                    </div>
                                                                    <p class="mb-0" id="name"></p>
                                                                </div>
                                                                <div class="viewContactDetails d-flex align-items-center ">
                                                                    <div class="d-flex justify-content-between w-50">
                                                                        <p class="mb-0">Gender</p>
                                                                        <p class="mb-0 me-3">:</p>
                                                                    </div>
                                                                    <p class="mb-0" id="gender"></p>
                                                                </div>
                                                                <div class="viewContactDetails d-flex align-items-center ">
                                                                    <div class="d-flex justify-content-between w-50">
                                                                        <p class="mb-0">Date of Birth</p>
                                                                        <p class="mb-0 me-3">:</p>
                                                                    </div>
                                                                    <p class="mb-0" id="dob"></p>
                                                                </div>
                                                                <div class="viewContactDetails d-flex align-items-center ">
                                                                    <div class="d-flex justify-content-between w-50">
                                                                        <p class="mb-0">Address</p>
                                                                        <p class="mb-0 me-3">:</p>
                                                                    </div>
                                                                    <p class="mb-0" id="address"></p>
                                                                </div>
                                                                <div class="viewContactDetails d-flex align-items-center ">
                                                                    <div class="d-flex justify-content-between w-50">
                                                                        <p class="mb-0">Pincode</p>
                                                                        <p class="mb-0 me-3">:</p>
                                                                    </div>
                                                                    <p class="mb-0" id="pincode"></p>
                                                                </div>
                                                                <div class="viewContactDetails d-flex align-items-center ">
                                                                    <div class="d-flex justify-content-between w-50">
                                                                        <p class="mb-0">Email Id</p>
                                                                        <p class="mb-0 me-3">:</p>
                                                                    </div>
                                                                    <p class="mb-0" id="email"></p>
                                                                </div>
                                                                <div class="viewContactDetails d-flex align-items-center ">
                                                                    <div class="d-flex justify-content-between w-50">
                                                                        <p class="mb-0">Phone</p>
                                                                        <p class="mb-0 me-3">:</p>
                                                                    </div>
                                                                    <p class="mb-0" id="phone"></p>
                                                                </div>
                                                                <div class="d-flex align-items-center justify-content-center">
                                                                    <button type="button" class="createContact closeBtn m-0" data-bs-dismiss="modal">CLOSE</button>
                                                                </div>
                                                            </div>
                                                            <div class="modalProfile d-flex align-items-center justify-content-center p-5">
                                                                <img src="./assets/images/modalProfile.png" class="modalImg " alt="userProfile">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </th>
                                    </tr>
                                <cfelse>
                                    <cfcontinue>
                                </cfif>
                            </cfloop>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </cfif>
    </body>
    </html>
</cfoutput>