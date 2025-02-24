import requests
import sys
import json

if (len(sys.argv) != 4):
    print('usage: python ', sys.argv[0], "HOST&Port Tenant_ID Password")
    print
    print('example: ' "python creatUser_ilm.py http://myilmserver.qalab.cam.novell.com:9888 MY_TENANT_ID MY_ILM_ADMIN_PASSWORD")
    print("You need to have the group_data.json file in this same dir!")
    exit(0)

host = sys.argv[1]
tenant = sys.argv[2]
password = sys.argv[3]

url = host + "/v2/ilm/ds/login"

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:130.0) Gecko/20100101 Firefox/130.0",
    "Accept": "application/json, text/plain, */*",
    "Accept-Language": "en-US,en;q=0.5",
    "Accept-Encoding": "gzip, deflate",
    "Content-Type": "text/plain",
    "Origin": host,
    "Connection": "keep-alive",
    "Referer": host + "/ilm/",
    "Priority": "u=0"
}

data = {
    "type": "user",
    "tenant": tenant,
    "password": password
}

response = requests.post(url, headers=headers, json=data)

def extract_token(response):
    token = response.json().get('anti_xsrf_token')
    return token

token = extract_token(response)
print(token)

url = host + "/v2/ilm/ds/Groups"

# Load user data from external file
with open('group_data.json') as f:
    group_data = json.load(f)

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:130.0) Gecko/20100101 Firefox/130.0",
    "Accept": "application/json, text/plain, */*",
    "Accept-Language": "en-US,en;q=0.5",
    "Accept-Encoding": "gzip, deflate",
    "X-CSRF-Token": token,
    "Content-Type": "application/json",
    "Origin": host,
    "Connection": "keep-alive",
    "Referer": host + "/ilm/",
    "Cookie": "IR=6b2c78fb-326e-43c8-bdd4-36394fdbbeb7",
    "Priority": "u=0"
}
def getImportFromFile(importFile):
    with open(importFile) as json_file:
        data = json.load(json_file)
    return data

#data = getImportFromFile(importFile)
print (data)


response = requests.post(url, headers=headers, json=group_data)

print(response)

if response.status_code > 201:
    print("Failed")
elif response.status_code == 201:
    print("Success!")
    print(response.json())
elif response.status_code == 401:
    print("Authentication failed. Check your credentials.")
else:
     print("An error occurred:", response.status_code)

