function Invoke-PoggleMapper {
<#
   .SYNOPSIS
       Map Purchase Order numbers to General Ledger IDs.
   .DESCRIPTION
       The Invoke-PoggleMapper cmdlet
   .PARAMETER Path
       Specifies the path to the input CSV file that contains duplicate PO and GL IDs.
   .PARAMETER OutputPath
       Specifies the path to write the output CSV file to.
   .PARAMETER Open
       Opens the output CSV file.
   .PARAMETER PurchaseOrderHeader
       Specifies the header of the Purchase Order ID column. Defaults to "[PO] Order Id"
   .PARAMETER GeneralLedgerHeader
       Specifies the header of the General Ledger ID column. Defaults to "[PO]GL Account (GL Account Id)" #>

  param(
    $GeneralLedgerHeader = '[PO]GL Account (GL Account Id)',
    $OutputPath = "PoggleMap_$(Get-Date -UFormat "%Y%m%d").csv",
    $Path,
    $PurchaseOrderHeader = '[PO] Order Id',
    [switch]$Open = $false
  )

  $dataHash = @{}
  $content = Import-Csv -Path $Path
  $content | ForEach-Object {
    $poid = $_.$PurchaseOrderHeader
    $glid = $_.$GeneralLedgerHeader
    if ($dataHash.ContainsKey($poid)) {
      $dataHash[$poid] += $glid
    }
    else {
      $dataHash[$poid] = @($glid)
    }
    $ary = $dataHash[$poid] | Select-Object -Unique
    $dataHash[$poid] = @($ary)
  }

  if ($Open) {
    $dataHash.GetEnumerator() | Select-Object -Property @{ N = $PurchaseOrderHeader; E = { $_.Key } },
    @{ N = $GeneralLedgerHeader; E = { $_.Value } } | Export-Csv -NoTypeInformation $OutputPath
    (Get-Content $OutputPath) -replace "(\d)\s(\d)",'$1","$2' | Set-Content $OutputPath
  }
  else {
    $dataHash
  }
}

Export-ModuleMember -Function Invoke-PoggleMapper
