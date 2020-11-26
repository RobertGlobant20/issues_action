
. .\.github\scripts\issue_comparator.ps1
. .\.github\scripts\issue_parser.ps1

$Request = "https://api.github.com/repos/DynamoDS/Dynamo/issues/11279"
$Response = Invoke-WebRequest -URI $Request | 
			ConvertFrom-Json | 
			Select-Object number, title, body


$InputString = "## Dynamo version
(Which version of Dynamo are you using? Go to Help > About if you're not sure.)

## Operating system
(e.g. Windows 7, Windows 8.1, etc)

## What did you do? 
(Fill in here)
## What did you expect to see?

## What did you see instead?

"
$InputString = $Response.body

$TextIssueFilled = $InputString
$TextIssueTemplate = Get-Content -Raw -Path ".\.github\ISSUE_TEMPLATE.MD"

$ArrayIssueTemplate = Get_Parsed_Issue $TextIssueTemplate
$ArrayIssueFilled = Get_Parsed_Issue $TextIssueFilled

$ArrayComparisonResult = Compare_Issue_Template $ArrayIssueTemplate $ArrayIssueFilled

$ArrayComparisonResult | ForEach-Object { 
	$_
	Write-Output "`n"
}
