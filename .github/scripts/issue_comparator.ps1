function Compare_Issue_Template($InputTemplateArray, $InputIssueFilledArray)
{
	$AllIssuesArray = @()

	$TitleStatus = ""
	$ContentStatus = ""
	
	$InputTemplateArray | ForEach-Object { 
		
		#Write-Output $_.Title
		$TemplateEntry = $PSItem
		$IssueContent = ""
		ForEach($entry in $InputIssueFilledArray ) { 
			$IssueEntry = $entry
			$EntryTitle = $IssueEntry.Title.Trim()
			$TemplateTitle = $TemplateEntry.Title.Trim()
			$TemplateContent = $TemplateEntry.Content.Trim()
			$IssueContent = $IssueEntry.Content
			If ($EntryTitle -Contains $TemplateTitle)
			{								
				if ($EntryTitle -eq $TemplateTitle)
				{
					#Means that the title is the same than in the template
					$TitleStatus = "Equal"
					If (($IssueContent -eq $TemplateContent) -or ([string]::IsNullOrEmpty($IssueContent)))
					{
						#The template content is the same than the issue content then is empty
						$ContentStatus = "Empty"
					}
					else
					{
						#The issue content is different than the template then it was filled by the user
						$ContentStatus = "Filled"
					}	
					$IssueContent = $IssueContent				
					break
				}
				else 
				{
					#The title doesn't match the template then was updated (even when the case was changed)
					$TitleStatus = "Updated"
				}	
			}
			else
			{
				#The title was not found the was deleted by the issue creator
				$TitleStatus = "NotFound"
				$ContentStatus = "NotFound"
			}		
		}

		$AllIssuesArray += (@{ 
			Title=$TemplateEntry.Title;
			Content=$IssueContent;
			TitleStatus=$TitleStatus;
			ContentStatus=$ContentStatus;
		})
	}

	Write-Output $AllIssuesArray -NoEnumerate
}