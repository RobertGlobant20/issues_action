import requests
import shutil
import json

REPO = "issues_action"
#REPO = "Dynamo"
USER = "RobertGlobant20"
#USER = "DynamoDS"

url = "https://api.github.com/repos/"+USER+"/"+REPO+"/issues"
    
read_issues = 1
page_number = 1
pull_requests = []
issues = []

while read_issues > 0:
    req = requests.get(url, params={'page': str(page_number),  'per_page':'100'},)
    #print("Response Status:"+str(req.status_code))
    data  = json.loads(req.content)
    read_issues = len(data)   
    for issue in data:
        issue_type = "issue"
        if "pull_request" in issue:
            issue_type = "pull request"
            pull_requests.append(issue)
        else:
            issues.append(issue)
        #print(str(issue["number"])+ " " + issue_type)        
    page_number = page_number + 1
    #print(" ")

print("pull requests: "+str(len(pull_requests)))
print("issues: "+str(len(issues)))