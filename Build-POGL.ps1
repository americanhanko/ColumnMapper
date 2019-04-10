# $poOrderHeader = "[PO] Order Id"

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
  $data = Get-CsvObjects ($csv)
  $data | ForEach-Object {
    $poid = $_.$poOrderHeader
    if (-Not ($hash.ContainsKey($poid))) {
      $hash[$poid] = @()
    }
  }
  $hash
}
