<cfscript>
    cfparam(name="url.action", default="login", pattern="");
    switch(lcase(url.action)){
        case "login":
            include "/views/header.cfm";
            include "/views/navbar.cfm";
            include "/views/logInPage.cfm";           
        break;
        case "register":
            include "/views/header.cfm";
            include "/views/navbar.cfm";
            include "/views/signUpPage.cfm";           
        break;
        case "display":
            include "/views/header.cfm";
            include "/views/navbar.cfm";
            include "/views/display.cfm";           
        break;
    }
</cfscript>