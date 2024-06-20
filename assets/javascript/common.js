$(document).ready(function () {
    $('#logInBtn').click(function () {
        $("#loginMsg").text("");
        var errorMsg = "";
        var userName = $('#strUserName').val().trim();
        var password = $('#strPassword').val().trim();
        if (userName == '' && password == '') {
            errorMsg += "Please enter values in all fields!";
        } else if (userName == '') {
            errorMsg += "Please enter Username!";
        } else if (password == '') {
            errorMsg += "Please enter Password!";
        }
        if (errorMsg !== '') {
            $("#loginMsg").html(errorMsg).css('color', 'red');
            return false;
        }
        $.ajax({
            url: '../controllers/saveDetails.cfc?method=doLogin',
            type: 'post',
            data: {
                userName: userName,
                password: password
            },
            dataType: "json",
            success: function (response) {
                if (response.success) {
                    window.location.href = "./views/listPage.cfm";
                } else {
                    $("#loginMsg").text('Invalid user name or password!').css("color", "red");
                }
            },
        });
        return false;
    })
    $('#signUpBtn').click(function () {
        var fullName = $('#strFullname').val().trim();
        var img = $('#imgFile')[0].files[0];
        var email = $('#strEmail').val().trim();
        var userName = $('#strUsername').val().trim();
        var password = $('#strPassword').val().trim();
        var formData = new FormData();
        formData.append('fullName', fullName);
        formData.append('img', img);
        formData.append('email', email);
        formData.append('userName', userName);
        formData.append('password', password);
        $("#signUpMsg").html('');
        if (validation()) {
            $.ajax({
                url: '../controllers/saveDetails.cfc?method=saveSignUp',
                type: 'post',
                data: formData,
                contentType: false,
                processData: false,
                dataType: "json",
                success: function (response) {
                    if (response.success) {
                        alert("New User added Successfully");
                        window.location.href = "index.cfm";
                    } else {
                        $("#signUpMsg").html(response.msg).css('color', 'red');
                    }
                },
                error: function (xhr, status, error) {
                    console.log("An error occurred: " + error);
                }
            });
        }
        return false;
    });

    function updateSelectBox() {
        var hobbies = [];
        $('#optionsList option.selected').each(function() {
            hobbies.push($(this).text());
        });
        if (hobbies.length > 0) {
            $('.select-box').text(hobbies.join(', '));
        } else {
            $('.select-box').text('Select Options');
        }
    }

    $('.hobbieDropdown .select-box').click(function() {
        $(this).toggleClass('active');
        $('#optionsList').toggle();
    });

    $('#optionsList').on('click', 'option', function(event) {
        event.preventDefault();
        $(this).toggleClass('selected');
        this.selected = $(this).hasClass('selected');
        updateSelectBox();
    });

    $('#formSubmit').click(function () {
        var intContactId = $('#intContactId').val().trim();
        var strTitle = $('#strTitle').val().trim();
        var strFirstName = $('#strFirstName').val().trim();
        var strLastName = $('#strLastName').val().trim();
        var strGender = $('#strGender').val().trim();
        var strDate = $('#strDate').val().trim();
        var filePhoto = $('#strUploadFile')[0].files[0];
        var strAddress = DOMPurify.sanitize($('#strAddress').val().trim());
        var strStreet = DOMPurify.sanitize($('#strStreet').val().trim());
        var intPhoneNumber = $('#intPhoneNumber').val().trim();
        var strEmailId = $('#strEmailId').val().trim();
        var intPinCode = $('#intPinCode').val().trim();
        if(intContactId == 0){
            var hobbies = [];
            $('#optionsList option.selected').each(function() {
                hobbies.push($(this).val());
            });
        }else{
            var hobbies = $('.select-box').html().trim();
        }
        var formData = new FormData();
        formData.append('intContactId', intContactId);
        formData.append('strTitle', strTitle);
        formData.append('strFirstName', strFirstName);
        formData.append('strLastName', strLastName);
        formData.append('strGender', strGender);
        formData.append('strDate', strDate);
        formData.append('filePhoto', filePhoto);
        formData.append('strAddress', strAddress);
        formData.append('strStreet', strStreet);
        formData.append('intPhoneNumber', intPhoneNumber);
        formData.append('strEmailId', strEmailId);
        formData.append('intPinCode', intPinCode);
        formData.append('hobbies',hobbies);
        $("#addMsg").html('');
        if (contactValidation()) {
            $.ajax({
                url: '../controllers/saveDetails.cfc?method=contactDetails',
                type: 'post',
                data: formData,
                contentType: false,
                processData: false,
                dataType: "json",
                success: function (response) {
                    if (response.result == "edited") {
                        window.location.href = "./views/listPage.cfm";
                    } else if (response.result == "added") {
                        window.location.href = "./views/listPage.cfm";
                    } else if (response.result == "exist") {
                        $("#addMsg").html("Contact with same Email ID already Existing").css('color', 'red');
                    } else if (response.result == "email") {
                        $("#addMsg").html("The user cannot create hisown Contact").css('color', 'red');
                    }
                },
                error: function (xhr, status, error) {
                    console.log("An error occurred: " + error);
                }
            });
        }
        return false;
    });

    $('.viewBtn').click(function () {
        var intContactId = $(this).attr("data-id");
        $.ajax({
            type: "POST",
            url: "../models/saveDetails.cfc?method=getContactDetails",
            data: {
                intContactId: intContactId
            },
            dataType: "json",
            success: function (response) {
                if (response.success) {
                    $('#name').html(response.name);
                    $('#gender').html(response.gender);
                    var date = new Date(response.dob);
                    var strDate = date.getFullYear() + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + ('0' + date.getDate()).slice(-2);
                    $('#dob').html(strDate);
                    $('#address').html(response.address);
                    $('#pincode').html(response.pincode);
                    $('#email').html(response.email);
                    $('#phone').html(response.phone);
                    $('#hobbie').html(response.hobbies);
                    $('.modalImg').attr('src', '../assets/UploadImages/' + response.photo);
                }
            },
            error: function (xhr, textStatus, error) {
                console.error("Error:", error);
            }
        });
    });

    $("#createContactButton").click(function () {
        $("#myFormValues")[0].reset();
        $('#addMsg').html("");
        $('.select-box').html("Select Options");
        $('#heading').html("CREATE CONTACT").css("font-weight",700);
        $('#formSubmit').html("CREATE");
    });

    $('#formClose').click(function (e) {
		e.preventDefault();
		$("#myFormValues").get(0).reset();
	});

    $('#formExcelClose').click(function (e) {
		e.preventDefault();
		$("#myFormExcel").get(0).reset();
	});

    $('.editBtn').click(function () {
        $('.checkBox').attr('checked',false);
        var intContactId = $(this).attr("data-id");
        if (intContactId > 0) {
            $.ajax({
                type: "POST",
                url: "../models/saveDetails.cfc?method=getEditContactDetails",
                data: {
                    intContactId: intContactId
                },
                dataType: "json",
                success: function (response) {
                    if (response.success) {
                        $('#intContactId').prop('value', intContactId);
                        $('#strTitle').prop("value", response.title);
                        $('#strFirstName').prop("value", response.firstName);
                        $('#strLastName').prop("value", response.lastName);
                        $('#strGender').prop("value", response.gender);
                        $('#strUploadFile').attr('value', './assets/UploadImages/' + response.photo)[0].files[0];
                        var date = new Date(response.dob);
                        var strDate = date.getFullYear() + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + ('0' + date.getDate()).slice(-2);
                        $('#strDate').prop("value", strDate);
                        $('#strAddress').prop("value", response.address);
                        $('#strStreet').prop("value", response.street);
                        $('#intPhoneNumber').prop("value", response.phone);
                        $('#strEmailId').prop("value", response.email);
                        $('#intPinCode').prop("value", response.pincode);
                        $('.modalImg').attr('src', '../assets/UploadImages/' + response.photo);
                        if(response.hobbies ==""){
                            $('.select-box').html("Select Options");
                        }else{
                            $('.select-box').html(response.hobbies);
                        }
                        $('#heading').html("EDIT CONTACT");
                        $('#formSubmit').html("SAVE");
                    }
                },
                error: function (xhr, textStatus, error) {
                    console.error("Error:", error);
                }
            });
        }

    });
    $('.deleteBtn').click(function () {
        var intContactId = $(this).attr("data-id");
        if (confirm("Do you want to delete this Contact?")) {
            $.ajax({
                url: '../models/saveDetails.cfc?method=deleteContactDetails',
                type: 'post',
                data: {
                    intContactId: intContactId
                },
                dataType: "json",
                success: function (response) {
                    if (response.success) {
                        window.location.href = "list";
                    }
                },
            });
        } else {
            return false;
        }
    });

    $('#print').on('click', function () {
        var printArea = $('#pdfContent').html();
        $('body').html(printArea);
        window.print();
        window.location.href = "../views/listPage.cfm";
    });

    $('#pdf').click(function () {
        var tableHTML = $('#pdfContent').html();
        $.post('../controllers/saveDetails.cfc?method=generatePDFFromTable', {
            tableHTML: tableHTML
        }, function (response) {
            if (response.success) {
                window.location.href = response.pdfPath;
            } else {
                console.log('PDF generation failed: ' + response.msg);
            }
        }, 'json');
    });

    $('#formExcelSubmit').click(function () {
        var excelContact = $('#strUploadExleFile').val().trim();
        var errorMsg = "";
        $("#excelMsg").text("");
        if (excelContact == "") {
            errorMsg += "error";
        }
        if (errorMsg != '') {
            $("#excelMsg").html("Choose a Valid Excell file!").css("color", "red");
        } else {
            var excelFile = $('#strUploadExleFile')[0].files[0];
            var formData = new FormData();
            formData.append('excelFile', excelFile);
            $.ajax({
                url: '../controllers/saveDetails.cfc?method=excelDetails',
                type: 'post',
                data: formData,
                contentType: false,
                processData: false,
                dataType: "json",
                success: function (response) {
                    if (response.result == "added") {
                        window.location.href = "../views/listPage.cfm";
                    } else if (response.result == "exist") {
                        $("#excelMsg").html("Contact with same Email ID already Existing").css('color', 'red');
                    }
                },
                error: function (xhr, status, error) {
                    console.log("An error occurred: " + error);
                }
            });
        }
        return false;

    });

});


