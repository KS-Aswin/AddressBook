<cfif structKeyExists(session, "excelResultSave") and session.excelResultSave neq "">
    <cfheader name="Content-Disposition" value="attachment; filename=excelDataResult.xlsx">
    <cfcontent file="#session.excelResultSave#" type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
</cfif>