#!/bin/bash

# Update package index and install necessary packages
sudo apt-get update
sudo apt-get install -y apt-transport-https gnupg2 curl

# Download and install kubectl
curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH

# Configure AWS EKS kubeconfig
aws eks update-kubeconfig --region us-east-1 --name pc-eks

# Download and install eksctl
curl --silent --location 'https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz' | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# Install AWS CLI
sudo apt-get install -y awscli

# Configure AWS CLI with access keys
echo "Enter your AWS Access Key ID:"
read aws_access_key_id
echo "Enter your AWS Secret Access Key:"
read aws_secret_access_key

aws configure set aws_access_key_id $aws_access_key_id
aws configure set aws_secret_access_key $aws_secret_access_key
aws configure set default.region us-east-1

# Export necessary environment variables
export AWS_ACCESS_KEY_ID=$aws_access_key_id
export AWS_SECRET_ACCESS_KEY=$aws_secret_access_key
export AWS_DEFAULT_REGION=us-east-1

echo "AWS CLI configured successfully."

