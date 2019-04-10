Import-Module -Name ./Build-POGL.ps1

Describe 'Get-CsvObjects' {
    It 'imports data without error' {
      $data = Get-CsvObjects './tests/raw_test.csv'
      $data[0]."[PO] Order Id" | Should -Be '8100000630'
    }
}

Describe 'Get-POGLHash' {
  It 'creates a hash even with duplicate keys' {
    $data = Get-POGLHash './tests/raw_test.csv'
  }
}
