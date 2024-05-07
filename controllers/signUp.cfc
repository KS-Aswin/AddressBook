component{
    remote any function doLogin(userName,password) returnFormat="JSON" {
        local.objUser = createObject("component","models.signUp");
        local.error='';
        if(trim(len(userName)) EQ 0 || trim(len(password)) EQ 0){
            local.error='Please fill all fields';
            writeOutput(local.error)abort;
        }
        if(len(local.error) EQ 0){
            local.password=Hash(arguments.password,"MD5");
            local.checkUser=local.objUser.doLogin(userName=userName,password=password);
            if (local.checkUser.recordCount) {
                session.login = true;
                session.strfullName=local.checkUser.fullName;
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
        local.objUser = createObject("component","models.signUp");
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