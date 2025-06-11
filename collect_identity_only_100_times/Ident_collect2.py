from __future__ import print_function
import requests
import sys
import json


def getToken(host, clientId, clientSecret, username, password):
    response = requests.post(host + '/osp/a/idm/auth/oauth2/grant',
                             data="grant_type=password&username=" + username + "&password=" + password,
                             auth=(clientId, clientSecret))
    accessTokenResponse = response.json()
    accessToken = accessTokenResponse['access_token']
    return accessToken

def curateUser(host, accessToken):
#    url = host + '/api/policy/access/request/1'
    payload = '{}'
    url = '/api/dcs/identitySources/4/schedules'
    response = requests.post(host + url,
                            data=payload,
                            headers={'Authorization': 'bearer ' + accessToken,
                                     'Content-Type': 'application/json',
                                     'Accept': 'application/json'})
    return response.text

def curateAllUsers(host, accessToken):
#    for id in ids:
        response = curateUser(host, accessToken)
        print(response)

def main():
    if (len(sys.argv) != 6):
        print('usage: python ', sys.argv[0], "ip iac secret acorry pw")
        exit(0)

    # set input variables
    host = sys.argv[1]
    clientId = sys.argv[2]
    clientSecret = sys.argv[3]
    username = sys.argv[4]
    password = sys.argv[5]
    userDn = ""

#    city = 'my_city2'

    fullHost = "http://" + host + ":8080"
    token = getToken(fullHost, clientId, clientSecret, username, password)

    response = curateUser(fullHost, token)
    print(response)


if __name__== "__main__":
    main()
