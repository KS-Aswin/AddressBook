<cfoutput>
<cfinclude  template="../controllers/listPageAction.cfm">
<cfinclude  template="./header.cfm">
<cfinclude  template="./pageNav.cfm">
    <cfif session.login>
        <div class="download d-flex align-items-center justify-content-center mb-4">
            <div class="downloadContainer d-flex align-items-center justify-content-end py-3 gap-4 pe-5">
                <a href='pdfFile.cfm'><img src="../assets/images/pdf.png" class="downloadIcon" id="pdf" alt="pdf"></a>
                 <a href='xlFile.cfm'><img src="../assets/images/xl.png" class="downloadIcon" id="xl" alt="xlsheet"></a>
                <img src="../assets/images/print.png" class="downloadIcon pe-5" id="print" alt="print">
            </div>
        </div>
        <div class="d-flex gap-2 align-items-start justify-content-center mb-4 ">
            <div class="profileUser d-flex flex-column align-items-center justify-content-center p-4 gap-2 me-3">
                <img src="#variables.img#" alt="userProfile" class="userProfile">
                <h4 class="userName mb-0" id="nameSOS"><b>#session.strfullName#</b></h4>
                <button type="button" id="createContactButton" class="createContact m-0 " data-bs-toggle="modal" data-bs-target="##myModal">CREATE CONTACT</button>
                <button type="button" class="createExcelContact m-0  " data-bs-toggle="modal" data-bs-target="##excelModal">CREATE ACCOUNT USING EXCEL</button>
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
                                        <button type="button" class=" excelBtn closeBtn excelSubmit m-0" id="formExcelSubmit">SUBMIT</button>
                                        <button type="button" class="closeBtn excelBtn  ms-1" id="formExcelClose" data-bs-dismiss="modal">CLOSE</button>
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
                                                    <label for="strTitle" id="formTitle">Title*</label>
                                                    <div class="dropdown d-flex justify-content-start">
                                                        <select id="strTitle" value="" name ="strTitle" class="form-select form-select-sm">
                                                            <option selected value=""></option>
                                                            <option value="Miss">Miss</option>
                                                            <option value="Mr">Mr</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="nameInput d-flex flex-column">                                            
                                                    <label for="strFirstName" id="formFirstname">First Name*</label>
                                                    <input type="text" id="strFirstName" name="strFirstName" value="" placeholder="Your First Name" >
                                                </div>
                                                <div class="nameInput d-flex flex-column">                                            
                                                    <label for="strLastName" id="formLastname">Last Name*</label>
                                                    <input type="text" id="strLastName" name="strLastName" value="" placeholder="Your Last Name">
                                                </div>
                                            </div>
                                            <div class="d-flex gap-3">
                                                <div class="d-flex flex-column">
                                                    <label for="strGender" id="formGender">Gender*</label>
                                                    <div class="dropdown d-flex justify-content-start">
                                                        <select id="strGender" name = "strGender" value="" class="form-select form-select-sm">
                                                            <option selected value=""></option>
                                                            <option value="Male">Male</option>
                                                            <option value="Female">Female</option>
                                                            <option value="Other">Other</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="nameInput d-flex flex-column">                                            
                                                    <label for="strDate" id="formDate">Date Of Birth*</label>
                                                    <input type="text" id="strDate" name="strDate" value="">
                                                </div>
                                            </div>
                                            <div class="d-flex gap-3">
                                                <div class="d-flex flex-column ">                                            
                                                    <label class="fs-7" for="strUploadFile" id="formPhoto">Upload Photo*</label>
                                                    <input type="file" id="strUploadFile" src="" name="strUploadFile" value="" accept=".png,.jpg,.jpeg,.webp,image/png">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="contactHead mt-3">
                                            <h4 class="mb-0 fs-5 ">Contact Details</h4>
                                        </div>
                                        <div class="d-flex mt-3 gap-3">
                                            <div class="addressInput d-flex flex-column">
                                                <label for="strAddress" id="formAddress">Address*</label>
                                                <input type="text" id="strAddress" name="strAddress" value="">
                                            </div>
                                            <div class="addressInput d-flex flex-column">
                                                <label for="strStreet" id="formStreet">Street*</label>
                                                <input type="text" id="strStreet" name="strStreet" value="">
                                            </div>
                                        </div>
                                        <div class="d-flex mt-3 gap-3">
                                            <div class="addressInput d-flex flex-column">
                                                <label for="intPhoneNumber" id="formPhone">Phone Number*</label>
                                                <input type="text" id="intPhoneNumber" name="intPhoneNumber" value="">
                                            </div>
                                            <div class="addressInput d-flex flex-column">
                                                <label for="strEmailId" id="formEmail">Email*</label>
                                                <input type="text" id="strEmailId" name="strEmailId" value="">
                                            </div>
                                        </div>
                                        <div class="d-flex mt-3 gap-3">
                                            <div class="addressInput d-flex flex-column">
                                                <label for="intPinCode" id="formPincode">Pincode*</label>
                                                <input type="text" id="intPinCode" name="intPinCode" value="">
                                            </div>
                                        </div>
                                        <div class="d-flex mt-3 gap-3">
                                            <div class="addressInput d-flex flex-column">
                                                <label for="hobbies" id="formFobbies">Hobbies</label>
                                                <div class="d-flex gap-2">
                                                    <div class="d-flex flex-column justify-content-between mt-2">
                                                        <div class="d-flex gap-2 align-items-center">
                                                            <input class='checkBox' type="checkbox" id="Film" name="Film" value="Film">
                                                            <label for="Film">Films</label>
                                                        </div> 
                                                        <div class="d-flex gap-2 align-items-center">
                                                            <input class='checkBox' type="checkbox" id="Drawing" name="Drawing" value="Drawing">
                                                            <label for="Drawing">Drawing</label>
                                                        </div> 
                                                        <div class="d-flex gap-2 align-items-center">
                                                            <input class='checkBox' type="checkbox" id="Singing" name="Singing" value="Singing">
                                                            <label for="Singing">Singing</label>
                                                        </div> 
                                                        <div class="d-flex gap-2 align-items-center">
                                                            <input class='checkBox' type="checkbox" id="Reading" name="Reading" value="Reading">
                                                            <label for="Reading">Reading</label>
                                                        </div> 
                                                        <div class="d-flex gap-2 align-items-center">
                                                            <input class='checkBox' type="checkbox" id="Writing" name="Writing" value="Writing">
                                                            <label for="Writing">Writing</label>
                                                        </div>                                  
                                                    </div>
                                                    <div class="d-flex flex-column justify-content-between mt-2">
                                                        <div class="d-flex gap-2 align-items-center">
                                                            <input class='checkBox' type="checkbox" id="Cricket" name="Cricket" value="Cricket">
                                                            <label for="Cricket">Cricket</label>
                                                        </div> 
                                                        <div class="d-flex gap-2 align-items-center">
                                                            <input class='checkBox' type="checkbox" id="Football" name="Football" value="Football">
                                                            <label for="Football">Football</label>
                                                        </div> 
                                                        <div class="d-flex gap-2 align-items-center">
                                                            <input class='checkBox' type="checkbox" id="Travelling" name="Travelling" value="Travelling">
                                                            <label for="Travelling">Travelling</label>
                                                        </div> 
                                                        <div class="d-flex gap-2 align-items-center">
                                                            <input class='checkBox' type="checkbox" id="Gym" name="Gym" value="Gym">
                                                            <label for="Gym">Gym</label>
                                                        </div> 
                                                        <div class="d-flex gap-2 align-items-center">
                                                            <input class='checkBox' type="checkbox" id="Cooking" name="Cooking" value="Cooking">
                                                            <label for="Cooking">Cooking</label>
                                                        </div>                                  
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex mt-3 align-items-start justify-content-start gap-5">
                                            <button type="button" class="createContact closeBtn py-2 m-0 mt-2 me-5" id="formSubmit">SUBMIT</button>
                                            <button type="button" class="createContact closeBtn py-2 m-0 mt-2 " id="formClose" data-bs-dismiss="modal">CLOSE</button>
                                        </div>
                                    </form>
                                     <div class="d-flex align-items-center justify-content-center addMsFgStyle p-2">
                                        <h5 class="mb-0" id="addMsg"><b></b></h5>
                                    </div>
                                </div>
                                <div class="modalProfile mt-3 d-flex align-items-start justify-content-center mt-5 p-5">
                                    <img src="../assets/images/modalProfile.png" class="modalImg mt-5" alt="userProfile">
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
                                    <h5><b class="tableHeading ">NAME</b></h5>
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
                                        <th><img src="../assets/UploadImages/#contact.getphoto()#" alt="Profile" class='userProfilePic'></th>
                                        <th>#contact.getfirstName()# #contact.getlastName()#</th>
                                        <th>#contact.getemail()#</th>
                                        <th>#contact.getphone()#</th>
                                        <th><button type="button" class="listBtn tableBtn editBtn m-0"  data-id="#variables.contactId#" data-bs-toggle="modal" data-bs-target="##myModal">EDIT</button></th>
                                        <th><button type="button" class="listBtn tableBtn deleteBtn m-0" data-id="#variables.contactId#">DELETE</button></th>
                                        <th>
                                            <button type="button" class="listBtn tableBtn viewBtn m-0" data-id="#variables.contactId#" data-bs-toggle="modal" data-bs-target="##viewAccount">VIEW</button>
                                            <div class="modal bd-example-modal-lg fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="viewAccount">
                                                <div class="modal-dialog modal-lg p-1">
                                                    <div class="modal-content d-flex ps-3 formBorder">
                                                        <div class="d-flex justify-content-between gap-3">
                                                            <div class="ps-5 py-5 pb-4 d-flex flex-column justify-content-start formSide gap-1">
                                                                <div class="createAccount d-flex align-items-center justify-content-center mb-4 p-2">
                                                                    <h4 class="mb-0"><b>CONTACT DETAILS</b></h4>
                                                                </div>
                                                                <div class="viewContactDetails d-flex align-items-center ">
                                                                    <div class="d-flex justify-content-between col-6">
                                                                        <p class="mb-0">Name</p>
                                                                        <p class="mb-0 me-3">:</p>
                                                                    </div>
                                                                    <p class="mb-0 col-10" id="name"></p>
                                                                </div>
                                                                <div class="viewContactDetails d-flex align-items-center ">
                                                                    <div class="d-flex justify-content-between col-6">
                                                                        <p class="mb-0">Gender</p>
                                                                        <p class="mb-0 me-3">:</p>
                                                                    </div>
                                                                    <p class="mb-0 col-10" id="gender"></p>
                                                                </div>
                                                                <div class="viewContactDetails d-flex align-items-center ">
                                                                    <div class="d-flex justify-content-between col-6">
                                                                        <p class="mb-0">Date of Birth</p>
                                                                        <p class="mb-0 me-3">:</p>
                                                                    </div>
                                                                    <p class="mb-0 col-10" id="dob"></p>
                                                                </div>
                                                                <div class="viewContactDetails d-flex align-items-center ">
                                                                    <div class="d-flex justify-content-between col-6">
                                                                        <p class="mb-0">Address</p>
                                                                        <p class="mb-0 me-3">:</p>
                                                                    </div>
                                                                    <p class="mb-0 col-10" id="address"></p>
                                                                </div>
                                                                <div class="viewContactDetails d-flex align-items-center ">
                                                                    <div class="d-flex justify-content-between col-6">
                                                                        <p class="mb-0">Pincode</p>
                                                                        <p class="mb-0 me-3">:</p>
                                                                    </div>
                                                                    <p class="mb-0 col-10" id="pincode"></p>
                                                                </div>
                                                                <div class="viewContactDetails d-flex align-items-center ">
                                                                    <div class="d-flex justify-content-between col-6">
                                                                        <p class="mb-0">Email Id</p>
                                                                        <p class="mb-0 me-3">:</p>
                                                                    </div>
                                                                    <p class="mb-0 col-10" id="email"></p>
                                                                </div>
                                                                <div class="viewContactDetails d-flex align-items-center ">
                                                                    <div class="d-flex justify-content-between col-6">
                                                                        <p class="mb-0">Phone</p>
                                                                        <p class="mb-0 me-3">:</p>
                                                                    </div>
                                                                    <p class="mb-0 col-10" id="phone"></p>
                                                                </div>
                                                                <div class="viewContactDetails d-flex align-items-center ">
                                                                    <div class="d-flex justify-content-between col-6">
                                                                        <p class="mb-0">Hobbies</p>
                                                                        <p class="mb-0 me-3">:</p>
                                                                    </div>
                                                                    <p class="mb-0 col-10" id="hobbie"></p>
                                                                </div>
                                                                <div class="d-flex align-items-center justify-content-center">
                                                                    <button type="button" class="createContact closeBtn m-0 mt-2" data-bs-dismiss="modal">CLOSE</button>
                                                                </div>
                                                            </div>
                                                            <div class="modalProfile d-flex align-items-center justify-content-center p-5">
                                                                <img src="../assets/images/modalProfile.png" class="modalImg " alt="userProfile">
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
    <cfelse>
        <cflocation  url="../index.cfm">
    </cfif>
    </body>
    </html>
</cfoutput>