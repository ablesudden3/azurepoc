# generate-azdevops-secret.sh
#!/bin/bash

# Ensure the necessary environment variables are set
if [ -z "$AZP_TOKEN" ]; then
  echo "AZP_TOKEN environment variable is not set."
  exit 1
fi

if [ -z "$AZP_URL" ]; then
  echo "AZP_URL environment variable is not set."
  exit 1
fi

if [ -z "$AZP_POOL" ]; then
  echo "AZP_POOL environment variable is not set."
  exit 1
fi

# Encode the variables in base64
ENCODED_AZP_TOKEN=$(echo -n "$AZP_TOKEN" | base64 -w 0)
ENCODED_AZP_URL=$(echo -n "$AZP_URL" | base64 -w 0)
ENCODED_AZP_POOL=$(echo -n "$AZP_POOL" | base64 -w 0)

# Create the secret.yaml file
cat <<EOF > secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: azdevops
  namespace: default
type: Opaque
data:
  AZP_TOKEN: $ENCODED_AZP_TOKEN
  AZP_URL: $ENCODED_AZP_URL
  AZP_POOL: $ENCODED_AZP_POOL
EOF

echo "Secret file created successfully."
