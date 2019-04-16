function Invoke-ColumnMapper {
<#
   .SYNOPSIS
       Consolidate duplicate row values and create new columns from values in another.
    .DESCRIPTION
       ColumnMapper finds all unique values in the column specified by the KeysHeader parameter and converts them to hash keys. When it finds a new key,
       it asks for any values found in the column specified by the ValuesHeader parameter and adds them to a new array. It continues to add any new values
       found in the ValuesHeader column to each corresponding array. Finally, we split the array into a comma-separated string so that it can be imported
       easily into your favorite spreadsheet application.
   .PARAMETER InputPath
       The absolute or relative path to the input CSV file.
   .PARAMETER Open
       Opens the output CSV file. Defaults to false.
   .PARAMETER OutputPath
       Specifies the path to write the output CSV file to. Only valid if the -Open parameter is used. Defaults to ColumnMap_YYYYMMDD.csv
   .PARAMETER KeysHeader
       Specifies the column name to search in for the row identifiers. ColumnMapper will use these values as the primary row identifiers. Currently defaults to '[PO] Order Id' for legacy purposes.
   .PARAMETER ValuesHeader
       Specifies the column name to search for unique values mapped to the row identifiers. ColumnMapper will take any value found in the first column and create new columns for each unique value found in this one. Currently defaults to '[PO]GL Account (GL Account Id)' for legacy purposes. #> 

  param(
    $InputPath,
    $KeysHeader = '[PO] Order Id',
    $OutputPath = "ColumnMap_$(Get-Date -UFormat "%Y%m%d").csv",
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

Export-ModuleMember -Function Invoke-ColumnMapper
