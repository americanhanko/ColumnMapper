$moduleSettings  = @{
  ModuleVersion = '0.5.0'
  GUID = 'a6bac1c8-e74e-4136-86c0-9d092a32a8ce'
  Author = 'Eric Hanko'
  Copyright = '(c) erichanko. All rights reserved.'
  Description = 'Map Purchase Order numbers to General Ledger IDs.'
  FunctionsToExport = @(Invoke-PoggleMapper)
}

New-ModuleManifest @moduleSettings
