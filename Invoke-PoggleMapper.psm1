function Invoke-PoggleMapper {
<#
   .SYNOPSIS
       Map Purchase Order numbers to General Ledger IDs.
   .PARAMETER InputPath
       Specifies the path to the input CSV file that contains duplicate PO and GL IDs.
   .PARAMETER Open
       Opens the output CSV file. Defaults to false.
   .PARAMETER OutputPath
       Specifies the path to write the output CSV file to. Only valid if the -Open parameter is used. Defaults to PoggleMap_YYYYMMDD.csv
   .PARAMETER KeysHeader
       Specifies the column name to search in for the row identifiers. PoggleMapper will use these values as the primary row identifiers.
   .PARAMETER ValuesHeader
       Specifies the column name to search for unique values mapped to the row identifiers. PoggleMapper will take any value found in the first column and create new columns for each unique value found in this one. #>

  param(
    $InputPath,
    $KeysHeader = '[PO] Order Id',
    $OutputPath = "PoggleMap_$(Get-Date -UFormat "%Y%m%d").csv",
    $ValuesHeader = '[PO]GL Account (GL Account Id)',
    [switch]$Open = $false
  )

  $dataHash = @{}
  $content = Import-Csv -Path $InputPath
  $content | ForEach-Object {
    $poid = $_.$KeysHeader
    $glid = $_.$ValuesHeader
    if ($dataHash.ContainsKey($poid)) {
      $dataHash[$poid] += $glid
    }
    else {
      $dataHash[$poid] = @($glid)
    }
    $ary = $dataHash[$poid] | Select-Object -Unique
    $dataHash[$poid] = @($ary)
  }

  if ($Open -eq $true) {
    $dataHash.GetEnumerator() | Select-Object -Property @{ N = $KeysHeader; E = { $_.Key } },
    @{ N = $ValuesHeader; E = { $_.Value } } | Export-Csv -NoTypeInformation $OutputPath
    (Get-Content $OutputPath) -replace "(\d)\s(\d)",'$1","$2' | Set-Content $OutputPath
  }
  else {
    $dataHash
  }
}

Export-ModuleMember -Function Invoke-PoggleMapper
