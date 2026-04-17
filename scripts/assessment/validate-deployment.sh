#!/usr/bin/env bash
set -Eeuo pipefail

BASE_URL="${1:-}"
EXIT_CODE=0

if [[ -z "${BASE_URL}" ]]; then
  echo "Usage: bash scripts/assessment/validate-deployment.sh http://<host>:8000"
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "curl is required to validate the deployment."
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required to validate the JSON fields returned by /version and /status."
  echo "Install jq first, then run this script again."
  exit 1
fi

BASE_URL="${BASE_URL%/}"
VERSION_BODY=""
STATUS_BODY=""

print_header() {
  printf '\n==> %s\n' "$1"
}

pass() {
  printf '[PASS] %s\n' "$1"
}

fail() {
  printf '[FAIL] %s\n' "$1"
  EXIT_CODE=1
}

fetch_endpoint() {
  local name="$1"
  local path="$2"
  local body

  echo "Checking ${BASE_URL}${path}"
  body="$(curl --fail --silent --show-error "${BASE_URL}${path}")"
  echo "${body}"
  echo
  pass "${name} responded successfully."
  echo

  printf '%s' "${body}"
}

require_json_key() {
  local payload="$1"
  local key="$2"
  local endpoint_name="$3"

  if jq -e --arg key "${key}" 'has($key) and .[$key] != null and .[$key] != ""' >/dev/null 2>&1 <<<"${payload}"; then
    local value
    value="$(jq -r --arg key "${key}" '.[$key]' <<<"${payload}")"
    pass "${endpoint_name} includes ${key}: ${value}"
  else
    fail "${endpoint_name} is missing required key ${key}"
  fi
}

print_header "Checking HTTP endpoints"
fetch_endpoint "/health" "/health" >/dev/null
VERSION_BODY="$(fetch_endpoint "/version" "/version")"
STATUS_BODY="$(fetch_endpoint "/status" "/status")"

print_header "Checking required JSON fields"

require_json_key "${VERSION_BODY}" "app_version" "/version"
require_json_key "${VERSION_BODY}" "commit_sha" "/version"
require_json_key "${VERSION_BODY}" "image_tag" "/version"

require_json_key "${STATUS_BODY}" "status" "/status"
require_json_key "${STATUS_BODY}" "app_version" "/status"
require_json_key "${STATUS_BODY}" "commit_sha" "/status"
require_json_key "${STATUS_BODY}" "image_tag" "/status"
require_json_key "${STATUS_BODY}" "environment" "/status"
require_json_key "${STATUS_BODY}" "deployment_mode" "/status"

echo

if [[ "${EXIT_CODE}" -eq 0 ]]; then
  echo "Deployment validation completed successfully."
else
  echo "Deployment validation found one or more problems."
fi

exit "${EXIT_CODE}"
