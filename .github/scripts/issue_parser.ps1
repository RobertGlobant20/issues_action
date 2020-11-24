
#This method parse the issue template located in github and returns a JSON structure with all the information (Title/Description)
function Get_Issue_Template
{
	#Receives as a parameter the template defined in the github repo or the template filled with the issue information
	param (
        $InputTemplateString
	)
	[System.Collections.ArrayList]$TemplateArray = @()

	#All the titles/questions in the github template should start with the characters ##, then this regex will get title
	$Questions = $InputTemplateString | Select-String -Pattern "##.*\n" -AllMatches

	for ($i = 0; $i -lt $Questions.Matches.Count; $i++) {
		$StartIndex = $Questions.Matches[$i].Index + $Questions.Matches[$i].Value.Length
		if (($i+1) -lt $Questions.Matches.Count){
			$EndIndex = $Questions.Matches[$i+1].Index
		}
		else {
			$EndIndex = $InputTemplateString.Length
		}	
		$TitleValue = $Questions.Matches[$i].Value -replace "`n","" -replace "`r",""
		$ContentValue = $InputTemplateString.Substring($StartIndex, $EndIndex - $StartIndex) -replace "`n","" -replace "`r",""
		$TemplateEntry = @{Title=$TitleValue; Content=$ContentValue}
		$TemplateArray.Add($TemplateEntry)
	}

	return $TemplateArray 
}


