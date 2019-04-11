# Poggle Map

Quickly map Purchase Order (PO) numbers to General Ledger IDs (GL)

PO + GL = _"Poggle"_

## Instructions

1. Open PowerShell
2. Drag `Get-PoggleMap.ps1` into the PowerShell window
3. Drag CSV file exported from raw data into window
4. Make sure `Get-PoggleMap.ps1` and the csv file are separated by a space.

For example:

```powershell
PS C:\Users\americanhanko> C:\Users\americanhanko\poggle-map\Get-PoggleMap.ps1 C:\Users\americanhanko\poggle-map\tests\test.csv
```

5. Hit enter
6. You should see a new file named `Poggle_20190410.csv` in your working directory. Double-click it to open it in Excel.
