$purchaseOrderHeader = "[PO] Order Id"
$generalLedgerHeader = "[PO]GL Account (GL Account Id)"
$date = Get-Date -UFormat "%Y.%m.%d"
$outputCsvFile = "POGL_$date.csv"
$rawData = Import-Csv -Path $args[0]

function Get-POGLHash
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

function Export-POGLHash
{
  $dataHash = Get-POGLHash
  $dataHash.GetEnumerator() | Select-Object -Property @{ N = $purchaseOrderHeader; E = { $_.Key } },
  @{ N = $generalLedgerHeader; E = { $_.Value } } | Export-Csv -NoTypeInformation $outputCsvFile
}

function Build-FunctioningCsv {
  (Get-Content $outputCsvFile) -replace "(\d)\s(\d)",'$1","$2' | Set-Content $outputCsvFile
}

$name = $MyInvocation.InvocationName

if ((Resolve-Path -Path $name).ProviderPath -eq $MyInvocation.MyCommand.Path) {
  Export-POGLHash
  Build-FunctioningCsv
}
