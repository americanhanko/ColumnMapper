$here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
. "$here/../Get-PoggleMap.ps1" "$here/test.csv"

Describe 'Get-PoggleMap' {
  $poggleMap = ConvertTo-PoggleMap

  It 'handles duplicate keys' {
    $poggleMap.ContainsKey('9780679735779') | Should -Be True
  }

  It 'handles duplicate values' {
    $poggleMap['9780679735779'] | Should -Be @('653000','610040')
  }
}
