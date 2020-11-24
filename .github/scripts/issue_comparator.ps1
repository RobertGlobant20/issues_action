function Compare_Issue_Template($InputTemplateArray, $InputIssueFilledArray)
{
	[System.Collections.ArrayList]$ResultArrayComparison = @()

	ForEach ($TemplateSection in $InputTemplateArray)
	{
		$TitleCompareStatus = ""
		$ContentCompareStatus = ""
		ForEach ($IssueSection in $InputIssueFilledArray)
		{
			If ($IssueSection.Title -match $TemplateSection.Title)
			{								
				if ($IssueSection.Title -eq $TemplateSection.Title)
				{
					#Means that the title is the same than in the template
					$TitleCompareStatus = "Equal"
				}
				else 
				{
					#The title doesn't match the template then was updated (even when the case was changed)
					$TitleCompareStatus = "Updated"
				}	
			}
			else
			{
				#The title was not found the was deleted by the issue creator
				$TitleCompareStatus = "NotFound"
			}

			If ($IssueSection.Content -eq $TemplateSection.Content)
			{
				#The template content is the same than the issue content then is empty
				$ContentCompareStatus = "Empty"
			}
			else
			{
				#The issue content is different than the template then it was filled by the user
				$ContentCompareStatus = "Filled"
			}
		}
		$ResultEntry = @{Title=$TemplateSection.Title; Content=$TemplateSection.Content; TitleStatus=$TitleCompareStatus; ContentStatus=$ContentCompareStatus}
		$ResultArrayComparison.Add($ResultEntry)
	}

	return $ResultArrayComparison
}