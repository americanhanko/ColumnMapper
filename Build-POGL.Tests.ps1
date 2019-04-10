$here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
. $here\Build-POGL.ps1

Describe 'Get-CsvObjects' {
    It 'imports data without error' {
      $data = Get-CsvObjects './raw_test.csv'
      $data[0]."[PO] Order Id" | Should -Be '8100000630'
    }
}

Describe 'Get-POGLHash' {
  It 'creates a hash even with duplicate keys' {
    $data = Get-POGLHash './raw_test.csv'
  }
}
