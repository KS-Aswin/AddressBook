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
        case "list":
            include "/controllers/listPageAction.cfm"; 
            include "/views/header.cfm";
            include "/views/pageNav.cfm";
            include "/views/listPage.cfm";  
        break;
        case "pdfFile":
            include "/views/header.cfm";
            include "/views/pdfFile.cfm";
        break;
        case 'xlFile':
            include '/views/header.cfm';
            include "/views/navbar.cfm";
            include '/views/xlFile.cfm';
            include "/views/list.cfm";
        break;
    }
</cfscript>