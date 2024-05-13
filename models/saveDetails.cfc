<cfcomponent>
    <cffunction name="doLogin" access="remote" returnType="query">
        <cfargument name="userName" required="true" type="string">
        <cfargument name="password" required="true" type="string">
        <cfquery name="checkLogin" datasource="DESKTOP-89AF345">
            select id,userName,password,email,fullName,img 
            from users
            where userName=<cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar">
            and password=<cfqueryparam value="#arguments.password#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn checkLogin>
    </cffunction>
    <cffunction  name="saveSignUp" access="remote"  returnformat="json">
        <cfargument name = "fullName" required="true" returnType="string">
        <cfargument name = "img" required="true" returnType="string">
        <cfargument name = "email" required="true" returnType="string">
        <cfargument name = "userName" required="true" returnType="string">
        <cfargument name = "password" required="true" returnType="string">

        <cfset local.path = ExpandPath("../assets/UploadImages/")>
        <cffile action="upload" destination="#local.path#" nameConflict="MakeUnique" filefield="img">
        <cfset local.profile = cffile.serverFile>

        <cftry>
            <cfquery name="newSignUp" datasource="DESKTOP-89AF345">
                insert into users (userName,img, password, email, fullName)
                values(
                    <cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#local.profile#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.password#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.fullName#" cfsqltype="cf_sql_varchar">
                ) 
            </cfquery>
            <cfreturn {"success":true}>
            <cfcatch type="exception">
                <cfreturn {"error":"An unexpected error occured!"}>
            </cfcatch>
        </cftry>
    </cffunction>
    <cffunction  name="saveContact" access="remote"  returnformat="json">
        <cfargument name = "intContactId" required='true' type="numeric">
        <cfargument name = "strTitle" required="true" returnType="string">
        <cfargument name = "strFirstName" required="true" returnType="string">
        <cfargument name = "strLastName" required="true" returnType="string">
        <cfargument name = "strGender" required="true" returnType="string">
        <cfargument name = "strDate" required="true" returnType="string">
        <cfargument name = "filePhoto" required="true" type="any">
        <cfargument name = "strAddress" required="true" returnType="string">
        <cfargument name = "strStreet" required="true" returnType="string">
        <cfargument name = "strEmailId" required="true" returnType="string">
        <cfargument name = "intPhoneNumber" required="true" returnType="string">
        <cfargument name = "intPinCode" required="true" returnType="string">
       
        <cfset local.path = ExpandPath("../assets/UploadImages/")>
        <cffile action="upload" destination="#local.path#" nameConflict="MakeUnique" filefield="filePhoto">
        <cfset local.profile = cffile.serverFile>

        <cfif arguments.intContactId GT 0>
            <cfquery name="updatePage">
                update contact 
                set title=<cfqueryparam value="#arguments.strTitle#" cfsqltype="cf_sql_varchar">,
                firstName=<cfqueryparam value="#arguments.strFirstName#" cfsqltype="cf_sql_varchar">,
                lastName=<cfqueryparam value="#arguments.strLastName#" cfsqltype="cf_sql_varchar">,
                gender=<cfqueryparam value="#arguments.strGender#" cfsqltype="cf_sql_varchar">,
                dob=<cfqueryparam value="#arguments.strDate#" cfsqltype="cf_sql_date">,
                photo=<cfqueryparam value="#local.profile#" cfsqltype="cf_sql_varchar">,
                address=<cfqueryparam value="#arguments.strAddress#" cfsqltype="cf_sql_varchar">,
                street=<cfqueryparam value="#arguments.strStreet#" cfsqltype="cf_sql_varchar">,
                email=<cfqueryparam value="#arguments.strEmailId#" cfsqltype="cf_sql_varchar">,
                userId=<cfqueryparam value="#session.intUid#" cfsqltype="cf_sql_integer">,
                pincode=<cfqueryparam value="#arguments.intPinCode#" cfsqltype="cf_sql_integer">,
                phone=<cfqueryparam value="#arguments.intPhoneNumber#" cfsqltype="cf_sql_varchar">
                where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfreturn {"success":"edited"}>
        <cfelse>
            <cfquery name="newContact" datasource="DESKTOP-89AF345">
                insert into contact (title, firstName, lastName, gender,dob,photo,address,street,email,phone,userId,pincode)
                values(
                    <cfqueryparam value="#arguments.strTitle#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.strFirstName#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.strLastName#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.strGender#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.strDate#" cfsqltype="cf_sql_date">,
                    <cfqueryparam value="#local.profile#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.strAddress#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.strStreet#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.strEmailId#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.intPhoneNumber#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#session.intUid#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#arguments.intPinCode#" cfsqltype="cf_sql_integer">
                ) 
            </cfquery>
            <cfreturn {"success":"added"}>
        </cfif>
    </cffunction>
    <cffunction  name = "checkUserExists" access="remote"  returnformat="json">
        <cfargument name = "userName" required="true" returnType="string">
        <cfquery name = "tableName" datasource="DESKTOP-89AF345">
            select userName
            from users
            where userName = <cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif tableName.recordCount>
            <cfreturn {"success":false}>
        <cfelse>
            <cfreturn {"success":true}>
        </cfif>
    </cffunction>
    <cffunction  name = "checkContactExists" access="remote"  returntype="query">
        <cfargument  name="intContactId" required="true">
        <cfargument name = "strEmailId" required="true" returnType="string">
        <cfquery name = "tableName" datasource="DESKTOP-89AF345">
            select email,contactId
            from contact
            where email = <cfqueryparam value="#arguments.strEmailId#" cfsqltype="cf_sql_varchar">
            AND contactId!=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn tableName>
    </cffunction>
   
    <cffunction name="getContactDetails" access="remote" returnFormat="json">
        <cfargument  name="intContactId" required="true">
        <cfquery name="forDisplay" datasource="DESKTOP-89AF345">
            select concat(title,'.',firstName,' ',lastName) as name,gender,dob,concat(address,', ',street) as address,pincode,email,phone ,photo 
            from contact
            where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn {"success":true,"name":forDisplay.name,"gender":forDisplay.gender,"dob":forDisplay.dob,"address":forDisplay.address,"pincode":forDisplay.pincode,"email":forDisplay.email,"phone":forDisplay.phone,"photo":forDisplay.photo}>
    </cffunction>
    <cffunction name="getEditContactDetails" access="remote" returnFormat="json">
        <cfargument  name="intContactId" required="true">
        <cfquery name="forDisplay" datasource="DESKTOP-89AF345">
            select contactId,title, firstName, lastName, gender,dob,photo,address,street,email,phone,userId,pincode
            from contact 
            where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn {"success":true,"title":forDisplay.title,"firstName":forDisplay.firstName,"lastName":forDisplay.lastName,"gender":forDisplay.gender,"dob":forDisplay.dob,"photo":forDisplay.photo,"address":forDisplay.address,"street":forDisplay.street,"pincode":forDisplay.pincode,"email":forDisplay.email,"phone":forDisplay.phone}>
    </cffunction>
    <cffunction name="deleteContactDetails" access='remote' returnFormat="json">
        <cfargument name="intContactId" type="numeric" required='true'>
        <cfquery name="deleteContactDetails">
            delete from contact
            where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn {"success":true}>
    </cffunction>
</cfcomponent>