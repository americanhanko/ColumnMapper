$purchaseOrderHeader = "[PO] Order Id"
$generalLedgerHeader = "[PO]GL Account (GL Account Id)"
$outputCsvFile = 'export.csv'

function Build-POGL ($csv)
{
  Get-CsvObjects ($csv)
}

function Get-CsvObjects ($csv)
{
  Import-Csv ($csv)
}

function Get-POGLHash ($csv)
{
  $hash = @{}
  $data = Get-CsvObjects $csv
  $data | ForEach-Object {
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

function Export-POGLHash ($csv)
{
  $data = Get-POGLHash ($csv)
  $data.GetEnumerator() | Select-Object -Property @{ N = $purchaseOrderHeader; E = { $_.Key } },
  @{ N = $generalLedgerHeader; E = { $_.Value } } | Export-Csv -NoTypeInformation $outputCsvFile
}
