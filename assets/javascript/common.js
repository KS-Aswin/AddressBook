$(document).ready(function () {
    $('#formTarget').on("submit",function () {
        var fullName = $('#strFullname').val().trim();
        var email = $('#strEmail').val().trim();
        var userName = $('#strUsername').val().trim();
        var password = $('#strPassword').val().trim();
        var confirmPassword = $('#strConfirmPassword').val().trim();
        $("#signUpSuccess").html('');
        if (validation()) {
            $.ajax({
                url: './controllers/signUp.cfc?method=saveSignUp',
                type: 'post',
                data: {
                    fullName: fullName,
                    email: email,
                    userName: userName,
                    password: password,
                    confirmPassword: confirmPassword
                },
                dataType: "json",
                success: function (response) {
                    if (response.success) {
                        $("#signUpSuccess").html(response.msg).css('color','green');
                    } else {
                        $("#signUpError").html(response.msg).css('color','red');
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
    var errorMsg = "a";
    if (fullName == "" || email == "" || userName == "" || password == "") {
        errorMsg += "Please enter values in all fields!" + "<br>";
    } 
    if (/\d/.test(fullName)) {
        errorMsg += "Fullname must contain String values only!" + "<br>";
    }
    if (!validateEmail(email)) {
        errorMsg += "Enter a valid Email!" + "<br>";
    }
    if (!validatePassword(password)) {
        errorMsg += "Password must contain at least 8 characters"+ "<br>" +"including digits and special characters.!" + "<br>";
    }
    if (password != confirmPassword) {
        errorMsg += "Password and Confirm Password does not match!" + "<br>";
    }
    if (errorMsg.length) {
        $("#signUpMsg").html(errorMsg).css('color','red');
        return false;
    }
    return true;
}

function validatePassword(password) {
    var passwordRegex = /^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-zA-Z]).{8,}$/;
    return passwordRegex.test(password);
}
function validateEmail() {
    var emailRegex = /^\b[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b$/i
    return emailRegex.test(email);
}
