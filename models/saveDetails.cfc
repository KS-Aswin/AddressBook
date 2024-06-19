<cfcomponent>
    <cffunction name="doLogin" access="remote" returnType="query">
        <cfargument name="userName" required="true" type="string">
        <cfargument name="password" required="true" type="string">
        <cfquery name="checkLogin" datasource="DESKTOP-89AF345">
            select id,userName,password,email,fullName,img 
            from users
            where email=<cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar">
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
        <cfargument name = "strTitle" required="true" type="string">
        <cfargument name = "strFirstName" required="true" type="string">
        <cfargument name = "strLastName" required="true" type="string">
        <cfargument name = "strGender" required="true" type="string">
        <cfargument name = "strDate" required="true" type="string">
        <cfargument name = "filePhoto" required="true" type="any">
        <cfargument name = "strAddress" required="true" type="string">
        <cfargument name = "strStreet" required="true" type="string">
        <cfargument name = "strEmailId" required="true" type="string">
        <cfargument name = "intPhoneNumber" required="true" type="string">
        <cfargument name = "intPinCode" required="true" type="string">
        <cfargument name = "hobbies" required="true" type="string">
        <cfset local.hobbiesArray=ListToArray(arguments.hobbies,',')>
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
            <cfquery name="deleteHobbie">
                delete from hobbies
                where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfif arrayLen(local.hobbiesArray) GT 0>
                <cfloop index="i" from="1" to="#arrayLen(local.hobbiesArray)#">
                    <cfquery name="editHobbies">
                        insert into hobbies(contactId,hobby)
                        values(
                            <cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">,
                            <cfqueryparam value="#local.hobbiesArray[i]#" cfsqltype="cf_sql_varchar">
                        )
                    </cfquery>
                </cfloop>
            </cfif>
            <cfreturn {"success":"edited"}>
        <cfelse>
            <cfquery name="newContact" result="newContactResult" datasource="DESKTOP-89AF345">
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
            <cfset local.newContactId = newContactResult.generatedKey>
            <cfif arrayLen(local.hobbiesArray) GT 0>
                <cfloop index="i" from="1" to="#arrayLen(local.hobbiesArray)#">
                    <cfquery name="saveHobbies">
                        insert into hobbies(contactId,hobby)
                        values(
                            <cfqueryparam value="#local.newContactId#" cfsqltype="cf_sql_integer">,
                            <cfqueryparam value="#local.hobbiesArray[i]#" cfsqltype="cf_sql_varchar">
                        )
                    </cfquery>
                </cfloop>
            </cfif>
            <cfreturn {"success":"added"}>
        </cfif>
    </cffunction>

    <cffunction  name = "checkUserExists" access="remote"  returnformat="json">
        <cfargument name = "email" required="true" returnType="string">
        <cfquery name = "userExist" datasource="DESKTOP-89AF345">
            select userName
            from users
            where email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif userExist.recordCount>
            <cfreturn {"success":false}>
        <cfelse>
            <cfreturn {"success":true}>
        </cfif>
    </cffunction>

    <cffunction  name = "checkContactEmail" access="remote"  returntype="query">
        <cfargument name = "strEmailId" required="true" returnType="string">
        <cfquery name = "contactEmail" datasource="DESKTOP-89AF345">
            select email
            from users
            where email = <cfqueryparam value="#arguments.strEmailId#" cfsqltype="cf_sql_varchar">
            AND id = <cfqueryparam value="#session.intUid#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn contactEmail>
    </cffunction>

    <cffunction  name = "checkContactExists" access="remote"  returntype="query">
        <cfargument  name="intContactId" required="true">
        <cfargument name = "strEmailId" required="true" returnType="string">
        <cfquery name = "contactExist" datasource="DESKTOP-89AF345">
            select email,contactId
            from contact
            where email = <cfqueryparam value="#arguments.strEmailId#" cfsqltype="cf_sql_varchar">
            AND contactId! = <cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
            AND userId = <cfqueryparam value="#session.intUid#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn contactExist>
    </cffunction>

    <cffunction  name = "checkExcelContactExists" access="remote"  returnFormat="json">
        <cfargument name = "excelFile" required="true" type="any">
        <cfset local.FileUploadPath=Expandpath("../assets/excelUpload/")>
        <cffile action="upload" destination="#local.FileUploadPath#" nameConflict="MakeUnique">
        <cfset local.fileName=cffile.serverFile>
        <cfset local.FilePath=local.FileUploadPath&local.fileName>
        <cfspreadsheet action="read" src="#local.FilePath#" query="spreadsheetData" headerrow="1"> 
        <cfset local.excelHead = getMetaData(spreadsheetData)>
        <cfset local.excelColumnNames = []>
        <cfloop index="i" from="1" to="#arrayLen(local.excelHead)#">
            <cfset columnhead = local.excelHead[i].name>
            <cfset arrayAppend(local.excelColumnNames, columnhead)>
        </cfloop>
        <cfquery name="qryColumnNames">
            select column_name
            from information_schema.columns
            where table_name = 'contact'
        </cfquery>

        <cfset local.dbColumnNames = []>
        <cfloop query="qryColumnNames">
            <cfif(!((qryColumnNames.column_name EQ 'contactId') OR (qryColumnNames.column_name EQ 'userID')))>
                <cfset arrayAppend(local.dbColumnNames, qryColumnNames.column_name)>
            </cfif>
        </cfloop>
        <cfset arrayAppend(local.dbColumnNames, 'Hobbies')>
        <cfset local.excelColumnNames=ArrayToList(local.excelColumnNames)>
        <cfset local.dbColumnNames=ArrayToList(local.dbColumnNames)>
        <cfset local.allHeader = Listappend(trim(local.excelColumnNames),trim(local.dbColumnNames))>
        <cfset local.ListRemoveDuplicate=(ListRemoveDuplicates(local.allHeader,",",true))>
        <cfif (ListLen(local.dbColumnNames) EQ ListLen(local.ListRemoveDuplicate)) AND (ListLen(local.dbColumnNames) EQ ListLen(trim(local.excelColumnNames)))>
            <cfspreadsheet action="read" src="#local.FilePath#" query="spreadsheetData" headerrow='1' rows='2-50'>
            <cfloop query="#spreadsheetData#">
                <cfset local.title = spreadsheetData.Title> 
                <cfset local.firstName = spreadsheetData.FirstName> 
                <cfset local.lastName = spreadsheetData.LastName> 
                <cfset local.gender = spreadsheetData.Gender> 
                <cfset local.dob = spreadsheetData.DOB> 
                <cfset local.photo = spreadsheetData.Photo> 
                <cfset local.address = spreadsheetData.Address> 
                <cfset local.street = spreadsheetData.Street> 
                <cfset local.email = spreadsheetData.Email> 
                <cfset local.phone = spreadsheetData.Phone> 
                <cfset local.userId = session.intUid> 
                <cfset local.pincode = spreadsheetData.Pincode>
                <cfset local.hobbies = spreadsheetData.Hobbies>
                <cfquery name="excelInsert">
                    select email
                    from contact
                    where email = <cfqueryparam value="#local.email#" cfsqltype="cf_sql_varchar">
                    and userId = <cfqueryparam value="#session.intUid#" cfsqltype="cf_sql_integer">
                </cfquery>
                <cfif excelInsert.recordCount>
                    <cfcontinue>
                <cfelse>
                    <cfquery name = "contactEmail" datasource="DESKTOP-89AF345">
                        select email
                        from users
                        where email = <cfqueryparam value="#local.email#" cfsqltype="cf_sql_varchar">
                        and id = <cfqueryparam value="#session.intUid#" cfsqltype="cf_sql_integer">
                    </cfquery>
                    <cfif contactEmail.recordCount>
                        <cfcontinue>
                    <cfelse>

                        <cfquery name="newExcelContact" result="excelResult" datasource="DESKTOP-89AF345">
                            insert into contact (title, firstName, lastName, gender,dob,photo,address,street,email,phone,userId,pincode)
                            values(
                                <cfqueryparam value="#local.title#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#local.firstName#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#local.lastName#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#local.gender#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#local.dob#" cfsqltype="cf_sql_date">,
                                <cfqueryparam value="#local.photo#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#local.address#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#local.street#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#local.email#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#local.phone#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#session.intUid#" cfsqltype="cf_sql_integer">,
                                <cfqueryparam value="#local.pincode#" cfsqltype="cf_sql_varchar">
                            ) 
                        </cfquery>



                        <cfset local.hobbiesArray=ListToArray(spreadsheetData.Hobbies,',')>

                        <cfset local.newContactId = excelResult.generatedKey>
                        <cfif arrayLen(local.hobbiesArray) GT 0>
                            <cfloop index="i" from="1" to="#arrayLen(local.hobbiesArray)#">
                                <cfquery name="saveHobbies">
                                    insert into hobbies(contactId,hobby)
                                    values(
                                        <cfqueryparam value="#local.newContactId#" cfsqltype="cf_sql_integer">,
                                        <cfqueryparam value="#local.hobbiesArray[i]#" cfsqltype="cf_sql_varchar">
                                    )
                                </cfquery>
                            </cfloop>
                        </cfif>







                    </cfif>
                </cfif> 
            </cfloop>         
        </cfif>
        <cfreturn {"success":"added"}> 
    </cffunction>
   
    <cffunction name="getContactDetails" access="remote" returnFormat="json">
        <cfargument  name="intContactId" required="true">
        <cfquery name="getHobbies">
            select hobby 
            from hobbies
            where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfset local.viewHobbies = "">
        <cfloop query="#getHobbies#">
            <cfset local.viewHobbies &= getHobbies.hobby&" ">
        </cfloop>
        <cfquery name="forDisplay" datasource="DESKTOP-89AF345">
            select concat(title,'.',firstName,' ',lastName) as name,gender,dob,concat(address,', ',street) as address,pincode,email,phone ,photo 
            from contact
            where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn {"success":true,"name":forDisplay.name,"gender":forDisplay.gender,"dob":forDisplay.dob,"address":forDisplay.address,"pincode":forDisplay.pincode,"email":forDisplay.email,"phone":forDisplay.phone,"photo":forDisplay.photo,"hobbies":local.viewHobbies}>
    </cffunction>

    <cffunction name="getEditContactDetails" access="remote" returnFormat="json">
        <cfargument  name="intContactId" required="true">
        <cfquery name="getHobbies">
            select hobby 
            from hobbies
            where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfset local.hobbieValues = "">
        <cfloop query="#getHobbies#">
            <cfset local.hobbieValues &= getHobbies.hobby&" ">
        </cfloop>
        <cfquery name="forDisplay" datasource="DESKTOP-89AF345">
            select contactId,title, firstName, lastName, gender,dob,photo,address,street,email,phone,userId,pincode
            from contact 
            where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn {"success":true,"title":forDisplay.title,"firstName":forDisplay.firstName,"lastName":forDisplay.lastName,"gender":forDisplay.gender,"dob":forDisplay.dob,"photo":forDisplay.photo,"address":forDisplay.address,"street":forDisplay.street,"pincode":forDisplay.pincode,"email":forDisplay.email,"phone":forDisplay.phone,"hobbies":local.hobbieValues}>
    </cffunction>

    <cffunction name="deleteContactDetails" access='remote' returnFormat="json">
        <cfargument name="intContactId" type="numeric" required='true'>
        <cfquery name="deleteHobbie">
            delete from hobbies
            where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfquery name="deleteContactDetails">
            delete from contact
            where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn {"success":true}>
    </cffunction>

    <cffunction name="doLoginSOS" access="remote" returnType="query">
        <cfargument name="email" required="true" type="string">
        <cfquery name="checkLogin" datasource="DESKTOP-89AF345">
            select id,userName,password,email,fullName,img 
            from users
            where email=<cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn checkLogin>
    </cffunction>
    
    <cffunction  name="saveSOS" access="remote"  returnformat="json">
        <cfargument name = "email" required="true" returnType="string">
        <cfargument name = "fullName" required="true" returnType="string">
        <cfargument name = "img" required="true" returnType="string">
        <cfquery name="newSignUp" datasource="DESKTOP-89AF345">
            insert into users (fullName,email,img)
            values(
                <cfqueryparam value="#arguments.fullName#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.img#" cfsqltype="cf_sql_varchar">
            ) 
        </cfquery>
        <cfreturn {"success":true}>
    </cffunction>
</cfcomponent>