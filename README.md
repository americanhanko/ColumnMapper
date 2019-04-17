# ColumnMapper

Consolidate duplicate row values and create new columns for each unique value found in a corresponding column.

## Getting Started

Open PowerShell as Administrator and run the following commands:

1. `Install-Module -Name InstallModuleFromGitHub -Force`
1. `Install-ModuleFromGitHub -GitHubRepo americanhanko/ColumnMapper`

## Usage

### Basic

```powershell
Import-Module Invoke-ColumnMapper
Invoke-ColumnMapper -InputPath C:\path\to\data.csv
```

### Full Syntax

```powershell
Invoke-ColumnMapper [[-InputPath] <Object>] [[-KeysHeader] <Object>] [[-OutputPath] <Object>] [[-ValuesHeader] <Object>] [-NoExport] [-Open] [<CommonParameters>]
```

### Parameters

    -InputPath <Object>
        The absolute or relative path to the input CSV file.

    -KeysHeader <Object>
        Specifies the column name to search in for the row identifiers.
        ColumnMapper will use these values as the primary row identifiers.
        Defaults to '[PO] Order Id' for legacy purposes.

    -ValuesHeader <Object>
        Specifies the column name to search for unique values mapped to the row identifiers.
        ColumnMapper will take any value found in the first column and create new columns
        for each unique value found in this one. Defaults to '[PO]GL Account (GL Account Id)'
        for legacy purposes.

    -OutputPath <Object>
        Specifies the path to write the output CSV file to.
        Defaults to ColumnMap_YYYYMMDD.csv

    -Open [<SwitchParameter>]
        Opens the output CSV file.
        Defaults to false.

### Getting Help

As with most modules, you can use the `Get-Help` cmdlet. To see help for `Invoke-ColumnMapper`, run:

```powershell
Get-Help Invoke-ColumnMapper
```

## Example

Let's say you have the file **People.csv**:

| Names | FavoriteSport |
|-------|---------------|
| Bob   | Basketball    |
| Bob   | Baseball      |
| Alice | Basketball    |
| Alice | Tennis        |
| Alice | Volleyball    |
| Alice | Volleyball    |

Pass the file to `Invoke-ColumnMapper` and specify the **Names** and **FavoriteSport** columns, and you'll get a new CSV file that looks like this:

| Names | FavoriteSport |          |            |
|-------|---------------|----------|------------|
| Bob   | Basketball    | Baseball |            |
| Alice | Basketball    | Tennis   | Volleyball |

The invocation in PowerShell would look like this:

```powershell
PS C:\Users\americanhanko> Import-Module Invoke-ColumnMapper
PS C:\Users\americanhanko> Invoke-ColumnMapper -Path .\People.csv -KeysHeader Names -ValuesHeader FavoriteSport
Output file is here: C:\Users\americanhanko\ColumnMap_20190416.csv
```

## Detailed Explanation

`Invoke-ColumnMapper` finds all unique values in the column specified by the `KeysHeader` parameter and converts them to hash keys. When it finds a new key,
it asks for any values found in the column specified by the `ValuesHeader` parameter and adds them to a new array. It continues to add any new values
found in the `ValuesHeader` column to each corresponding array. Finally, we split the array into a comma-separated string so that it can be imported
easily into your favorite spreadsheet application.
