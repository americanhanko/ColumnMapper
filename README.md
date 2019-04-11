# Poggle Map

Quickly map Purchase Order (PO) numbers to General Ledger IDs (GL)

PO + GL = _"Poggle"_

## Instructions

1. Open PowerShell
2. Drag `Get-PoggleMap.ps1` into the window
3. Drag raw data exported as CSV into the window
4. Make sure `Get-PoggleMap.ps1` and the csv file are separated by a space.

For example:

```powershell
C:\PS>./Get-PoggleMap.ps1 ./tests/test.csv
```
