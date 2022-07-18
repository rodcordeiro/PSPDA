Function Invoke-PDAPublish {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'medium')]
    param(
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Arquivo a ser publicado")]
        [string] $File,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "O identificador do ambiente")]
        [Alias("e")]
        [string] $Env
    )
    Begin {
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
        if (!$File) {
            Write-Error 'E necessario informar o arquivo a ser publicado'
            return
        }
        if (!$Env) {
            Write-Error 'E necessario informar qual configuracao de ambiente a ser utilizada'
            return
        }

        $name = $($(Split-Path -Path $File -Leaf).Replace('.zip', ''))
        $Folder = "$($env:TEMP)\$($name)"

        if ($PSCmdlet.ShouldProcess("$Folder", "Criar pasta temporaria para descompactacao do arquivo")) {
            New-Item -Type 'Directory' -Path $env:TEMP -Name $data.name  -Force:$true -Confirm:$false  -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference | Out-Null
        }

        if ($PSCmdlet.ShouldProcess("$Folder", "Extracao dos arquivos")) {
            Expand-Archive -Path $File -DestinationPath $Folder  -Force:$true -Confirm:$false  -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference
        }

        [PDAConfig]$data = get_project_data $Folder
        $data | Out-DataTable
        $data.env
        [PDAEnvironmentConfig]$environment = $($data.env | Where-Object { $_.env -match $Env })

        if ($Environemnt.iisSite) {
            Stop-IISSite -Name $Environemnt.iisSite -Confirm:$false
        }
        if ($Environment.scheduledTask) {
            Stop-ScheduledTask -TaskName $Environment.scheduledTask -Confirm:$false
        }
        if ($Environment.windowsService) {
            Stop-Service -Name $Environment.windowsService -Confirm:$false -Force
        }
        Write-Output '1'
        $Environment
        Write-Output '2'
        $environment
        PDAPublish -Path $Folder -Destination $environment.path -Type $environment.type

    }
    End {
        if ($Environemnt.iisSite) {
            Start-IISSite -Name $Environemnt.iisSite -Confirm:$false
        }
        if ($Environment.scheduledTask) {
            Start-ScheduledTask -TaskName $Environment.scheduledTask -Confirm:$false
        }
        if ($Environment.windowsService) {
            Start-Service -Name $Environment.windowsService -Confirm:$false -Force
        }
        Remove-Item  -Path $Folder -Recurse -Force -Confirm:$false -Verbose:$VerbosePreference
        Remove-Item  -Path $File -Recurse -Force -Confirm:$false -Verbose:$VerbosePreference
    }
}