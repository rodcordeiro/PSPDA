Function get_pda_file([string]$Path) {
  if ($(Split-Path -Path $Path -Leaf) -ne '.pda') {
    if ($(Test-Path -Path "$Path\.pda") -ne $False) {
      return Resolve-Path -Path "$Path\.pda"
    }
    if ($(Test-Path -Path "$Path\..\.pda") -ne $False) {
      return Resolve-Path -Path "$Path\..\.pda"
    }
    if ($(Test-Path -Path "$Path\..\..\.pda") -ne $False) {
      return Resolve-Path -Path "$Path\..\..\.pda"
    }    
    if ($(Test-Path -Path "$Path\..\..\..\.pda") -ne $False) {
      return Resolve-Path -Path "$Path\..\..\..\.pda"
    }
    if ($(Test-Path -Path "$Path\..\..\..\..\.pda") -ne $False) {
      return Resolve-Path -Path "$Path\..\..\..\..\.pda"
    }
    return $false
  }
  return $Path
    
}


Function get_project_data {
  [OutputType([PDAConfig])]
  param(
    [parameter(ValueFromPipelineByPropertyName)][string]$Path
  )
  if (!$Path) {
    $Path = $PWD;
  }
  $file = get_pda_file($Path)
  if (!$file) {
    Write-Host "File .pda with project settings not found. The file must be placed on the root of the project or in a folder at maximum of 2 depth."
    return
  }
  $content = $(Get-Content -Path $file | ConvertFrom-Json)
  return $content
}