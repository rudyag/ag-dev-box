# Install Keeper
winget install -e --id KeeperSecurity.KeeperDesktop

# Install Slack
winget install -e --id SlackTechnologies.Slack

# Install Microsoft 365 Apps for enterprise (Outlook)
winget install Microsoft.Office

# Install Clockify (optional)
winget install -e --id Clockify.Clockify

# Install Linear
winget install -e --id LinearOrbit.Linear

# Install AWS VPN Client
winget install -e --id Amazon.AWSVPNClient

# Instructions for VPN Connection
Write-Host "Follow the VPN Connection Instructions:"
Write-Host "1. Download the config file."
Write-Host "2. Load the profile in the AWS VPN Client app."

# Install VS Code
winget install -e --id Microsoft.VisualStudioCode

# Install Node.js
winget install OpenJS.NodeJS

# Install AWS CLI
winget install -e --id Amazon.AWSCLI

# Install Azure CLI
winget install -e --id Microsoft.AzureCLI

# Enable WSL
wsl --install
Write-Host "Follow WSL installation instructions: https://learn.microsoft.com/en-us/windows/wsl/install"

# Install Docker
winget install -e --id Docker.DockerDesktop

# Install Bruno
winget install --id=Bruno.Bruno -e

# Install DBeaver
winget install --id=dbeaver.dbeaver -e

# Install Python
winget install --id=Python.Python.3.12 -e

# Configure DevOps Profile for Pip
Write-Host "Configuring AWS SSO for DevOps Profile..."
aws sso login --sso-session agiliteksolutions
aws configure sso --profile devops
Write-Host "If you encounter a 'Region' issue, reach out to Gaurav to rename the region."

# Install Git
winget install --id=Git.Git -e

# Install Just
winget install --id=Casey.Just -e

# Install VS Code Extensions
code --install-extension eamodio.gitlens
code --install-extension ms-python.python
code --install-extension ms-python.debugpy
code --install-extension ms-python.vscode-pylance
code --install-extension nefrob.vscode-just-syntax

# Install Serverless Framework
npm install serverless@3 -g
serverless plugin install -n serverless-wsgi

Write-Host "All tools and configurations have been installed. Please follow any additional manual steps as needed."
