Function PDAPublish {
    param(
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Site IIS")]
        [string] $IISSite,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Tarefa agendada do windows")]
        [string] $ScheduledTask,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Tarefa agendada do windows")]
        [string] $WindowsService,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Tarefa agendada do windows")]
        [string] $Path,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Tarefa agendada do windows")]
        [string] $Destination,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Tarefa agendada do windows")]
        [string] $Type
        
    )
    Begin {
        if (-not $PSBoundParameters.ContainsKey('Verbose')) {
            $VerbosePreference = $PSCmdlet.SessionState.PSVariable.GetValue('VerbosePreference')
        }
        $ConfirmPreference = $false
        $WhatIfPreference = $false

        if ($IISSite) {
            Stop-IISSite -Name $IISSite -Confirm:$false
        }
        if ($ScheduledTask) {
            Stop-ScheduledTask -TaskName $ScheduledTask -Confirm:$false
        }
        if ($WindowsService) {
            Stop-Service -Name $WindowsService -Confirm:$false -Force
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
        
        New-Item -Type 'Directory' -Path $env:TEMP -Name $data.name  -Force:$true -Confirm:$ConfirmPreference  -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference | Out-Null        
        Expand-Archive -Path $File -DestinationPath $Folder  -Force:$true -Confirm:$ConfirmPreference  -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference
        
        [PDAConfig]$data = get_project_data $Folder
        [PDAEnvironmentConfig]$environmet = $($data.env | Where-Object { $_.env -match $Env })
        Write-output $environmet
    }
    End {
        if ($IISSite) {
            Start-IISSite -Name $IISSite -Confirm:$false
        }
        if ($ScheduledTask) {
            Start-ScheduledTask -TaskName $ScheduledTask -Confirm:$false
        }
        if ($WindowsService) {
            Start-Service -Name $WindowsService -Confirm:$false -Force
        }
    }
    
}

