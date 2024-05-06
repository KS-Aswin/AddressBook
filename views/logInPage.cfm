<cfoutput>
    <div class="mainBody pt-5 d-flex align-items-center justify-content-center">
        <div class="bodyContainer d-flex">
            <div class="leftBody d-flex align-items-center justify-content-center">
                <img src="../assets/images/bodyBook.png" class="bodyBook mx-5" alt="book">
            </div>
            <div class="rightBody d-flex flex-column py-2 px-4">
                <form class="loginForm" action="login.cfm" id="formTarget" method="post" >  
                    <div class="d-flex flex-column align-items-center justify-content-center">
                        <p class="login">LOGIN</p>
                        <input class="loginInput m-2 mb-4 col-12 pe-5 ps-4 py-2" id="strUsername" type="text" name="strUsername" id="strUsername" placeholder="Username">
                        <input class="loginInput m-2 my-4 col-12 pe-5 ps-4 py-2" id="strPassword" type="password"  name="strPassword" id="strPassword" placeholder="Password">
                        <button type="submit" name="submit" id="logInBtn" class="loginBtn">LOGIN</button>
                        <p class="signin">Or Sign In Using</p>
                        <div class="mb-2">
                            <img src="../assets/images/fb.png" class="signInImg" alt="fb">
                            <img src="../assets/images/google.png" class="signInImgGoogle" alt="google">
                        </div>
                        <p class="mb-1">Don't have an account?<a href="?action=register" title="go to signup page">Register Here</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
</cfoutput>