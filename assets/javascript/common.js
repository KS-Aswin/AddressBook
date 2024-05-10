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
            url: './controllers/saveDetails.cfc?method=doLogin',
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
        var img = $('#imgFile').val().trim();
        var email = $('#strEmail').val().trim();
        var userName = $('#strUsername').val().trim();
        var password = $('#strPassword').val().trim();
        var confirmPassword = $('#strConfirmPassword').val().trim();
        $("#signUpMsg").html('');
        if (validation()) {
            $.ajax({
                url: './controllers/saveDetails.cfc?method=saveSignUp',
                type: 'post',
                data: {
                    fullName: fullName,
                    img: img,
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
        //var strUploadFile = $('#strUploadFile').val().trim();
        var strAddress = $('#strAddress').val().trim();
        var strStreet = $('#strStreet').val().trim();
        var intPhoneNumber = $('#intPhoneNumber').val().trim();
        var strEmailId = $('#strEmailId').val().trim();
        var intPinCode = $('#intPinCode').val().trim();
        $("#addMsg").html('');
        if (contactValidation()) {
            $.ajax({
                url: './controllers/saveDetails.cfc?method=contactDetails',
                type: 'post',
                data: {
                    strTitle: strTitle,
                    strFirstName: strFirstName,
                    strLastName: strLastName,
                    strGender: strGender,
                    strDate: strDate,
                    //strUploadFile: strUploadFile,
                    strAddress: strAddress,
                    strStreet: strStreet,
                    intPhoneNumber: intPhoneNumber,
                    strEmailId: strEmailId,
                    intPinCode: intPinCode
                },
                dataType: "json",
                success: function (response) {
                    if (response.success) {
                        $("#addMsg").html(response.msg).css('color','green');
                        setTimeout(function() {
                            window.location.href="?action=list";
                        },1000);
                    } else {
                        $("#addMsg").html(response.msg).css('color','red');
                    }
                },
                error: function (xhr, status, error) {
                    alert("An error occurred: " + error);
                }
            });
        }
        return false;
    });
    
    $('.viewBtn').click(function() {
        var intContactId =$(this).attr("data-id"); 
        $.ajax({
            type: "POST",
            url: "./models/saveDetails.cfc?method=getContactDetails",
            data: {
                intContactId: intContactId
            },
            dataType: "json",
            success: function(response) {
                if(response.success){
                    $('#name').html(response.name);
                    $('#gender').html(response.gender);
                    $('#dob').html(response.dob);
                    $('#address').html(response.address);
                    $('#pincode').html(response.pincode);
                    $('#email').html(response.email);
                    $('#phone').html(response.phone);
                }
                
            },
            error: function(xhr, textStatus, error) {
                console.error("Error:", error);
            }
        });
    }); 
    $("#createContactButton").click(function() { 
        $("#myFormValues")[0].reset();
        $('#heading').html("CREATE CONTACT");
        $('#formSubmit').html("CREATE");
    }); 
    $('.editBtn').click(function() {
        var intContactId =$(this).attr("data-id"); 
        if(intContactId > 0){
            $.ajax({
                type: "POST",
                url: "./models/saveDetails.cfc?method=getEditContactDetails",
                data: {
                    intContactId: intContactId
                },
                dataType: "json",
                success: function(response) {
                    if(response.success){
                        $('#strTitle').prop("value", response.title); 
                        $('#strFirstName').prop("value",response.firstName);
                        $('#strLastName').prop("value",response.lastName);
                        $('#strGender').prop("value",response.gender);
                        $('#strDate').prop("value",response.dob);
                        $('#strAddress').prop("value",response.address);
                        $('#strStreet').prop("value",response.street);
                        $('#intPhoneNumber').prop("value",response.phone);
                        $('#strEmailId').prop("value",response.email);
                        $('#intPinCode').prop("value",response.pincode);
                        $('#heading').html("EDIT CONTACT");
                        $('#formSubmit').html("EDIT");

                    }
                },
                error: function(xhr, textStatus, error) {
                    console.error("Error:", error);
                }
            });
        }
        
    }); 
    $('.deleteBtn').click(function() {
        var intContactId =$(this).attr("data-id"); 
        if(confirm("Do you want to delete this Contact?")){
            $.ajax({
                url: './models/saveDetails.cfc?method=deleteContactDetails',
                type: 'post',
                data:  {intContactId: intContactId},
                dataType:"json",
                success: function(response) {
                    if(response.success){
                        window.location.href="?action=list";
                    } 
                }, 
            });
        }
        else{
            return false;
        }
    });

    $('#print').click(function() {
        var css = '@page { size: landscape; }',
            head = document.head || document.getElementsByTagName('head')[0],
            style = document.createElement('style');
            style.type = 'text/css';
            style.media = 'print';
            if (style.styleSheet){
                style.styleSheet.cssText = css;
            } else {
                style.appendChild(document.createTextNode(css));
        }
        head.appendChild(style);
        window.print();
    });

    $('#pdf').click(function(){
        var tableHTML = $('#pdfContent').html();
        $.post('./controllers/saveDetails.cfc?method=generatePDFFromTable', {tableHTML: tableHTML}, function(response) {
            if (response.success) {
                window.location.href = response.pdfPath;
            } else {
                alert('PDF generation failed: ' + response.msg);
            }
        }, 'json');
    });
          
});
function validation() {
    var fullName = $('#strFullname').val().trim();
    var img = $('#imgFile').val().trim();
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
    if (fullName == "" || img=="" || email == "" || userName == "" || password == "") {
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
    //var strUploadFile = $('#strUploadFile').val().trim();
    var strAddress = $('#strAddress').val().trim();
    var strStreet = $('#strStreet').val().trim();
    var intPhoneNumber = $('#intPhoneNumber').val().trim();
    var strEmailId = $('#strEmailId').val().trim();
    var intPinCode = $('#intPinCode').val().trim();
    var specialChar = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;
    var alphabets = /[A-z]/g;
    var number = /[0-9]/g;
    var emailRegex=/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    var specialCharFirstName = specialChar.test(strFirstName);
    var numberFirstName = number.test(strFirstName);
    var specialCharLastName = specialChar.test(strLastName);
    var numberLastName = number.test(strLastName);
    var alphabetDate = alphabets.test(strDate);
    var specialCharPincode = specialChar.test(intPinCode);
    var alphabetPincode = alphabets.test(intPinCode);
    var errorMsg = "";
    $("#addMsg").text(""); 
    if (strTitle == "" || strFirstName == "" || strLastName == "" || strGender == "" || strDate == ""  || strAddress == "" || strStreet == "" || intPhoneNumber == "" || strEmailId == "" || intPinCode == "" ) {
        errorMsg += "Please enter values in all fields!"; 
    }else {
        if((specialCharFirstName) || (numberFirstName)){
            errorMsg+="Firstname must contain String values only!"; 
        } 
        if((specialCharLastName) || (numberLastName)){
            errorMsg+="Lastname must contain String values only!"; 
        } 
        if((alphabetDate)){
            errorMsg+="Date must not contain String values!"; 
        }
        if(!isNaN(strAddress)){
            errorMsg+="Address should contain String values!";
        }
        if(!isNaN(strStreet)){
            errorMsg+="Street should contain String values!";
        }
        if(isNaN(intPhoneNumber) && isNaN(intPinCode)){
            errorMsg+="Phone Number and Pincode must contain Integer values only!"; 
        }else if(isNaN(intPhoneNumber)){
            errorMsg+="Phone Number must contain Integer values only!";
        }else if(isNaN(intPinCode)){
            errorMsg+="Pincode must contain Integer values only!"; 
        }else{
            if(intPhoneNumber.length != 10){
                errorMsg+="Phone Number must contain 10 digits!"; 
            }else if(intPinCode.length != 6){
                errorMsg+="Pincode must contain 6 digits!"; 
            }
        }
        if (!strEmailId.match(emailRegex)){
            errorMsg+="Enter a valid email address!";
        } 
    } 

    if (errorMsg !=='') {
        $("#addMsg").html(errorMsg).css('color','red');
        return false;
    }
    return true;
}