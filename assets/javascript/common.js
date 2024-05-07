$(document).ready(function () {
    $('#logInBtn').click(function() {
        $("#loginMsg").text("");
        var errorMsg = "";
        var userName = $('#strUserName').val().trim(); 
        var password = $('#strPassword').val().trim();
        if (userName == ''|| password =='' ){ 
            errorMsg += "Please enter values in all fields!";
        }
        if (errorMsg !=='') {
            $("#loginMsg").html(errorMsg).css('color','red');
            return false;
        }
        $.ajax({
            url: './controllers/signUp.cfc?method=doLogin',
            type: 'post',
            data:  {
                userName: userName,
                password: password
            },
            dataType:"json",
            success: function(response) {
                if (response.success){
                    $("#loginMsg").text('Login Successfull').css("color", "green");
                    setTimeout(function() {
                        window.location.href="?action=list";
                    },1000);
                } else {
                    $("#loginMsg").text('Invalid user name or password!').css("color", "red");
                }
            },
        });
        return false;
    })
    $('#signUpBtn').click(function() {
        var fullName = $('#strFullname').val().trim();
        var email = $('#strEmail').val().trim();
        var userName = $('#strUsername').val().trim();
        var password = $('#strPassword').val().trim();
        var confirmPassword = $('#strConfirmPassword').val().trim();
        $("#signUpMsg").html('');
        if (validation()) {
            $.ajax({
                url: './controllers/signUp.cfc?method=saveSignUp',
                type: 'post',
                data: {
                    fullName: fullName,
                    email: email,
                    userName: userName,
                    password: password,
                },
                dataType: "json",
                success: function (response) {
                    if (response.success) {
                        $("#signUpMsg").html(response.msg).css('color','green');
                        setTimeout(function() {
                            window.location.href="?action=login";
                        },1000);
                    } else {
                        $("#signUpMsg").html(response.msg).css('color','red');
                    }
                },
                error: function (xhr, status, error) {
                    alert("An error occurred: " + error);
                }
            });
        }
        return false;
    });
    $('#formSubmit').click(function() {
        var strTitle = $('#strTitle').val().trim();
        var strFirstName = $('#strFirstName').val().trim();
        var strLastName = $('#strLastName').val().trim();
        var strGender = $('#strGender').val().trim();
        var strDate = $('#strDate').val().trim();
        var strUploadFile = $('#strUploadFile').val().trim();
        var strAddress = $('#strAddress').val().trim();
        var strStreet = $('#strStreet').val().trim();
        var intPhoneNumber = $('#intPhoneNumber').val().trim();
        var strEmailId = $('#strEmailId').val().trim();
        if (contactValidation()) {
            $.ajax({
                url: './controllers/signUp.cfc?method=saveSignUp',
                type: 'post',
                data: {
                    fullName: fullName,
                    email: email,
                    userName: userName,
                    password: password,
                },
                dataType: "json",
                success: function (response) {
                    if (response.success) {
                        $("#signUpMsg").html(response.msg).css('color','green');
                        setTimeout(function() {
                            window.location.href="?action=login";
                        },1000);
                    } else {
                        $("#signUpMsg").html(response.msg).css('color','red');
                    }
                },
                error: function (xhr, status, error) {
                    alert("An error occurred: " + error);
                }
            });
        }
        return false;
    });
});
function validation() {
    var fullName = $('#strFullname').val().trim();
    var email = $('#strEmail').val().trim();
    var userName = $('#strUsername').val().trim();
    var password = $('#strPassword').val().trim();
    var confirmPassword = $('#strConfirmPassword').val().trim();
    var specialChar = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;
    var alphabets = /[A-z]/g;
    var number = /[0-9]/g;
    var emailRegex=/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    var specialCharName = specialChar.test(fullName);
    var numberName = number.test(fullName);
    var specialCharUser = specialChar.test(userName);
    var numberUser = number.test(userName);
    var errorMsg = "";
    $("#signUpMsg").text(""); 
    if (fullName == "" || email == "" || userName == "" || password == "") {
        errorMsg += "Please enter values in all fields!";
    } 
    if((specialCharName) || (numberName)){
        errorMsg+="Fullname must contain String values only!"; 
    }  
    if (!email.match(emailRegex)){
        errorMsg+="Enter a valid email address!";
    }  
    if ((specialCharUser) || (numberUser)){
        errorMsg+="Username must contain String values only!"; 
    }
    if(password!=''){
        var specialChar = specialChar.test(password);
        var  alphabets= alphabets.test(password);
        var number = number.test(password);
        if(!((specialChar) && (alphabets) && (number))){
            errorMsg+="Password should contain all type values!";
        }        
    }
    if(confirmPassword != password){
        errorMsg+="Password and Confirm Password does not match!";
        alert(errorMsg);
    }
    if (errorMsg !=='') {
        $("#signUpMsg").html(errorMsg).css('color','red');
        return false;
    }
    return true;
}
function contactValidation() {
    var strTitle = $('#strTitle').val().trim();
    var strFirstName = $('#strFirstName').val().trim();
    var strLastName = $('#strLastName').val().trim();
    var strGender = $('#strGender').val().trim();
    var strDate = $('#strDate').val().trim();
    var strUploadFile = $('#strUploadFile').val().trim();
    var strAddress = $('#strAddress').val().trim();
    var strStreet = $('#strStreet').val().trim();
    var intPhoneNumber = $('#intPhoneNumber').val().trim();
    var strEmailId = $('#strEmailId').val().trim();
    var specialChar = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;
    var alphabets = /[A-z]/g;
    var number = /[0-9]/g;
    var emailRegex=/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    var specialCharFirstName = specialChar.test(strFirstName);
    var numberFirstName = number.test(strFirstName);
    var specialCharLastName = specialChar.test(strLastName);
    var numberLastName = number.test(strLastName);
    var alphabetDate = alphabets.test(strDate);
    var specialCharPhone = specialChar.test(intPhoneNumber);
    var alphabetPhone = alphabets.test(intPhoneNumber);

    var errorMsg = "";
    $(errorMsg).text("");
    if (strTitle == "" || strFirstName == "" || strLastName == "" || strGender == "" || strDate == "" || strUploadFile == "" || strAddress == "" || strStreet == "" || intPhoneNumber == "" || strEmailId == "") {
        errorMsg += "Please enter values in all fields!"; 
    }else  if((specialCharFirstName) || (numberFirstName)){
        errorMsg+="Firstname must contain String values only!"; 
    } else if((specialCharLastName) || (numberLastName)){
        errorMsg+="Lastname must contain String values only!"; 
    } else  if((alphabetDate)){
        errorMsg+="Date must not contain String values!"; 
    }else if(strAddress!=''){
        var  alphabets= alphabets.test(strAddress);
        if(!(alphabets)){
            errorMsg+="Address should contain String values!";
        }        
    }else if(strStreet!=''){
        var  alphabets= alphabets.test(strStreet);
        if(!(alphabets)){
            errorMsg+="Street should contain String values!";
        }        
    } else if((specialCharPhone) || (alphabetPhone)){
        errorMsg+="Phone Number must contain Integer values only!"; 
    }else if (!strEmailId.match(emailRegex)){
        errorMsg+="Enter a valid email address!";
    } 

    if (errorMsg !=='') {
        alert(errorMsg);
        return;
        $("#addMsg").html(errorMsg).css('color','red');
        return false;
    }
    alert("success");
    return;
    return true;
}