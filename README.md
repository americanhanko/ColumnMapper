# ColumnMapper

Consolidate duplicate row values and create new columns from values in another.

## Getting Started

In PowerShell, run the following commands:

1. `Install-Module -Name InstallModuleFromGitHub -Force`
1. `Install-ModuleFromGitHub -GitHubRepo americanhanko/ColumnMapper`

## Usage

1. `Invoke-ColumnMapper -Path C:\path\to\data.csv`

## Getting Help

1. `Get-Help Invoke-ColumnMapper`

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

If pass the file to `Invoke-ColumnMapper` and you specify the **Names** and **FavoriteSport** columns, you'll get a new CSV file that looks like this:

| Names | FavoriteSport |          |            |
|-------|---------------|----------|------------|
| Bob   | Basketball    | Baseball |            |
| Alice | Basketball    | Tennis   | Volleyball |

The invocation in PowerShell would look like this:

```powershell
Invoke-ColumnMapper -Path C:\Users\americanhanko\People.csv -KeysHeader Names -ValuesHeader FavoriteSport
```

## Detailed Explanation

`ColumnMapper` finds all unique values in the column specified by the `KeysHeader` parameter and converts them to hash keys. When it finds a new key,
it asks for any values found in the column specified by the `ValuesHeader` parameter and adds them to a new array. It continues to add any new values
found in the `ValuesHeader` column to each corresponding array. Finally, we split the array into a comma-separated string so that it can be imported
easily into your favorite spreadsheet application.
