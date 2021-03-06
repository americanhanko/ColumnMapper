Import-Module -Name "./ColumnMapper.psm1"
$map = Invoke-ColumnMapper -InputPath "tests/test.csv" -NoExport

Describe 'Invoke-ColumnMapper' {
  It 'handles duplicate keys' {
    $map.ContainsKey('9780679735779') | Should -Be True
  }

  It 'handles duplicate values' {
    $map['9780679735779'] | Should -Be @('653000','610040')
  }
}
