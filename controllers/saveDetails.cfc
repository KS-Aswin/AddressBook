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
        local.objUser = createObject("component","models.saveDetails");
        local.checkUserDetails = local.objUser.checkUserExists(userName = userName);
        if(local.checkUserDetails.success){     
            local.password = Hash(password,"MD5");
            local.saveUserDetails = local.objUser.saveSignUp(fullName = fullName,img = img,email = email,userName = userName,password = local.password);
            if(local.saveUserDetails.success){
                return {"success":true,"msg":"New User added Successfully"};  
            }else{
                return {"success":false,"msg":"Something went wrong!"};
            }
        }else{
            return {"success":false,"msg":"Username already existing"};
        }
    }
    remote any function contactDetails(intContactId,strTitle,strFirstName,strLastName,strGender,strDate,filePhoto,strAddress,strStreet,intPhoneNumber,strEmailId,intPinCode) returnFormat="JSON"{
        local.objContact = createObject("component","models.saveDetails");
        local.checkContactDetails = local.objContact.checkContactExists(strEmailId = strEmailId,intContactId = intContactId);
        if(local.checkContactDetails.recordCount){   
            return {"result":"exist"};
        }else{  
            local.saveContactDetails = local.objContact.saveContact(intContactId = intContactId, strTitle = strTitle,strFirstName = strFirstName,strLastName = strLastName,strGender = strGender,strDate = strDate,filePhoto = filePhoto,strAddress = strAddress,strStreet = strStreet,intPhoneNumber = intPhoneNumber,strEmailId = strEmailId,intPinCode = intPinCode );
            if(local.saveContactDetails.success == "edited"){
                return {"result":"edited"};  
            }else{
                return {"result":"added"};
            }
        }
    }  
    public void function checkLogin(){
        if(session.login){
           cflocation(url="./?action=list");
        }
    }

    remote any function doLogOut(){
        session.login=false;
        cflocation(url="../?action=login");
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