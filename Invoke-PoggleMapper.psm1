function Invoke-PoggleMapper {
  param(
    $GeneralLedgerHeader ='[PO]GL Account (GL Account Id)' ,
    $Open = $false,
    $OutputPath = "PoggleMap_$(Get-Date -UFormat "%Y%m%d").csv",
    $Path,
    $PurchaseOrderHeader = '[PO] Order Id'
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
