# Poggle Mapper

Find all unique values in one column and dynamically create new columns for all unique values found in another.

## Getting Started

In PowerShell, run the following commands:

1. `Install-Module -Name InstallModuleFromGitHub -Force`
1. `Install-ModuleFromGitHub -GitHubRepo americanhanko/PoggleMapper`

## Usage

1. `Invoke-PoggleMapper -Path C:\path\to\data.csv`

## Getting Help

1. `Get-Help Invoke-PoggleMapper`

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

If pass the file to `Invoke-PoggleMapper` and you specify the `Names` and `FavoriteSport` columns, you'll get:

| Names | FavoriteSport |          |            |
|-------|---------------|----------|------------|
| Bob   | Basketball    | Baseball |            |
| Alice | Basketball    | Tennis   | Volleyball |
