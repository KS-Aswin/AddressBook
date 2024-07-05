<cfif structKeyExists(session, "excelResultSave") and session.excelResultSave neq "">
    <cfheader name="Content-Disposition" value="attachment; filename=resultExcel.xlsx">
    <cfcontent file="#session.excelResultSave#" type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
</cfif>