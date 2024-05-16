<cfset local.forSignin = createObject("component","controllers.saveDetails").checkLogin()>
<cfoutput>
    <div class="mainBody d-flex flex-column align-items-center justify-content-center mb-5">
        <h3 class="pb-5 w3-panel w3-green" id="loginMsg"></h3>
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
                        <p class="mb-1">Don't have an account?<a href="?action=register" title="go to signup page"> Register Here</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
</cfoutput>