<cfcomponent>
    <cffunction  name="saveSignUp" access="remote"  returnformat="json">
        <cfargument name = "fullName" required="true" returnType="string">
        <cfargument name = "email" required="true" returnType="string">
        <cfargument name = "userName" required="true" returnType="string">
        <cfargument name = "password" required="true" returnType="string">
        <cftry>
            <cfquery name="newSignUp" datasource="DESKTOP-89AF345">
                insert into userAdmin (userName, password, email, fullName)
                values(
                    <cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar">,
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




    <cffunction  name = "checkUserExists" access="remote"  returnformat="json">
        <cfargument name = "userName" required="true" returnType="string">
        <cfquery name = "tableName" datasource="DESKTOP-89AF345">
            select userName
            from userAdmin
            where userName = <cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif tableName.recordCount>
            <cfreturn {"success":false}>
        <cfelse>
            <cfreturn {"success":true}>
        </cfif>
    </cffunction>
</cfcomponent>