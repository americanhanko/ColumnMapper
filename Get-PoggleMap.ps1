$outputCsvFile = "Poggle_$(Get-Date -UFormat "%Y%m%d").csv"
$arguments = $args


if ($args.length -eq 1) {
  $content = $arguments[0]
}
else {
  $content = Read-Host -Prompt 'Drag the CSV with raw data into the window'
}

$rawData = Import-Csv -Path "$content"

function ConvertTo-PoggleMap
{
  $hash = @{}
  $purchaseOrderHeader = "[PO] Order Id"
  $generalLedgerHeader = "[PO]GL Account (GL Account Id)"
  $rawData | ForEach-Object {
    $poid = $_.$purchaseOrderHeader
    $glid = $_.$generalLedgerHeader
    if ($hash.ContainsKey($poid)) {
      $hash[$poid] += $glid
    }
    else {
      $hash[$poid] = @($glid)
    }
    $ary = $hash[$poid] | Select-Object -Unique
    $hash[$poid] = @($ary)
  }
  $hash
}

function Export-PoggleMap
{
  $dataHash = ConvertTo-PoggleMap
  $dataHash.GetEnumerator() | Select-Object -Property @{ N = $purchaseOrderHeader; E = { $_.Key } },
  @{ N = $generalLedgerHeader; E = { $_.Value } } | Export-Csv -NoTypeInformation $outputCsvFile
  (Get-Content $outputCsvFile) -replace "(\d)\s(\d)",'$1","$2' | Set-Content $outputCsvFile
}

$invocationName = $MyInvocation.InvocationName
$myCommand = $MyInvocation.MyCommand.Path

$invocationName = if ($invocationName -eq $null) { '' } else { $invocationName }
$invocationPath = if ($invocationName -ne '') { Resolve-Path -Path $invocationName } else { '' }

if ($invocationPath.ProviderPath -eq $myCommand) {
  Export-PoggleMap
  Write-Output "Poggle file is located at: $(Resolve-Path $outputCsvFile)"
  Start "$(Resolve-Path $outputCsvFile)"
}
