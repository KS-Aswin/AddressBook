component{
    remote any function doLogin(userName,password) returnFormat="JSON" {
        local.objUser = createObject("component","models.saveDetails");
        local.error='';
        if(trim(len(userName)) EQ 0 || trim(len(password)) EQ 0){
            local.error='Please fill all fields';
        }
        if(len(local.error) EQ 0){
            local.password=Hash(arguments.password,"MD5");
            local.checkUser=local.objUser.doLogin(userName=userName,password=password);
            if (local.checkUser.recordCount) {
                session.login = true;
                session.sso = false;
                session.strfullName=local.checkUser.fullName;
                session.userImg=local.checkUser.img;
                session.intUid=local.checkUser.id;
                return { "success": true };
            } 
            else {
                return { "success": false };
            }
        }
        else{
            return {"success":false,"msg":"#local.error#"};
        }
    } 

    remote any function saveSignUp(fullName,img,email,userName,password) returnFormat="JSON"{
        local.errorMsg = ''; 
        if(len(trim(fullName)) EQ 0 OR len(trim(img)) EQ 0 OR len(trim(email)) EQ 0 OR len(trim(userName)) EQ 0 OR password EQ 0){
            local.errorMsg &= "Please enter values in all fields"&"<br>";
        }
        if(REFind('\d', fullName)){
            local.errorMsg &= "Fullname must contain string value only"&"<br>";
        }
        if (isNumeric(userName)){
            local.error &="User Name must contain String values"&"<br>";
        } 
        if(local.errorMsg EQ ''){
            local.objUser = createObject("component","models.saveDetails");
            local.checkUserDetails = local.objUser.checkUserExists(email = email);
            if(local.checkUserDetails.success){     
                local.password = Hash(password,"MD5");
                local.saveUserDetails = local.objUser.saveSignUp(fullName = fullName,img = img,email = email,userName = userName,password = local.password);
                if(local.saveUserDetails.success){
                    return {"success":true,"msg":"New User added Successfully"};  
                }else{
                    return {"success":false,"msg":"Something went wrong!"};
                }
            }else{
                return {"success":false,"msg":"User with same Email Id already existing"};
            }
        }else{
            return {"success":false,"msg":"#local.errorMsg#"}
        }
    }

    remote any function doLoginSOS(email,fullName,img) returnFormat="JSON" {
        local.objUser = createObject("component","models.saveDetails");
        local.checkUser=local.objUser.doLoginSOS(email=email);
        if (local.checkUser.recordCount) {
            session.login = true;
            session.sso = true;
            session.strfullName=local.checkUser.fullName;
            session.ssoImg = local.checkUser.img;
            session.intUid=local.checkUser.id;
            return { "success": true };
        } 
        else {
            local.saveSOS=local.objUser.saveSOS(email=email,fullName=fullName,img=img);
            if(local.saveSOS.success){
                local.checkUserSave=local.objUser.doLoginSOS(email=email);
                if (local.checkUserSave.recordCount) {
                    session.login = true;
                    session.sso = true;
                    session.strfullName=local.checkUserSave.fullName;
                    session.ssoImg = local.checkUserSave.img;
                    session.intUid=local.checkUserSave.id;
                }
                return {"success":true};  
            }
        }
    } 

    remote any function contactDetails(intContactId,strTitle,strFirstName,strLastName,strGender,strDate,filePhoto,strAddress,strStreet,intPhoneNumber,strEmailId,intPinCode) returnFormat="JSON"{
        local.objContact = createObject("component","models.saveDetails");
        local.checkContactDetails = local.objContact.checkContactExists(strEmailId = strEmailId,intContactId = intContactId);
        if(local.checkContactDetails.recordCount){  
            return {"result":"exist"};
        }else{ 
            local.checkUserEmail = local.objContact.checkContactEmail(strEmailId = strEmailId);  
            if(local.checkUserEmail.recordCount){
                return {"result":"email"};
            }else{
                local.saveContactDetails = local.objContact.saveContact(intContactId = intContactId, strTitle = strTitle,strFirstName = strFirstName,strLastName = strLastName,strGender = strGender,strDate = strDate,filePhoto = filePhoto,strAddress = strAddress,strStreet = strStreet,intPhoneNumber = intPhoneNumber,strEmailId = strEmailId,intPinCode = intPinCode );
                if(local.saveContactDetails.success == "edited"){
                    return {"result":"edited"};  
                }else{
                    return {"result":"added"};
                }
            }    
        }
    } 

    remote any function excelDetails(excelFile) returnFormat="JSON"{
        local.objExcel = createObject("component","models.saveDetails");
        local.checkExcelDetails = local.objExcel.checkExcelContactExists(excelFile = excelFile);
        if(local.checkExcelDetails.success == "added"){  
            return {"result":"added"};
        }else if(local.checkExcelDetails.success == "exist"){
            return {"result":"exist"};
        }
    } 

    public void function checkLogin(){
        if(session.login){
           cflocation(url="./views/listPage.cfm");
        }
    }

    remote any function doLogOut(){
        session.login=false;
        session.userImg = "";
		session.ssoImg = "";
        session.sso = false;
        cflocation(url="../index.cfm");
    }

    remote any function generatePDFFromTable(tableHTML) returnFormat="JSON" {
        if (len(trim(tableHTML)) neq 0) {
            local.saveDirectory = expandPath("../assets/downloadedFiles/"); 
            if (!directoryExists(local.saveDirectory)) {
                directoryCreate(local.saveDirectory);
            }
            local.pdfFileName = "tableOutput.pdf";
            local.pdfFilePath = local.saveDirectory & local.pdfFileName;
            cfdocument(format="pdf", name=local.pdfFilePath) {
                writeOutput(tableHTML);
            }
            return { "success": true, "pdfPath": "pdfFiles/#pdfFileName#" };
        } else {
            return { "success": false, "msg": "Table HTML content is empty." };
        }
    }   
}  