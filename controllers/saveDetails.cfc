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
    remote any function saveSignUp(fullName,email,userName,password) returnFormat="JSON"{
        local.objUser = createObject("component","models.saveDetails");
        local.checkUserDetails = local.objUser.checkUserExists(userName = userName);
        if(local.checkUserDetails.success){     
            local.password = Hash(password,"MD5");
            local.saveUserDetails = local.objUser.saveSignUp(fullName = fullName,email = email,userName = userName,password = local.password);
            if(local.saveUserDetails.success){
                return {"success":true,"msg":"New User added Successfully"};  
            }else{
                return {"success":false,"msg":"Something went wrong!"};
            }
        }else{
            return {"success":false,"msg":"Username already existing"};
        }
    }
    remote any function contactDetails(strTitle,strFirstName,strLastName,strGender,strDate,strAddress,strStreet,intPhoneNumber,strEmailId,intPinCode) returnFormat="JSON"{
        local.objContact = createObject("component","models.saveDetails");
        local.checkContactDetails = local.objContact.checkContactExists(strEmailId = strEmailId);
        if(local.checkContactDetails.recordCount){   
            session.contactId=local.checkContactDetails.contactId;
            return {"success":false,"msg":"Contact with same email id already existing"};
        }else{  
            local.saveContactDetails = local.objContact.saveContact(strTitle = strTitle,strFirstName = strFirstName,strLastName = strLastName,strGender = strGender,strDate = strDate,strAddress = strAddress,strStreet = strStreet,intPhoneNumber = intPhoneNumber,strEmailId = strEmailId,intPinCode = intPinCode );
            if(local.saveContactDetails.recordCount){
                session.contactId=local.saveContactDetails.contactId;
                return {"success":true,"msg":"New Contact added Successfully"};  
            }else{
                return {"success":false,"msg":"Something went wrong!"};
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
}  