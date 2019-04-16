$moduleSettings  = @{
  ModuleVersion = '0.5.0'
  GUID = 'a6bac1c8-e74e-4136-86c0-9d092a32a8ce'
  Author = 'Eric Hanko'
  Copyright = 'Copyright (c) 2019 Eric Hanko. All rights reserved.'
  Description = 'Consolidate duplicate row values and create new columns from values in another.'
  FunctionsToExport = @(Invoke-ColumnMapper)
}

New-ModuleManifest @moduleSettings
