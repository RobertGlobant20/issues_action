param([int]$issueNumber, [string]$issueTitle, [string]$issueDescription)

$issueNumber = 12
$issueTitle = "Title"
$issueDescription = "Description"

$json_object = @{ 
				Number = $issueNumber 
				Title = $issueTitle
				Description = $issueDescription
			} 

$json_string = ConvertTo-Json -Compress $json_object

$json_string = $json_string -replace '"', '\"'

Write-Output $json_string

