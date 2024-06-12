<cfset local.forSignin = createObject("component","controllers.saveDetails").checkLogin()>
<cfoutput>
<!DOCTYPE html>
<html>
<head> 
    <title>Address Book</title>
    <meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="./assets/css/bootstrap.min.css">     
    <link rel="stylesheet" type="text/css" href="./assets/css/jquery-ui.css">   
    <link rel="stylesheet" type="text/css" href="./assets/css/style2.css">
    <link rel="stylesheet" type="text/css" href="./assets/css/style.css">
    <script src="./assets/javascript/jquery.min.js"></script> 
    <script src="./assets/javascript/bootstrap.bundle.min.js"></script>  
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>   
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/dompurify/2.3.4/purify.min.js"></script>
    <script src="./assets/javascript/jquery-ui.js"></script> 
    <script src="./assets/javascript/common.js"></script> 
</head>
<body>
    <div class="navbar d-flex px-5  align-items-center justify-content-between">
        <div class="d-flex align-items-center justify-content-between gap-2">
            <img src="./assets/images/bodyBook.png" class="book" alt="book">
            <p class="bookTitle mb-0">ADDRESS BOOK</p>
        </div>
        <div class="d-flex gap-3 align-items-center">
            <div class="d-flex align-items-center profileText gap-1">
                <img src="./assets/images/profile.png" class="profile" alt="profile">
                <a href="views/signUpPage.cfm" title="go to signup page" class="mb-0 log">Sign Up</a>
            </div>
            <div class="d-flex align-items-center profileText gap-1">
                <img src="./assets/images/login.png" class="profile" alt="login">
                <a href="index.cfm" title="got to login page" class="mb-0 log">Login</a>
            </div>
        </div>
    </div>
    <div class="mainBody d-flex flex-column align-items-center justify-content-center mb-5">
        <h3 class="p-2 w3-panel w3-green mb-0" id="loginMsg"></h3>
        <div class="bodyContainer d-flex">
            <div class="leftBody d-flex align-items-center justify-content-center">
                <img src="./assets/images/bodyBook.png" class="bodyBook mx-5" alt="book">
            </div>
            <div class="rightBody d-flex flex-column py-2 px-4">
                <form class="loginForm" action="" id="formTarget" method="post" >  
                    <div class="d-flex flex-column align-items-center justify-content-center">
                        <p class="login">LOGIN</p>
                        <input class="loginInput m-2 mb-4 col-12 pe-5 ps-4 py-2" id="strUserName" type="text" name="strUserName" id="strUserName" placeholder="Username">
                        <input class="loginInput m-2 my-4 col-12 pe-5 ps-4 py-2" id="strPassword" type="password"  name="strPassword" id="strPassword" placeholder="Password">
                        <button type="button" class="loginBtn" id="logInBtn">LOGIN</button>
                        <p class="signin">Or Sign In Using</p>
                        <div class="mb-2">
                            <img src="./assets/images/fb.png" class="signInImg" alt="fb">
                            <img src="./assets/images/google.png" class="signInImgGoogle" id="googleLogin" alt="google">
                        </div>
                        <p class="mb-1">Don't have an account?<a href="views/signUpPage.cfm" class="regHere" title="go to signup page"> Register Here</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
</cfoutput>