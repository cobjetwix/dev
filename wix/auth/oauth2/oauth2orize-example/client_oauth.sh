#!/bin/bash

COOKIE_TMP_FILE=".tmp_cookie"

USER_EMAIL="foo@example.com"
USER_PASSWORD="123"

CLIENT_ID="111111111111111111111111"
CLIENT_SECRET="abc123"
REDIRECT_URI="http://localhost:8888"

# Remove tmp cookies
rm -rf "$COOKIE_TMP_FILE"

# LOGIN
LOGIN=$(curl http://localhost:8888/login -b $COOKIE_TMP_FILE -c $COOKIE_TMP_FILE -d "email=$USER_EMAIL&password=$USER_PASSWORD" --silent)
#echo $LOGIN
#exit 1

# Parse user_id from login
USER_ID=$(echo $LOGIN | grep -Po '(?<="id": ")[^"]*')
#echo $USER_ID
#exit 1

# AUTHORIZATION
AUTHORIZATION=$(curl -b $COOKIE_TMP_FILE "http://localhost:8888/authorize/?client_id=$CLIENT_ID&response_type=code&redirect_uri=$REDIRECT_URI" --silent)
echo $AUTHORIZATION

exit 1

TRANSACTION_ID=$(echo $AUTHORIZATION | grep -Po '(?<="transactionID": ")[^"]*')
echo $TRANSACTION_ID

# Workaround to parse code
WORKAROUND_CODE=$(curl http://localhost:8888/authorize/decision -b $COOKIE_TMP_FILE -d "transaction_id=$TRANSACTION_ID&client_id=$CLIENT_ID" --silent)
echo $WORKAROUND_CODE
#CODE=$(echo $WORKAROUND_CODE | grep -Po '(?<=code\=)[^=]*')

# Token
TOKEN=$(curl http://localhost:8888/token -d "code=$CODE&client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET&redirect_uri=$REDIRECT_URI&grant_type=authorization_code" --silent)
echo $TOKEN
#ACCESS_TOKEN=$(echo $TOKEN | grep -Po '(?<="access_token":")[^"]*')

# Get protected resource
echo $(curl -b $COOKIE_TMP_FILE -H "Authorization: Bearer $ACCESS_TOKEN" -v "http://localhost:8888/info" --silent)
# echo $(curl -b $COOKIE_TMP_FILE -v "http://localhost:8888/info/?access_token=$ACCESS_TOKEN" --silent)

# Logout
echo $(curl http://localhost:8888/logout -b $COOKIE_TMP_FILE -d "" --silent)
rm $COOKIE_TMP_FILE
