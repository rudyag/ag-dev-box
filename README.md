# ag-dev-box

## 1. Bootstrap Machine

Open up "Windows PowerShell" in the "Windows Terminal" app.

Run the following to install PowerShell 7, Git, WSL, Docker Desktop.

```powershell
iwr https://raw.githubusercontent.com/rudyag/ag-dev-box/refs/heads/main/bootstrap-machine.ps1 -useb | iex
```

Close the Terminal.

## 2. Make PowerShell 7 your default shell in Windows Terminal
- Open up the Windows Terminal app
- Go to Settings (Ctrl+,)
- Under "Startup > Default profile" Select "PowerShell" (instead of ""Windows PowerShell")
 
Close the Terminal. Now any time you open the Windows Terminal, it will default to PowerShell 7.

## 3. Install tools that need user confirmation
Open a new terminal instance with PowerShell 7.

Run the following to install tools that need user confirmation.

```powershell
iwr https://raw.githubusercontent.com/rudyag/ag-dev-box/refs/heads/main/install-tools-attended.ps1 -useb | iex
```

Close the Terminal.

## 4. Install unattended tools

Open a new terminal instance with PowerShell 7.

Run the following to install tools that do not need user confirmation.

```powershell
iwr https://raw.githubusercontent.com/rudyag/ag-dev-box/refs/heads/main/install-tools-unattended.ps1 -useb | iex
```

Close the Terminal.

## 5. Install and configure extensions

Run the following to install extensions and configure tools that need it.

```powershell
iwr https://raw.githubusercontent.com/rudyag/ag-dev-box/refs/heads/main/install-configure-extensions.ps1 -useb | iex
```

1. Configure your AWS profile:
- SSO session name: agiliteksolutions
- SSO start URL: https://d-906769f962.awsapps.com/start/
- SSO region: us-east-1
- SSO registration scopes: (accept the default, hit enter)

The AWS CLI will open the URL and ask you to sign in to SSO.
Follow the steps in the browser to the end.

![image](https://github.com/user-attachments/assets/1ce6b467-531b-4ba7-a906-e97395dc12f2)

---


Initial error message from powershell:
PS C:\Users\CatherineAddison> iwr https://raw.githubusercontent.com/rudyag/ag-dev-box/refs/heads/main/setup-dev-environment.ps1 -useb | iex
Failed in attempting to update the source: winget
The `msstore` source requires that you view the following agreements before using.
Terms of Transaction: https://aka.ms/microsoft-store-terms-of-transaction
The source requires the current machine's 2-letter geographic region to be sent to the backend service to function properly (ex. "US").

Do you agree to all the source agreements terms?
[Y] Yes  [N] No: y

This was the error for MS 365 (also had to say 'Yes' manually)

![image](https://github.com/user-attachments/assets/ca413470-0a64-413d-b4b2-8fd6a232e3f2)
