Set-Content twitterData.txt -value @"
Lee, Steve-@Steve_MSFT,2992
Lee Holmes-13000 @Lee_Holmes
Staffan Gustafsson-463 @StaffanGson
Tribbiani, Joey-@Matt_LeBlanc,463400
"@

# extracting captured groups
Get-ChildItem twitterData.txt |
    Select-String -Pattern "^(\w+) ([^-]+)-(\d+) (@\w+)" |
    Foreach-Object {
        $first, $last, $followers, $handle = $_.Matches[0].Groups[1..4].Value   # this is a common way of getting the groups of a call to select-string
        [PSCustomObject] @{
            FirstName = $first
            LastName = $last
            Handle = $handle
            TwitterFollowers = [int] $followers
        }
    }