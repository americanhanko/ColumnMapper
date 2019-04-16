Import-Module -Name ./"Invoke-PoggleMapper.psm1"
$poggleMap = Invoke-PoggleMapper -InputPath "tests/test.csv"

Describe 'Invoke-PoggleMapper' {
  It 'handles duplicate keys' {
    $poggleMap.ContainsKey('9780679735779') | Should -Be True
  }

  It 'handles duplicate values' {
    $poggleMap['9780679735779'] | Should -Be @('653000','610040')
  }
}
