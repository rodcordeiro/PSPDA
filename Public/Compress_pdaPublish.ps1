Function Compress-PDAPublish {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    param()
    Begin {
        $pda_path = get_pda_file $PWD
        if (-not $PSBoundParameters.ContainsKey('Verbose')) {
            $VerbosePreference = $PSCmdlet.SessionState.PSVariable.GetValue('VerbosePreference')
        }
        if (-not $PSBoundParameters.ContainsKey('Confirm')) {
            $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
        }
        if (-not $PSBoundParameters.ContainsKey('WhatIf')) {
            $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
        }
        
    }
    Process {
        if (!$pda_path) { 
            Write-Output 'Arquivo de configuracao PDA nao encontrado.'
            return
        }

        [PDAConfig]$data = get_project_data pda_path
        $Folder = "$($env:TEMP)\$($data.name)"
        if ($PSCmdlet.ShouldProcess("$Folder", "Criar pasta temporaria para centralizacao dos arquivos a serem compactados")) {
            New-Item -Type 'Directory' -Path $env:TEMP -Name $data.name  -Force:$true -Confirm:$false  -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference | Out-Null
        }

        
        if ($PSCmdlet.ShouldProcess($Folder, "Copiar os arquivos a serem compactados")) {
            Copy-Item -Path $data.files -Exclude $data.exclude -Destination $Folder -Confirm:$false -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference
        }
        
        New-Item -Type 'File' -Path $Folder -Name '.pda' -Value $($data | ConvertTo-Json) -Force:$true -Confirm:$false | Out-Null

        if ($PSCmdlet.ShouldProcess("$Folder\$($data.name).zip", "Criar um arquivo compactado ")) {
            Compress-Archive -Path "$Folder\*" -DestinationPath "$($(Resolve-Path -Path $PWD).Path)\$($data.name).zip" -Force:$true -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference
        }
        
    }
    End{
        if ($PSCmdlet.ShouldProcess("$Folder", "Remover pasta temoparia")) {
            Remove-Item -Path $Folder -Recurse -Force -Confirm:$false -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference
        }
    }
    
}