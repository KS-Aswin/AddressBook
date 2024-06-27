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
        <cfargument name = "filePhoto" required="false" type="any">
        <cfargument name = "strAddress" required="true" type="string">
        <cfargument name = "strStreet" required="true" type="string">
        <cfargument name = "strEmailId" required="true" type="string">
        <cfargument name = "intPhoneNumber" required="true" type="string">
        <cfargument name = "intPinCode" required="true" type="string">
        <cfargument name = "hobbies" required="true" type="string">
        <cfset local.hobbyIdList = arguments.hobbies>
        <cfif arguments.intContactId GT 0>
            <cfquery name="updateContact" >
                update contact 
                set 
                    title = <cfqueryparam value="#arguments.strTitle#" cfsqltype="cf_sql_varchar">,
                    firstName = <cfqueryparam value="#arguments.strFirstName#" cfsqltype="cf_sql_varchar">,
                    lastName = <cfqueryparam value="#arguments.strLastName#" cfsqltype="cf_sql_varchar">,
                    gender = <cfqueryparam value="#arguments.strGender#" cfsqltype="cf_sql_varchar">,
                    dob = <cfqueryparam value="#arguments.strDate#" cfsqltype="cf_sql_date">,
                    address = <cfqueryparam value="#arguments.strAddress#" cfsqltype="cf_sql_varchar">,
                    street = <cfqueryparam value="#arguments.strStreet#" cfsqltype="cf_sql_varchar">,
                    email = <cfqueryparam value="#arguments.strEmailId#" cfsqltype="cf_sql_varchar">,
                    userId = <cfqueryparam value="#session.intUid#" cfsqltype="cf_sql_integer">,
                    pincode = <cfqueryparam value="#arguments.intPinCode#" cfsqltype="cf_sql_integer">,
                    phone = <cfqueryparam value="#arguments.intPhoneNumber#" cfsqltype="cf_sql_varchar">
                where 
                    contactId = <cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
            </cfquery>

            <cfquery name="existingHobbies">
                select hobbyId
                from hobbies 
                where contactId = <cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
            </cfquery>

            <cfset local.hobbiesIdList = ValueList(existingHobbies.hobbyId)>
            <cfloop list="#local.hobbyIdList#" index="hobby">
                <cfif not listFind(local.hobbiesIdList, hobby)>
                    <cfquery>
                        insert into hobbies (hobbyId, contactId)
                        values (
                            <cfqueryparam value="#hobby#" cfsqltype="cf_sql_integer">,
                            <cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
                        )
                    </cfquery>
                </cfif>
            </cfloop>

            <cfquery name="deleteHobbies">
                delete from hobbies
                where contactId = <cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
                and hobbyId NOT IN (
                    <cfqueryparam value="#local.hobbyIdList#" cfsqltype="cf_sql_integer" list="true">
                )
            </cfquery>

            <cfreturn {"success": "edited"}>
        <cfelse>
            <cfset local.path = ExpandPath("../assets/UploadImages/")>
            <cffile action="upload" destination="#local.path#" nameConflict="MakeUnique" filefield="filePhoto">
            <cfset local.profile = cffile.serverFile>

            <cfquery name="newContact" result="newContactResult" datasource="DESKTOP-89AF345">
                INSERT INTO contact (title, firstName, lastName, gender, dob, photo, address, street, email, phone, userId, pincode)
                VALUES (
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
            <cfloop list="#local.hobbyIdList#" index="hobby">
                <cfquery>
                    insert into hobbies (hobbyId, contactId)
                    values (
                        <cfqueryparam value="#hobby#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#local.newContactId#" cfsqltype="cf_sql_integer">
                    )
                </cfquery>
            </cfloop>
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
            and contactId! = <cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
            and userId = <cfqueryparam value="#session.intUid#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn contactExist>
    </cffunction>

    <cffunction  name = "checkExcelContactExists" access="remote"  returnFormat="json">
        <cfargument name = "excelFile" required="true" type="any">

        <cfset local.FileUploadPath=Expandpath("../assets/excelUpload/")>
        <cfset local.ResultFilePath = Expandpath("../assets/excelResult/")>

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
            <cfquery name="deleteFromResult">
                delete from resultTable
                where userId=<cfqueryparam value="#session.intUid#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfquery>
                delete from uploadResult
            </cfquery>
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
                <cfset local.pincode = spreadsheetData.Pincode> 
                <cfset local.hobbies = spreadsheetData.Hobbies>
                <cfset local.userId = session.intUid> 
                
                <cfset local.errorMsg = "">
                <cfset local.hobbyIdList = spreadsheetData.Hobbies>

                <cfquery name="hobbyList">
                    select hobbyName
                    from hobbyTable
                </cfquery>
                <cfset local.hobbyList=valueList(hobbyList.hobbyName)>
                <cfset local.count = 0>
                <cfloop list="#local.hobbyIdList#" index="hobby">
                    <cfif NOT ListFind(local.hobbyList, hobby)>
                        <cfset local.count+=1>
                    </cfif>
                </cfloop>
                <cfif local.count NEQ 0>
                    <cfset local.errorMsg &=','&'Invalid Hobbies'>
                </cfif>

                <cfif len(trim(local.title)) EQ 0 and len(trim(local.firstName)) EQ 0 and len(trim(local.lastName)) EQ 0 and len(trim(local.gender)) EQ 0 and len(trim(local.dob)) EQ 0 and len(trim(local.photo)) EQ 0 and len(trim(local.address)) EQ 0 and len(trim(local.street)) EQ 0 and len(trim(local.email)) EQ 0 and len(trim(local.phone)) EQ 0 and len(trim(local.pincode)) EQ 0 and len(trim(local.hobbies)) EQ 0 >
                    <cfset local.errorMsg &= "All fields are empty">
                <cfelse>
                    <cfif len(trim(local.title)) EQ 0>
                        <cfset local.errorMsg &= "Title Missing ,">
                    </cfif>

                    <cfif len(trim(local.firstName)) EQ 0>
                        <cfset local.errorMsg &= "FirstName Missing ,">
                    </cfif>

                    <cfif len(trim(local.lastName)) EQ 0>
                        <cfset local.errorMsg &= "LastName Missing ,">
                    </cfif>

                    <cfif len(trim(local.gender)) EQ 0>
                        <cfset local.errorMsg &= "Gender Missing ,">
                    </cfif>

                    <cfif len(trim(local.dob)) EQ 0>
                        <cfset local.errorMsg &= "DOB Missing ,">
                    <cfelse>
                        <cfif NOT isDate(local.dob)>
                            <cfset local.errorMsg &= "Invalid DOB ,">
                        </cfif>
                    </cfif>

                    <cfif len(trim(local.photo)) EQ 0>
                        <cfset local.errorMsg &= "Photo Missing ,">
                    </cfif>

                    <cfif len(trim(local.address)) EQ 0>
                        <cfset local.errorMsg &= "Street Missing ,">
                    </cfif>

                    <cfif len(trim(local.email)) EQ 0>
                        <cfset local.errorMsg &= "Email Missing ,">
                    <cfelse>
                        <cfif len(trim(local.email)) AND NOT isValid("email", local.email)>
                            <cfset local.errorMsg &= "Invalid Email ,">
                        </cfif>
                    </cfif>

                    <cfif len(trim(local.phone)) EQ 0>
                        <cfset local.errorMsg &= "Phone Missing ,">
                    <cfelse>
                        <cfif len(trim(local.phone)) AND (NOT isNumeric(local.phone) OR len(trim(local.phone)) NEQ 10)>
                            <cfset local.errorMsg &= "Invalid Phone ,">
                        </cfif>
                    </cfif>

                    <cfif len(trim(local.pincode)) EQ 0>
                        <cfset local.errorMsg &= "Pincode Missing ,">
                    <cfelse>
                        <cfif len(trim(local.pincode)) AND (NOT isNumeric(local.pincode) OR len(trim(local.pincode)) NEQ 6)>
                            <cfset local.errorMsg &= "Invalid Pincode ,">
                        </cfif>
                    </cfif>
                </cfif>
                
                <cfif len(local.errorMsg) EQ 0>
                
                    <cfquery name='checkContact'>
                        select 1 
                        from contact
                        where email=<cfqueryparam value="#spreadsheetData.Email#" cfsqltype="cf_sql_varchar">
                        AND userId=<cfqueryparam value="#session.intUid#" cfsqltype="cf_sql_integer">
                    </cfquery>

                    <cfset local.hobbyArray=ListToArray(spreadsheetData.Hobbies,',')>

                    <cfif checkContact.recordCount EQ 0>
                        <cfquery name='checkUserEmail'>
                            select 1 
                            from users 
                            where email=<cfqueryparam value="#spreadsheetData.Email#" cfsqltype="cf_sql_varchar">
                            and id=<cfqueryparam value="#session.intUid#" cfsqltype="cf_sql_integer">
                        </cfquery>
                        <cfif checkUserEmail.recordCount EQ 0>
                            <cfquery name="insertExcelValue" result="insertExcelResult">
                                insert into contact(title, firstName, lastName, gender,dob,photo,address,street,email,phone,userId,pincode)
                                values(
                                    <cfqueryparam value="#spreadsheetData.Title#" cfsqltype="cf_sql_varchar">,
                                    <cfqueryparam value="#spreadsheetData.FirstName#" cfsqltype="cf_sql_varchar">,
                                    <cfqueryparam value="#spreadsheetData.LastName#" cfsqltype="cf_sql_varchar">,
                                    <cfqueryparam value="#spreadsheetData.Gender#" cfsqltype="cf_sql_varchar">,
                                    <cfqueryparam value="#spreadsheetData.DOB#" cfsqltype="cf_sql_date">,
                                    <cfqueryparam value="#spreadsheetData.Photo#" cfsqltype="cf_sql_varchar">,
                                    <cfqueryparam value="#spreadsheetData.Address#" cfsqltype="cf_sql_varchar">,
                                    <cfqueryparam value="#spreadsheetData.Street#" cfsqltype="cf_sql_varchar">,
                                    <cfqueryparam value="#spreadsheetData.Email#" cfsqltype="cf_sql_varchar">,
                                    <cfqueryparam value="#spreadsheetData.Phone#" cfsqltype="cf_sql_varchar">,
                                    <cfqueryparam value="#session.intUid#" cfsqltype="cf_sql_integer">,
                                    <cfqueryparam value="#spreadsheetData.Pincode#" cfsqltype="cf_sql_varchar">
                                )
                            </cfquery>

                            <cfset local.id = insertExcelResult.generatedKey>
                            
                            <cfif arrayLen(local.hobbyArray) GT 0>
                                <cfloop index="i" from="1" to="#arrayLen(local.hobbyArray)#">
                                    <cfquery name="getHobbyId">
                                        select hobbyId 
                                        from hobbyTable
                                        where hobbyName=<cfqueryparam value="#local.hobbyArray[i]#" cfsqltype="cf_sql_varchar">
                                    </cfquery>
                                    <cfquery name="saveHobby" result="qryAddHobby">
                                        insert into hobbies(contactId,hobbyId)
                                        values(
                                            <cfqueryparam value="#local.id#" cfsqltype="cf_sql_integer">,
                                            <cfqueryparam value="#getHobbyId.hobbyId#" cfsqltype="cf_sql_integer">
                                        )
                                    </cfquery>
                                </cfloop>
                            </cfif>
                        </cfif>
                    <cfelse>
                        <cfquery name="getContactId">
                            select contactId
                            from contact
                            where email=<cfqueryparam value="#spreadsheetData.Email#" cfsqltype="cf_sql_varchar">
                            and userId=<cfqueryparam value="#session.intUid#" cfsqltype="cf_sql_integer">
                        </cfquery>
                        <cfquery name="updateContact" result="updateContactResult">
                            update contact 
                            set 
                                title = <cfqueryparam value="#spreadsheetData.Title#" cfsqltype="cf_sql_varchar">,
                                firstName = <cfqueryparam value="#spreadsheetData.FirstName#" cfsqltype="cf_sql_varchar">,
                                lastName = <cfqueryparam value="#spreadsheetData.LastName#" cfsqltype="cf_sql_varchar">,
                                gender = <cfqueryparam value="#spreadsheetData.Gender#" cfsqltype="cf_sql_varchar">,
                                dob = <cfqueryparam value="#spreadsheetData.DOB#" cfsqltype="cf_sql_date">,
                                address = <cfqueryparam value="#spreadsheetData.Address#" cfsqltype="cf_sql_varchar">,
                                street = <cfqueryparam value="#spreadsheetData.Street#" cfsqltype="cf_sql_varchar">,
                                email = <cfqueryparam value="#spreadsheetData.Email#" cfsqltype="cf_sql_varchar">,
                                userId = <cfqueryparam value="#session.intUid#" cfsqltype="cf_sql_integer">,
                                pincode = <cfqueryparam value="#spreadsheetData.Pincode#" cfsqltype="cf_sql_integer">,
                                phone = <cfqueryparam value="#spreadsheetData.Phone#" cfsqltype="cf_sql_varchar">
                            where 
                                contactId = <cfqueryparam value="#getContactId.contactId#" cfsqltype="cf_sql_varchar">
                        </cfquery>

                        <!--- <cfset local.result = "Updated">
                        <cfset local.id = getContactId.contactId> --->

                        <cfif arrayLen(local.hobbyArray) GT 0>
                            <cfquery name="checkHobby">
                                select ht.hobbyName AS hobbyName
                                from contact c
                                left JOIN hobbies h ON h.contactId = c.contactId
                                left JOIN hobbyTable ht ON ht.hobbyId = h.hobbyId
                                where c.contactId=<cfqueryparam value="#getContactId.contactId#" cfsqltype="cf_sql_integer">
                            </cfquery>  

                            <cfset local.hobbyList = listToArray(valueList(checkHobby.hobbyName))>

                            <cfloop array="#local.hobbyArray#" index="hobby">
                                <cfif NOT arrayFind(local.hobbyList, hobby)>
                                    <cfquery name="getHobbyId">
                                        select hobbyId 
                                        from hobbyTable
                                        where hobbyName=<cfqueryparam value="#hobby#" cfsqltype="cf_sql_varchar">
                                    </cfquery>
                                    <cfquery name="insertHobby">
                                        insert into hobbies(contactId,hobbyId)
                                            values(
                                                <cfqueryparam value="#getContactId.contactId#" cfsqltype="cf_sql_integer">,
                                                <cfqueryparam value="#getHobbyId.hobbyId#" cfsqltype="cf_sql_integer">
                                            )
                                    </cfquery>
                                </cfif>
                            </cfloop>
                            <cfquery name="deleteHobby">
                                delete from hobbies
                                where contactId =  <cfqueryparam value="#getContactId.contactId#" cfsqltype="cf_sql_integer">
                                and hobbyId NOT IN (
                                    select hobbyId 
                                    from hobbyTable
                                    where hobbyName in(
                                        <cfqueryparam value="#ArrayToList(local.hobbyArray)#" cfsqltype="cf_sql_varchar" list="true">
                                        )
                                    );
                            </cfquery>      
                        <cfelse>
                            <cfquery name="deleteHobby">
                                delete from hobbies
                                where contactId = <cfqueryparam value="#getContactId.contactId#" cfsqltype="cf_sql_integer">
                            </cfquery>
                        </cfif>
                    </cfif>
                <cfelse>
                    <cfset local.result = local.errorMsg>
                    <cfquery name="getContactId">
                            select contactId
                            from contact
                            where email=<cfqueryparam value="#spreadsheetData.Email#" cfsqltype="cf_sql_varchar">
                            and userId=<cfqueryparam value="#session.intUid#" cfsqltype="cf_sql_integer">
                        </cfquery>
                    <cfquery name="insertResult" result="resultInsert">
                        insert into resultTable(Title,FirstName,LastName,Gender,DOB,Photo,Address,street,Email,userId,pincode,Phone,Result)
                            values(
                                <cfqueryparam value="#spreadsheetData.Title#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#spreadsheetData.FirstName#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#spreadsheetData.LastName#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#spreadsheetData.Gender#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#spreadsheetData.DOB#" cfsqltype="cf_sql_date">,
                                <cfqueryparam value="#spreadsheetData.Photo#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#spreadsheetData.Address#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#spreadsheetData.Street#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#spreadsheetData.Email#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#session.intUid#" cfsqltype="cf_sql_integer">,
                                <cfqueryparam value="#spreadsheetData.Pincode#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#spreadsheetData.Phone#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#local.errorMsg#" cfsqltype="cf_sql_varchar">
                            )
                    </cfquery>
                </cfif> 
            </cfloop>
            <cfreturn {"success":"success"}>         
        </cfif>
    </cffunction>
   
   
    <cffunction name="getContactDetails" access="remote" returnFormat="json">
        <cfargument  name="intContactId" required="true">
        <cfquery name="forDisplay" datasource="DESKTOP-89AF345">
            select concat(c.title,'.',c.firstName,' ',c.lastName) as name,c.gender,c.dob,concat(c.address,', ',c.street) as address,c.pincode,c.email,c.phone ,c.photo ,STRING_AGG(ht.hobbyName, ',') 
            AS Hobby, STRING_AGG(ht.hobbyId,',') As HobbyId 
            from contact c
            left join hobbies h ON h.contactId = c.contactId
            left join hobbyTable ht ON h.hobbyId = ht.hobbyId
            where c.contactId = <cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
            group by c.title,c.firstName,c.lastName,c.address,c.gender,c.street,c.dob,c.pincode,c.email,c.phone ,c.photo,c.photo 
        </cfquery>
        <cfreturn {"success":true,"name":forDisplay.name,"gender":forDisplay.gender,"dob":forDisplay.dob,"address":forDisplay.address,"pincode":forDisplay.pincode,"email":forDisplay.email,"phone":forDisplay.phone,"photo":forDisplay.photo,"hobbies":forDisplay.Hobby,"hobbiesId":forDisplay.HobbyId}>
    </cffunction>
   
    <cffunction name="getHobbies" access="remote" returnFormat="json" output="false">
        <cfquery name="hobbyTable">
            SELECT hobbyId, hobbyName
            FROM hobbyTable
            ORDER BY hobbyName
        </cfquery>
        
        <cfset options = []>
        
        <cfloop query="hobbyTable">
            <cfset arrayAppend(options, '<option value="#hobbyTable.hobbyId#">#hobbyTable.hobbyName#</option>')>
        </cfloop>
        
        <cfreturn serializeJSON(arrayToList(options))>
    </cffunction>


    <cffunction name="getEditContactDetails" access="remote" returnFormat="json">
        <cfargument  name="intContactId" required="true">
        <cfquery name="getHobbies">
            SELECT ht.hobbyName,ht.hobbyId
            FROM hobbies h
            INNER JOIN hobbyTable ht ON h.hobbyId = ht.hobbyId
            WHERE h.contactId = <cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfset local.hobbieValues = "">
        <cfset local.hobbieIds = "">
        <cfloop query="getHobbies">
            <cfset local.hobbieValues = listAppend(local.hobbieValues, getHobbies.hobbyName)>
            <cfset local.hobbieIds = listAppend(local.hobbieIds, getHobbies.hobbyId)>
        </cfloop>

        <cfquery name="forDisplay" datasource="DESKTOP-89AF345">
            select contactId,title, firstName, lastName, gender,dob,photo,address,street,email,phone,userId,pincode
            from contact 
            where contactId=<cfqueryparam value="#arguments.intContactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn {"success":true,"title":forDisplay.title,"firstName":forDisplay.firstName,"lastName":forDisplay.lastName,"gender":forDisplay.gender,"dob":forDisplay.dob,"photo":forDisplay.photo,"address":forDisplay.address,"street":forDisplay.street,"pincode":forDisplay.pincode,"email":forDisplay.email,"phone":forDisplay.phone,"hobbies":local.hobbieValues,"hobbyId":local.hobbieIds}>
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