#!/bin/bash

# Create a region file by scanning linode API for all available regions

linode-cli  regions list --format 'id' --text --no-headers > input.txt

#


# Read the words from the input file into an array
words=()
while IFS= read -r line; do
    # Remove leading and trailing whitespaces
    word=$(echo "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    # Add the word to the array
    words+=("$word")
done < input.txt
					
# Join the words with quotes and commas
formatted=$(printf "\"%s\"," "${words[@]}")

# Remove the trailing comma
formatted=${formatted%,}

# Print the array
echo "regions = [$formatted]" > region.tfvars

# Run Terraform 

terraform apply -auto-approve

# Create output file 

echo "[global]" > ansible.inv
terraform output ip_address | sed -n 's/^.*"\([0-9.]*\)".*$/\1/p' >> ansible.inv
