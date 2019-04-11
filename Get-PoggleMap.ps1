$purchaseOrderHeader = "[PO] Order Id"
$generalLedgerHeader = "[PO]GL Account (GL Account Id)"
$date = Get-Date -UFormat "%Y.%m.%d"
$outputCsvFile = "POGL_$date.csv"
$rawData = Import-Csv -Path $args[0]

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
}
