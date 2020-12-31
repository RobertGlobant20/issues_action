param([int]$issueNumber, [string]$issueTitle, [string]$issueDescription)

$json_object = @{ 
				Number = $issueNumber 
				Title = $issueTitle
				Description = $issueDescription
			} 

$json_string = ConvertTo-Json $json_object

Write-Output $json_string