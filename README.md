# ColumnMapper

Consolidate duplicate row values and dynamically create new columns from corresponding values in another column from a CSV file.

## Getting Started

In PowerShell, run the following commands:

1. `Install-Module -Name InstallModuleFromGitHub -Force`
1. `Install-ModuleFromGitHub -GitHubRepo americanhanko/ColumnMapper`

## Usage

1. `Invoke-ColumnMapper -Path C:\path\to\data.csv`

## Getting Help

1. `Get-Help Invoke-ColumnMapper`

## Example

Let's say you have a file called `People.csv`:

| Names | FavoriteSport |
|-------|---------------|
| Bob   | Basketball    |
| Bob   | Baseball      |
| Alice | Basketball    |
| Alice | Tennis        |
| Alice | Volleyball    |
| Alice | Volleyball    |

If pass the file to `Invoke-ColumnMapper` and you specify the `Names` and `FavoriteSport` columns, you'll get a new CSV file that looks like this:

| Names | FavoriteSport |          |            |
|-------|---------------|----------|------------|
| Bob   | Basketball    | Baseball |            |
| Alice | Basketball    | Tennis   | Volleyball |
