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
    $glid = $_.$poGLAccountHeader
    if (-not ($hash.ContainsKey($poid))) {
      $hash[$poid] = @($glid)
    }
    else {
      $hash[$poid] += $glid
    }
  }
  $hash
}
