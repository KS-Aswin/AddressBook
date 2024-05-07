<cfscript>
    variables.strTitle = StructKeyExists(form, "strTitle")?form.title:'';
    variables.strFirstName = StructKeyExists(form, "strFirstName")?form.strFirstName:'';
    variables.strLastName = StructKeyExists(form, "strLastName")?form.strLastName:'';
    variables.strGender = StructKeyExists(form, "strGender")?form.strGender:'';
    variables.strDate = StructKeyExists(form, "strDate")?form.strDate:'';
    variables.strUploadFile = StructKeyExists(form, "strUploadFile")?form.strUploadFile:'';
    variables.strAddress = StructKeyExists(form, "strAddress")?form.strAddress:'';
    variables.strStreet = StructKeyExists(form, "strStreet")?form.strStreet:'';
    variables.intPhoneNumber = StructKeyExists(form, "intPhoneNumber")?form.intPhoneNumber:'';
    variables.strEmailId = StructKeyExists(form, "strEmailId")?form.strEmailId:'';
</cfscript>
