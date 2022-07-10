Function PDAPublish {
    param(
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Site IIS")]
        [string] $IISSite,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Tarefa agendada do windows")]
        [string] $ScheduledTask,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Windows Service")]
        [string] $WindowsService,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Caminho da pasta temporária onde estão os arquivos a serem publicados")]
        [string] $Path,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Pasta para publicação dos arquivos")]
        [string] $Destination,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Template das ações a serem executadas")]
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
        if (!$Path) { 
            Write-Error 'E necessario informar o caminho dos dados'
            return
        }
        if (!$Destination) { 
            Write-Error 'E necessario informar o caminho de destino dos dados'
            return
        }
        if (!$Type) { 
            Write-Error 'E necessario informar quais ações devem ser tomadas'
            return
        }

        
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

