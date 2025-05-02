
param (
    [switch]$PreFlight,      # Run checks to show what foundational tools are missing
    [ValidateSet("1-foundation", "2-attended", "3-unattended", "4-extensions")]
    [string]$Install
)

$ErrorActionPreference = "Stop" # stop the script if we hit an error


# ================
# Command / Package Management
# ================
function Test-CommandExists() {
    Param (
        [Parameter(Mandatory=$true)]
        [string] $CommandName,

        [switch] $SuppressReturnValue
    )

    $cmd = Get-Command -ErrorAction SilentlyContinue $CommandName

    if (-Not($null -ne $cmd)) {
        Write-InfoLog "🟥 $CommandName is not available"
        if ($SuppressReturnValue) { return } else { return $false }
    }

    Write-InfoLog "🟩 $CommandName is available"
    if ($SuppressReturnValue) { return } else { return $true}
}


function Ensure-CommandAvailable {
    param (
        [Parameter(Mandatory=$true)]
        [string] $CommandName,

        [Parameter(Mandatory=$true)]
        [string] $PackageName,

        [string] $InstallCommand = "winget install --silent --no-upgrade -e --id",  # Default to winget

        [switch] $SuppressReturnValue
    )

    Write-DebugLog "Checking if '$CommandName' is available..."
    if ((Test-CommandExists -CommandName $CommandName)) {
        Write-InfoLog "⏩ '$PackageName' is already installed and usable via '$CommandName'."
        if ($SuppressReturnValue) { return } else { return $true }
    }

    Write-InfoLog "'$CommandName' not found. Running: $fullCommand"
    $fullCommand = "$InstallCommand $PackageName"
    Invoke-Expression $fullCommand

    Write-InfoLog "✅ '$PackageName' installation done."

    Write-Debug "Checking if '$CommandName' is available post-install..."
    if ((Test-CommandExists -CommandName $CommandName)) {
        Write-InfoLog "✅ '$CommandName' is available."
        if ($SuppressReturnValue) { return } else { return $true }
    } else {
        Write-ErrorLog "❌ '$CommandName' is not available. Check if package installation succeeded or if additional steps are needed."
        if ($SuppressReturnValue) { return } else { return $false }
    }
}



# ================
# LOGGING
# ================
function Write-Log {
    param (
        [Parameter(Mandatory)]
        [string]$Message,

        [ValidateSet("trace", "debug", "info", "warn", "error")]
        [string]$Level = "info"
    )

    # Log level priorities
    $levels = @{
        "trace" = 0
        "debug" = 1
        "info"  = 2
        "warn"  = 4
        "error" = 5
    }

    # Get log level from environment or default to 'info'
    $envLevel = $env:LOG_LEVEL
    if (-not $envLevel -or -not $levels.ContainsKey($envLevel.ToLower())) {
        $envLevel = "info"
    }

    $logLevelValue = $levels[$Level.ToLower()]
    $currentLevelValue = $levels[$envLevel.ToLower()]

    if ($logLevelValue -lt $currentLevelValue) {
        return  # Skip log message
    }

    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    $levelMarker = $Level.ToUpper()
    $logEntry = "[$timestamp] [$levelMarker]`t$Message"

    switch ($Level) {
        "trace" { Write-Host $logEntry -ForegroundColor Gray }
        "debug" { Write-Host $logEntry -ForegroundColor Cyan }
        "info"  { Write-Host $logEntry -ForegroundColor White }
        "warn"  { Write-Host $logEntry -ForegroundColor Yellow }
        "error" { Write-Error $logEntry }
    }
}

function Write-TraceLog {
    param (
        [Parameter(Mandatory)]
        [string]$Message
    )
    Write-Log -Message $Message -Level "trace"
}

function Write-DebugLog {
    param (
        [Parameter(Mandatory)]
        [string]$Message
    )
    Write-Log -Message $Message -Level "debug"
}

function Write-InfoLog {
    param (
        [Parameter(Mandatory)]
        [string]$Message
    )
    Write-Log -Message $Message -Level "info"
}

function Write-WarnLog {
    param (
        [Parameter(Mandatory)]
        [string]$Message
    )
    Write-Log -Message $Message -Level "warn"
}

function Write-ErrorLog {
    param (
        [Parameter(Mandatory)]
        [string]$Message
    )
    Write-Log -Message $Message -Level "error"
}



# ================
# MAIN
# ================
if ($PreFlight) {
    Write-Output "In PREFLIGHT CHECKS Mode. No installation or changes will be made."
    Test-CommandExists "pwsh" -SuppressReturnValue      # "Powershell is the preferred shell for hi on windows"
    Test-CommandExists "git" -SuppressReturnValue       # "Git for distributing the just recipes hi uses"
    Test-CommandExists "just" -SuppressReturnValue      # "Just does all the heavy lifting to execute recipes"
    Test-CommandExists "wsl" -SuppressReturnValue       # "WSL provides a Linux subsystem for docker and other development"
    Test-CommandExists "docker" -SuppressReturnValue    # "Docker takes care of running containers"
} 

switch ($Install) {
    "1-foundation" {
        Write-InfoLog "Installing foundational tools..."
        Ensure-CommandAvailable "pwsh" "Microsoft.PowerShell" -SuppressReturnValue
        Ensure-CommandAvailable "git" "Git.Git" -SuppressReturnValue
        Ensure-CommandAvailable "wsl" "wsl" -InstallCommand "wsl --install" -SuppressReturnValue
        Ensure-CommandAvailable "docker" "Docker.DockerDesktop" -SuppressReturnValue
    }
    "2-attended" {
        Write-InfoLog "Installing attended tools..."
        winget install -e --id Microsoft.VisualStudioCode
        
        Write-InfoLog "`nInstalling NodeJs..."
        winget install -e --id OpenJS.NodeJS
        
        Write-InfoLog "`nInstalling Clockify..."
        winget install -e --id Clockify.Clockify
        
        Write-InfoLog "`nInstalling AWSVPNClient..."
        winget install -e --id Amazon.AWSVPNClient
        
        Write-InfoLog "`nInstalling AWSCLI..."
        winget install -e --id Amazon.AWSCLI
        
        Write-InfoLog "`nInstalling AzureCLI..."
        winget install -e --id Microsoft.AzureCLI
    }
    "3-unattended" {
        Write-InfoLog "Installing unattended tools..."
        Write-InfoLog "`nInstalling Slack..."
        winget install -e --id SlackTechnologies.Slack

        Write-InfoLog "`nInstalling Linear..."
        winget install -e --id LinearOrbit.Linear

        Write-InfoLog "`nInstalling Bruno..."
        winget install -e --id=Bruno.Bruno

        Write-InfoLog "`nInstalling DBeaver..."
        winget install -e --id=dbeaver.dbeaver

        Write-InfoLog "`nInstalling Python.3.12..."
        winget install -e --id=Python.Python.3.12        
    }
    "4-extensions" {
        Write-InfoLog "Installing tool extensions..."
        Write-InfoLog "Configuring AWS SSO for DevOps Profile..."
        aws sso login --sso-session agiliteksolutions
        aws configure sso --profile devops
        Write-InfoLog "If you encounter a 'Region' issue, reach out to Gaurav to rename the region."
        
        
        # Install VS Code Extensions
        code --install-extension eamodio.gitlens
        code --install-extension ms-python.python
        code --install-extension ms-python.debugpy
        code --install-extension ms-python.vscode-pylance
        code --install-extension nefrob.vscode-just-syntax
        
        # Install Serverless Framework
        npm install serverless@3 -g
        serverless plugin install -n serverless-wsgi
    }
}