$(document).ready(function () {
    $('#googleLogin').on('click', function () {
        signIn();
    });
    let params = {};
    params={"http://book.local":"list"};
    //params={"http://book.local/views":"listPage"};
    let regex = /([^&=]+)=([^&]*)/g, m;

    while ((m = regex.exec(location.href)) !== null) {
        params[decodeURIComponent(m[1])] = decodeURIComponent(m[2]);
    }

    if (Object.keys(params).length > 0) {
        localStorage.setItem('authInfo', JSON.stringify(params));
        window.history.pushState({}, document.title, "");
    }

    let info = JSON.parse(localStorage.getItem('authInfo'));

    if (info) {
        $.ajax({
            url: "https://www.googleapis.com/oauth2/v3/userinfo",
            headers: {
                "Authorization": `Bearer ${info['access_token']}`
            },
            success: function (data) {
                var email = data.email;
                var fullName = data.name;
                var img = data.picture;
                $.ajax({
                    url: '../controllers/saveDetails.cfc?method=doLoginSOS',
                    type: 'post',
                    data: {
                        email: email,
                        fullName: fullName,
                        img: img
                    },
                    dataType: "json",
                    success: function (response) {
                        if (response.success) {
                            window.location.href = "../views/listPage.cfm";
                        }
                    },
                    error: function (xhr, status, error) {
                        console.log("An error occurred: " + error);
                    }
                });
            }
        });
    }


});

