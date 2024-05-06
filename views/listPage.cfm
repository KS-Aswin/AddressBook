<cfoutput>
    <cfinclude  template="./header.cfm">
    <div class="navbar d-flex px-5 mb-4 align-items-center justify-content-between">
        <div class="d-flex align-items-center justify-content-between gap-2">
            <img src="../assets/images/bodyBook.png" class="book" alt="book">
            <p class="bookTitle mb-0">ADDRESS BOOK</p>
        </div>
        <div class="d-flex gap-3 align-items-center">
            <div class="d-flex align-items-center profileText gap-1">
                <img src="../assets/images/logout.png" class="profile" alt="logout">
                <a href="./loginPage.cfm" title="go to login page" class="mb-0 log">Logout</a>
            </div>
        </div>
    </div>
    <div class="download d-flex align-items-center justify-content-center mb-4">
        <div class="downloadContainer d-flex align-items-center justify-content-end py-3 gap-4 pe-5">
            <img src="../assets/images/pdf.png" class="downloadIcon" alt="pdf">
            <img src="../assets/images/xl.png" class="downloadIcon" alt="xlsheet">
            <img src="../assets/images/print.png" class="downloadIcon pe-5" alt="print">
        </div>
    </div>
    <div class="d-flex gap-2 align-items-start justify-content-center mb-4 ">    
        <div class="profileUser d-flex flex-column align-items-center justify-content-center p-4 gap-2 me-3">            
            <img src="../assets/images/userProfile.png" class="userProfile " alt="userProfile">
            <h3 class="userName mb-0 ">s</h3>
            <button class="createContact m-0">CREATE CONTACT</button>
            
        </div>
        <div class="d-flex displayProfiles">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th scope="col"><h5><b class="tableHeading"></b></h5></th>
                        <th scope="col"><h5><b class="tableHeading">NAME</b></h5></th>
                        <th scope="col"><h5><b class="tableHeading">EMAIL ID</b></h5></th>
                        <th scope="col"><h5><b class="tableHeading">PHONE NUMBER</b></h5></th>
                    </tr>
                </thead>
                <tbody>
                    
                </tbody>
            </table>
        </div>
    </div>

</cfoutput>