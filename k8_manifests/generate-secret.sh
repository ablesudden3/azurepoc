# generate-secret.sh
#!/bin/bash

# Ensure the DATABASE_URL environment variable is set
if [ -z "$DATABASE_URL" ]; then
  echo "DATABASE_URL environment variable is not set."
  exit 1
fi

# Encode the DATABASE_URL in base64
ENCODED_DATABASE_URL=$(echo -n "$DATABASE_URL" | base64 -w 0)

# Create the secret.yaml file
cat <<EOF > secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-secret
  namespace: azure-poc
type: Opaque
data:
  DATABASE_URL: $ENCODED_DATABASE_URL
EOF

echo "Secret file created successfully."
