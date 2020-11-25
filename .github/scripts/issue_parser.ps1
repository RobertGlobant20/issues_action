#This method parse the issue template located in github and returns a JSON structure with all the information (Title/Description)
#Receives as a parameter the template defined in the github repo or the template filled with the issue information
function Get_Parsed_Issue ($InputTemplateString)
{
	[System.Collections.ArrayList]$TemplateArray = @()

	#All the titles/questions in the github template should start with the characters ##, then this regex will get title
	$Questions = $InputTemplateString | Select-String -Pattern "##.*\n" -AllMatches
	#Write-Output $Questions.Matches.Count
	for ($i = 0; $i -lt $Questions.Matches.Count; $i++) {
		$StartIndex = $Questions.Matches[$i].Index + $Questions.Matches[$i].Value.Length
		if (($i+1) -lt $Questions.Matches.Count){
			$EndIndex = $Questions.Matches[$i+1].Index
		}
		else {
			$EndIndex = $InputTemplateString.Length
		}	
		$TitleValue = $Questions.Matches[$i].Value -replace "`n","" -replace "`r","" -replace "#"
		$ContentValue = $InputTemplateString.Substring($StartIndex, $EndIndex - $StartIndex) -replace "`n","" -replace "`r",""
		$null = $TemplateArray.Add(@{Title=$TitleValue; Content=$ContentValue})
	}
	Write-Output $TemplateArray -NoEnumerate
}