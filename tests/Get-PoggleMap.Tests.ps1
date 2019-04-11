$here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
. "$here/../Get-PoggleMap.ps1" "$here/test.csv"

Describe 'Get-PoggleMap' {
  $data = Get-PoggleMap

  It 'creates a hash even with duplicate keys' {
    $data.ContainsKey('9780679735779') | Should -Be True
  }

  It 'creates a hash with keys and values as GL ids' {
    $data['9780679735779'] | Should -Be @('653000','610040')
  }
}
