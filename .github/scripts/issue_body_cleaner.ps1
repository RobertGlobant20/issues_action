param([string]$issueContent)

#Loads the requiered functions
. .\.github\scripts\issue_parser.ps1

function RemoveSpecialCharacters($InputString)
{
	$InputString = $InputString -replace '!\[.*\]\(.*\)', ''
	$InputString = $InputString -replace 'https?:\/\/.*?(\s|$)', ''

	$InputString = $InputString.Replace('`','')
	$InputString = $InputString.Replace("**_","")
	$InputString = $InputString.Replace("bumpy","")
	$InputString = $InputString.Replace('**_','')
	$InputString = $InputString.Replace('_**','')
	$InputString = $InputString.Replace('**','')
	$InputString = $InputString.Replace('#','')
	$InputString = $InputString.Replace('\r\n',' ')
	$InputString = $InputString.Replace('\n',' ')
	$InputString = $InputString.Replace('\"','')
	$InputString = $InputString.Replace('[','')
	$InputString = $InputString.Replace(']','')
	$InputString = $InputString.Replace('(Fill in here)','') 
	return $InputString
}

#$Request = "https://api.github.com/repos/DynamoDS/Dynamo/issues/11323"
#$Response = Invoke-WebRequest -URI $Request | 
#			ConvertFrom-Json | 
#			Select-Object number, title, body

#$issueContent = $Response.body

$TitleFilters = @("Dynamo version".ToLower(),
				 "Operating system".ToLower(),
				 "Stack Trace".ToLower())
#Parse the template and issue
$parsed_issue_content = Get_Parsed_Issue $issueContent $TitleFilters

#$issueContent -replace '', ''

$parsed_issue_content | ForEach-Object { 
	$content = $_['Content']
	$content = RemoveSpecialCharacters($content)
	Write-Output $content
}