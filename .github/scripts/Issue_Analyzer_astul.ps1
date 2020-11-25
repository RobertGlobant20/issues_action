
#--Params--
param([string]$issueTemplateFile, [string]$issueContent, [int]$acceptableEmptyFields=2)

#Loads the requiered functions
. .\issue_comparator.ps1
. .\issue_parser.ps1

#--Processing--
$issueTemplate = Get-Content -Raw -Path ..\$issueTemplateFile

#Parse the template and issue
$parsed_issue_content = Get_Parsed_Issue $issueContent
$parsed_issue_template = Get_Parsed_Issue $issueTemplate

#Compares the tempalte and issue
$comparation_result = Compare_Issue_Template $parsed_issue_template $parsed_issue_content

$analysis_result = " "
#Checks for missing content on the comparator result and loads
#$analysis_result with the corresponding section title
foreach ($Section in $comparation_result)
{
    if($Section.ContentStatus -eq "Empty"){
        $analysis_result = "$($analysis_result) - $($Section.Title)"
    }
}

#If no missing information was found then the issue is Valid
if($analysis_result -eq " ") {$analysis_result = "Valid"}

#--Output--
&$analysis_result
