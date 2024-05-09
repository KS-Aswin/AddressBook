<cfscript>
    variables.contactId = 0;
    variables.strTitle = '';
    variables.strFirstName = '';
    variables.strLastName = '';
    variables.strGender = '';
    variables.strAddress = '';
    variables.strStreet = '';
    variables.dateDOB = '';
    variables.strUploadFile = '';
    variables.intPhoneNumber = '';
    variables.strEmailId = '';
    variables.intPinCode = '';

    if (structKeyExists(url,"intContactId")){
        variables.objContactDetails = createObject("component","models.saveDetails").getContactDetails(intContactId = url.intContactId);
        variables.strTitle=variables.objContactDetails.title;
        variables.strFirstName=variables.objContactDetails.firstName;
        variables.strLastName=variables.objContactDetails.lastName;
        variables.strGender=variables.objContactDetails.gender;
        variables.dateDOB=variables.objContactDetails.dob;
        variables.strAddress=variables.objContactDetails.address;
        variables.strStreet=variables.objContactDetails.street;
        variables.intPhoneNumber=variables.objContactDetails.email ;
        variables.strEmailId=variables.objContactDetails.phone;
        variables.intPinCode=variables.objContactDetails.pincode;
    }
    variables.strHeading=structKeyExists(variables,"intContactId") AND variables.intContactId GT 0 ?"EDIT CONTACT":"CREATE CONTACT";

</cfscript>
