$purchaseOrderHeader = "[PO] Order Id"
$generalLedgerHeader = "[PO]GL Account (GL Account Id)"
$date = Get-Date -UFormat "%Y%m%d"
$outputCsvFile = "Poggle_$date.csv"

if ($args.length -eq 1) {
  $content = $args[0]
}
else {
  $content = Read-Host -Prompt 'Drag the CSV with raw data into the window'
}

$rawData = Import-Csv -Path "$content"

function Get-PoggleMap
{
  $hash = @{}
  $rawData | ForEach-Object {
    $poid = $_.$purchaseOrderHeader
    $glid = $_.$generalLedgerHeader
    if (-not ($hash.ContainsKey($poid))) {
      $hash[$poid] = @($glid)
    }
    else {
      $hash[$poid] += $glid
    }
    $ary = $hash[$poid] | Select-Object -Unique
    $hash[$poid] = @($ary)
  }
  $hash
}

function Export-PoggleMap
{
  $dataHash = Get-PoggleMap
  $dataHash.GetEnumerator() | Select-Object -Property @{ N = $purchaseOrderHeader; E = { $_.Key } },
  @{ N = $generalLedgerHeader; E = { $_.Value } } | Export-Csv -NoTypeInformation $outputCsvFile
  (Get-Content $outputCsvFile) -replace "(\d)\s(\d)",'$1","$2' | Set-Content $outputCsvFile
}

if ((Resolve-Path -Path $MyInvocation.InvocationName).ProviderPath -eq $MyInvocation.MyCommand.Path) {
  Export-PoggleMap
  Write-Host "Poggle file is located at: $(Resolve-Path $outputCsvFile)"
  Start "" $(Resolve-Path $outputCsvFile)
}
