$poOrderHeader = "[PO] Order Id"
$poGLAccountHeader = "[PO]GL Account (GL Account Id)"

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
    $poid = $_.$poOrderHeader
    if (-not ($hash.ContainsKey($poid))) {
      $hash[$poid] = @()
    }
    # else {
    #   $hash[$poid].Add($_.$poGLAccountHeader)
    # }
  }
  $hash
}
