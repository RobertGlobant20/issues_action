
. .\.github\scripts\issue_comparator.ps1
. .\.github\scripts\issue_parser.ps1

$Request = "https://api.github.com/repos/DynamoDS/Dynamo/issues/7231"
$Response = Invoke-WebRequest -URI $Request | 
			ConvertFrom-Json | 
			Select-Object number, title, body

$InputString = $Response.body


$TextIssueFilled = $InputString
$TextIssueTemplate = Get-Content -Raw -Path ".\.github\ISSUE_TEMPLATE.MD"

$ArrayIssueTemplate = Get_Issue_Template $TextIssueTemplate
$ArrayIssueFilled = Get_Issue_Template $TextIssueFilled

#$ArrayIssueTemplate
#$ArrayIssueFilled 
#Parameters: Template, String
$ArrayComparisonResult = Compare_Issue_Template $ArrayIssueTemplate, $ArrayIssueFilled

#$ArrayComparisonResult
$ArrayComparisonResult