function signIn() {
    let oauth2Endpoint = "https://accounts.google.com/o/oauth2/v2/auth";

    let $form = $('<form>')
        .attr('method', 'GET')
        .attr('action', oauth2Endpoint);

    let params = {
        "client_id": "726795246693-onu2vv2jqnqv1821vkcbuveqkpt833co.apps.googleusercontent.com",
        "redirect_uri": "https://redirectmeto.com/http://book.local/views/listPage.cfm",
        "response_type": "token",
        "scope": "https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email",
        "include_granted_scopes": "true",
        "state": 'pass-through-value'
    };

    $.each(params, function (name, value) {
        $('<input>')
            .attr('type', 'hidden')
            .attr('name', name)
            .attr('value', value)
            .appendTo($form);
    });

    $form.appendTo('body').submit();
}

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
    var emailRegex = /^\w+([\.+-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    var specialCharName = specialChar.test(fullName);
    var numberName = number.test(fullName);
    var specialCharUser = specialChar.test(userName);
    var numberUser = number.test(userName);
    var errorMsg = "";
    $("#signUpMsg").text("");
    if (fullName == "" || img == "" || email == "" || userName == "" || password == "") {
        errorMsg += "Please enter values in all fields!";
    } else {
        if ((specialCharName) || (numberName)) {
            errorMsg += "Fullname must contain String values only!" + "<br>";
        }
        if (!email.match(emailRegex)) {
            errorMsg += "Enter a valid email address!" + "<br>";
        }
        if ((specialCharUser) || (numberUser)) {
            errorMsg += "Username must contain String values only!" + "<br>";
        }
        if (password != '') {
            var specialChar = specialChar.test(password);
            var alphabets = alphabets.test(password);
            var number = number.test(password);
            if (!((specialChar) && (alphabets) && (number))) {
                errorMsg += "Password should contain all type values!";
            }
        }
        if (confirmPassword != password) {
            errorMsg += "Password and Confirm Password does not match!";
        }
    }

    if (errorMsg !== '') {
        $("#signUpMsg").html(errorMsg).css('color', 'red');
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
    var filePhoto = $('#strUploadFile').val().trim();
    var strAddress = DOMPurify.sanitize($('#strAddress').val().trim());
    var strStreet = DOMPurify.sanitize($('#strStreet').val().trim());
    var intPhoneNumber = $('#intPhoneNumber').val().trim();
    var strEmailId = $('#strEmailId').val().trim();
    var intPinCode = $('#intPinCode').val().trim();
    var specialChar = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;
    var number = /[0-9]/g;
    var emailRegex = /^\w+([\.+-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    var specialCharFirstName = specialChar.test(strFirstName);
    var numberFirstName = number.test(strFirstName);
    var specialCharLastName = specialChar.test(strLastName);
    var numberLastName = number.test(strLastName);
    var regexWithCountryCode = /^\+91\d{10}$/;
    var regexWithoutCountryCode = /^\d{10}$/;
    var errorMsg = "";
    $("#addMsg").text("");
    if (strTitle == "" || strFirstName == "" || strLastName == "" || strGender == "" || strDate == "" || filePhoto == "" || strAddress == "" || strStreet == "" || intPhoneNumber == "" || strEmailId == "" || intPinCode == "") {
        errorMsg += "Please enter values in all fields!" + "<br>";
    } else {
        if (strFirstName.length >= 2 && strFirstName.length <= 50) {
            if ((specialCharFirstName) || (numberFirstName)) {
                errorMsg += "Firstname must contain String values only!" + "<br>";
                $("#formFirstname").css("color", "red");
            } else {
                $("#formFirstname").css("color", "#337AB7");
            }
        } else if (strFirstName.length <= 1) {
            errorMsg += "Firstname must contain atleast two characters!" + "<br>";
            $("#formFirstname").css("color", "red");
        }else if (strFirstName.length >= 51) {
            errorMsg += "Firstname must contain lessthan 50 characters!" + "<br>";
            $("#formFirstname").css("color", "red");
        } else {
            $("#formFirstname").css("color", "#337AB7");
        }
        if (strLastName.length >= 1 && strLastName.length <= 50) {
            if ((specialCharLastName) || (numberLastName)) {
                errorMsg += "Lastname must contain String values only!" + "<br>";
                $("#formLastname").css("color", "red");
            } else {
                $("#formLastname").css("color", "#337AB7");
            }
        }else if (strLastName.length < 1) {
            errorMsg += "Lastname must contain atleast two characters!" + "<br>";
            $("#formLastname").css("color", "red");
        }else if (strLastName.length >= 51) {
            errorMsg += "Lastname must contain lessthan 50 characters!" + "<br>";
            $("#formLastname").css("color", "red");
        } else {
            $("#formLastname").css("color", "#337AB7");
        }
        if (!isNaN(strAddress)) {
            errorMsg += "Address should contain String values!" + "<br>";
            $("#formAddress").css("color", "red");
        } else {
            $("#formAddress").css("color", "#337AB7");
        }
        if (!isNaN(strStreet)) {
            errorMsg += "Street should contain String values!" + "<br>";
            $("#formStreet").css("color", "red");
        } else {
            $("#formStreet").css("color", "#337AB7");
        }
        if (!regexWithCountryCode.test(intPhoneNumber) && !regexWithoutCountryCode.test(intPhoneNumber)) {
            errorMsg += 'Phone number should start with +91 and contain 13 digits, or be a 10-digit number.' + "<br>";
            $("#formPhone").css("color", "red");
        } else {
            $("#formPhone").css("color", "#337AB7");
        }
        if (isNaN(intPinCode)) {
            errorMsg += "Pincode must contain Integer values only!" + "<br>";
            $("#formPincode").css("color", "red");
        }else {
            $("#formPincode").css("color", "337AB7");
            if (intPinCode.length != 6) {
                errorMsg += "Pincode must contain 6 digits!" + "<br>";
                $("#formPincode").css("color", "#red");
            } else {
                $("#formPincode").css("color", "337AB7");
                $("#formPhone").css("color", "#337AB7");
            }
        }
        if (!strEmailId.match(emailRegex)) {
            errorMsg += "Enter a valid email address!" + "<br>";
            $("#formEmail").css("color", "red");
        } else {
            $("#formEmail").css("color", "#337AB7");
        }
    }

    if (errorMsg !== '') {
        $("#addMsg").html(errorMsg).css('color', 'red');
        return false;
    }
    return true;
}
$(document).ready(function(){
    $("#strDate").datepicker({
        changeMonth:true,
        changeYear:true,
        yearRange:'1920:2024',
        maxDate:'0y',
        minDate:'-100y'
    });
});
