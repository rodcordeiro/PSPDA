Function get_pda_file([string]$Path) {
    if ($(Split-Path -Path $Path -Leaf) -ne '.pda') {
        if (Test-Path -Path "$Path\.pda") {
            return Resolve-Path -Path "$Path\.pda"
        }
        if (Test-Path -Path "..\$Path\.pda") {
            return Resolve-Path -Path "$Path\.pda"
        }
        $folders = $(Get-ChildItem "$Path\*" -Depth 0 -Directory)
        $folders | ForEach-Object {
            $f = "$Path\$_"
            if (Test-Path -Path "$f\.pda") {
                
                return Resolve-Path -Path "$f\.pda"
            }
            $folders2 = $(Get-ChildItem "$f\*" -Depth 0 -Directory)
            $folders2 | ForEach-Object {
                if (Test-Path -Path "$f\$_\.pda") {
                    
                    return Resolve-Path -Path "$f\$_\.pda"
                }               
            
            }
        }
    }
    else {
        return Resolve-Path -Path "$Path"
    }
    
}

Function get_project_data {
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
    $content = Get-Content -Path $file 
    return $content
}