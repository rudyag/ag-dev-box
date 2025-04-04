# Configure DevOps Profile for Pip
Write-Host "Configuring AWS SSO for DevOps Profile..."
aws sso login --sso-session agiliteksolutions
aws configure sso --profile devops
Write-Host "If you encounter a 'Region' issue, reach out to Gaurav to rename the region."


# Install VS Code Extensions
code --install-extension eamodio.gitlens
code --install-extension ms-python.python
code --install-extension ms-python.debugpy
code --install-extension ms-python.vscode-pylance
code --install-extension nefrob.vscode-just-syntax

# Install Serverless Framework
npm install serverless@3 -g
serverless plugin install -n serverless-wsgi