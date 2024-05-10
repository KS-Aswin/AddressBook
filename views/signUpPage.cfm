<cfoutput>
    <div class="mainBody  d-flex flex-column align-items-center justify-content-center mb-5">
    <h3 class="pb-5 w3-panel w3-green" id="signUpMsg"></h3>
        <div class="bodyContainer d-flex">
            <div class="leftBody d-flex align-items-center justify-content-center">
                <img src="./assets/images/bodyBook.png" class="bodyBook mx-5" alt="book">
            </div>
            <div class="rightBody d-flex flex-column py-2 px-4">
                <form class ="signUpForm" id="formTarget" action ="" method ="post"  enctype="multipart/form-data">  
                    <div class="d-flex flex-column align-items-center justify-content-center">
                        <p class="signup">SIGN UP</p>
                        <input class="signupInput m-2 mb-4 col-12 pe-5 ps-4 py-2" type="text" name="strFullname" id="strFullname" placeholder="Fullname">
                        <input class="signupInput m-2 mb-4 col-12 pe-5 ps-4 py-2" type="file" name="imgFile" id="imgFile" accept=".jpg, .jpeg, .png, .gif">
                        <input class="signupInput m-2 mb-4 col-12 pe-5 ps-4 py-2" type="text" name="strEmail" id="strEmail" placeholder="Email ID">
                        <input class="signupInput m-2 mb-4 col-12 pe-5 ps-4 py-2" type="text" name="strUsername" id="strUsername" placeholder="Username">
                        <input class="signupInput m-2 my-4 col-12 pe-5 ps-4 py-2" type="password" name="strPassword" id="strPassword" placeholder="Password">
                        <input class="signupInput m-2 my-4 col-12 pe-5 ps-4 py-2" type="password" name="strConfirmPassword" id="strConfirmPassword" placeholder="Confirm Password">
                        <button class="signupBtn" id="signUpBtn">REGISTER</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
</cfoutput>