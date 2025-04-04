# ag-dev-box

## To run

```powershell
iwr https://raw.githubusercontent.com/rudyag/ag-dev-box/refs/heads/main/setup-dev-environment.ps1 -useb | iex
```


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
