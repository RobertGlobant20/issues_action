$description = @"
If this issue is with Dynamo for Revit, please post your issue on the [Dynamo for Revit Issues page](https://github.com/DynamoDS/DynamoRevit/issues).

If this issue is **not** a bug report or improvement request, please check the [Dynamo forum](https://forum.dynamobim.com/), and start a thread there to discuss your issue.

## Dynamo version

(Which version of Dynamo are you using? Go to Help > About if you're not sure.)

## Operating system

(e.g. Windows 7, Windows 8.1, etc)

## What did you do? 

(Fill in here)

## What did you expect to see?

(Fill in here)

## What did you see instead?

(Fill in here)
"@

# extracting captured groups
#"test1", "test2", "Add test" |
#    Select-String -Pattern "Add" |
#	Foreach-Object { $_.Matches } 
	
$results = $description | Select-String "\##" -AllMatches
$results.Matches.Count