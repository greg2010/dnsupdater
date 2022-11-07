#!/bin/bash

# Fetch ipv4 public IP
IPV4=$(curl 'https://api.ipify.org' -s)
if [ -z "$IPV4" ]
then
  # If we failed to get ipv4 we exit
  echo "Failed to obtain IPv4!"
  exit 1
fi

echo "Obtained IPv4 IP ${IPV4}"

BODY_IPV4="
{\"rrsets\": [
  {
    \"name\": \"${PDNS_RECORD_NAME}\",
    \"type\": \"A\",
    \"ttl\": 60,
    \"changetype\": \"REPLACE\",
    \"records\": [ {\"content\": \"${IPV4}\", \"disabled\": false} ]
  }"

# Fetch ipv6 public IP
IPV6=$(curl 'https://api64.ipify.org' -s)
if [ -z "$IPV6" ]
then
  # If we failed to get ipv6 we continue
  echo "Failed to obtain IPv6!"
  BODY_IPV6="]
}
  "
else
  echo "Obtained IPv6 IP ${IPV6}"
  BODY_IPV6=",
  {
    \"name\": \"${PDNS_RECORD_NAME}\",
    \"type\": \"AAAA\",
    \"ttl\": 60,
    \"changetype\": \"REPLACE\",
    \"records\": [ {\"content\": \"${IPV6}\", \"disabled\": false} ]
  }]
}
"
fi

# Stitch together the URL and the body
URL="${PDNS_ADMIN_HOST}/api/v1/servers/${PDNS_SERVER}/zones/${PDNS_ZONE}"

BODY="${BODY_IPV4}${BODY_IPV6}"

# Send
echo "Sending PATCH ${BODY}to ${URL}"
curl -X 'PATCH' \
  $URL \
  -H 'accept: application/json' \
  -H "X-API-Key: ${PDNS_ADMIN_API_KEY}" \
  -H 'Content-Type: application/json' \
  --data "${BODY}" \
  --silent --show-error --fail