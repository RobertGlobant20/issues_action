
#--Params--
#issueTemplateFile: Name of the template file including extension (ex: ISSUE_TEMPLATE.md)
#issueContent: Body of the issue to be analyzed
#acceptableEmptyFields: Amount of fields from the template that can be missing information
#                       in the issue (1 if unspecified)
param([string]$issueTemplateFile, [string]$issueContent, [int]$acceptableEmptyFields=1)

#Loads the requiered functions
. .\issue_comparator.ps1
. .\issue_parser.ps1

#--Processing--
$issueTemplate = Get-Content -Raw -Path ..\$issueTemplateFile

#Parse the template and issue
$parsed_issue_content = Get_Parsed_Issue $issueContent
#$parsed_issue_content
$parsed_issue_template = Get_Parsed_Issue $issueTemplate
#$parsed_issue_template

#Compares the tempalte and issue
$comparation_result = Compare_Issue_Template $parsed_issue_template $parsed_issue_content
$comparation_result

$analysis_result = " "
[int]$missingFields = 0
#Checks for missing content on the comparator result and loads
#$analysis_result with the corresponding section title
foreach ($Section in $comparation_result)
{
    if(($Section.ContentStatus -eq "Empty") -or ($Section.ContentStatus -eq "NotFound")){
        $script:analysis_result = "$($script:analysis_result) - $($Section.Title)"
        $script:missingFields = $script:missingFields + 1
    }
}

#If no missing information was found then the issue is Valid
if(($analysis_result -eq " ") -or ($missingFields -lt $acceptableEmptyFields)) {$analysis_result = "Valid"}

#--Output--
$analysis_result
