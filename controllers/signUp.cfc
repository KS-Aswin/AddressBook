component{
    remote any function saveSignUp(fullName,email,userName,password,confirmPassword) returnFormat="JSON"{
        local.objUser = createObject("component","models.signUp");
        local.checkUserDetails = local.objUser.checkUserExists(userName=userName);
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
}  