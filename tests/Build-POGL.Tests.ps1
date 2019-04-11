$here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
. "$here/../Build-POGL.ps1" "$here/raw_test.csv"

Describe 'Get-POGLHash' {
  It 'creates a hash even with duplicate keys' {
    $data = Get-POGLHash
    $data.ContainsKey('8100000630') | Should -Be True
  }
}

Describe 'Get-POGLHash' {
  It 'creates a hash with keys and values as GL ids' {
    $data = Get-POGLHash
    $data['8100000630'] | Should -Be @('653000','610040')
  }
}
