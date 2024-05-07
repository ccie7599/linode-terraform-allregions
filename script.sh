#!/bin/bash

# Start the region.tfvars file
echo -n "regions = [" >> region.tfvars

# Using the Linode API, extract region codes and start populating
# them into the region.tfvars file.
for i in `linode-cli regions list --format 'id' --text --no-headers`
# To ensure you're only using the newer regions, use this line instead:
# for i in `linode-cli regions list --format 'id' --text --no-headers | egrep '[a-z]{2}-[a-z]{3}$'`
do
    echo -n "\"$i\"," >> region.tfvars
done

# Close off the regions array and remove trailing comma
sed -i '' 's/,$/]/' region.tfvars

# Run Terraform 

terraform apply -auto-approve

# Create output file 

echo "[global]" > ansible.inv
terraform output ip_address | sed -n 's/^.*"\([0-9.]*\)".*$/\1/p' >> ansible.inv
