$poOrderHeader = "[PO] Order Id"

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

# [PO] PO Id                                        : EP64668
# [PO] Order Id                                     : 8100089500
# [PO]Ordered Date (Date)                           : 3/11/2019
# [PO]Requester (User)                              : Cara Larson
# [PO]GL Account (GL Account Id)                    : 651000
# [PO]Supplier (ERP Supplier)                       : BUNZL RETAIL SERVICES
# [PO]GL Account (GL Account Name)                  : Office Supplies
# [PO]Cost Center (Cost center ID)                  : 15
# [PO]Cost Center (Cost Center)                     : BLOOMINGTON
# [PO]Purchasing Company (Purchase Organization Id) : 1000
# [RCT]Date Received (Year)                         : 2019
# [RCT]Date Received (Quarter)                      : Q1
# [RCT]Date Received (Month)                        : Mar
# [RCT]Date Received (Date)                         : 3/19/2019
# sum(Amount Invoiced)                              : 0
# sum(Amount Left to Reconcile Total)               : 65.04
# sum(Amount Accepted)                              : 0
# sum(PO Spend)                                     : 65.04
