#!/bin/bash

# Set default file locations and expiration time
CLIENT_ID_FILE="${HOME}/.superfacility/clientid.txt"
PRIVATE_KEY_FILE="${HOME}/.superfacility/priv_key.pem"
EXPIRATION_HOURS=24

# Parse optional arguments
while getopts ":c:k:e:" opt; do
  case $opt in
    c) CLIENT_ID_FILE="$OPTARG";;
    k) PRIVATE_KEY_FILE="$OPTARG";;
    e) EXPIRATION_HOURS="$OPTARG";;
    \?) echo "Invalid option -$OPTARG"; exit 1;;
  esac
done

# Read client ID from file
if [ ! -f "$CLIENT_ID_FILE" ]; then
  echo "Error: Client ID file not found: $CLIENT_ID_FILE"
  exit 1
fi
CLIENT_ID=$(cat "$CLIENT_ID_FILE")

# Create payload.json
EXPIRATION_TIMESTAMP=$(date --date "now + $EXPIRATION_HOURS hours" "+%s")
cat > payload.json <<EOF
{
  "iss": "$CLIENT_ID",
  "sub": "$CLIENT_ID",
  "aud": "https://oidc.nersc.gov/c2id/token",
  "exp": $EXPIRATION_TIMESTAMP
}
EOF

# Create client assertion using openssl
echo -n '{ "alg": "RS256" }' | openssl base64 -A | tr '/+' '_-' | tr -d '=' > head.b64
openssl base64 -in payload.json -A | tr '/+' '_-' | tr -d '=' > body.b64
cat head.b64 <(echo '.') body.b64 | tr -d "\n" > jwt.txt
openssl dgst -sha256 -sign "$PRIVATE_KEY_FILE" jwt.txt | openssl base64 -A | tr '/+' '_-' | tr -d '=' > sig.sha256.b64
ASSERTION=$(cat jwt.txt <(echo '.') sig.sha256.b64 | tr -d "\n")
rm payload.json

# Exchange client assertion for access token
export ACCESS_TOKEN=$(curl -s -XPOST -H "Content-Type:application/x-www-form-urlencoded"  -d "grant_type=client_credentials&client_assertion_type=urn%3Aietf%3Aparams%3Aoauth%3Aclient-assertion-type%3Ajwt-bearer&client_assertion=$ASSERTION"  https://oidc.nersc.gov/c2id/token | jq -r '.access_token')

echo $ACCESS_TOKEN
# Call SuperFacility API with access token
#curl -X POST "https://api.nersc.gov/api/v1.2/utilities/command/dtn01" -H "accept: application/json" -H "Authorization: Bearer $ACCESS_TOKEN" -H "Content-Type: application/x-www-form-urlencoded" -d "executable=hostname"