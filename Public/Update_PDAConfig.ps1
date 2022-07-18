
Function Update-PDAConfig {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    param(
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Atualiza o nome do projeto")]
        [string] $Name,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Atualiza a lista de arquivos a serem inclusos")]
        [Array] $Files,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Atualiza a lista ed arquivos a serem excluídos da build")]
        [Array] $Exclude,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Adiciona um novo ambiente")]
        [PDAEnvironmentConfig] $Environment,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Define se as informações devem ser inseridas de forma complementar ou substituir completamente os dados existetes.")]
        [Switch] $Append,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Adiciona uma nova configuração de ambiente de forma interativa.")]
        [Switch] $NewEnv

    )
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
        $data = get_project_data pda_path
        
    
        if ($Name) {
            $data.name = $Name
        }
    
        if ($Files) {
            if ($Append) {
                $data.files += $Files
            }
            else {
                $data.files = $Files
            }
        }

        if ($Exclude) {
            if ($Append) {
                $data.exclude += $Exclude
            }
            else {
                $data.exclude = $Exclude
            }
        }
        if ($Environment) {
            if ($Append) {
                $data.env += $Environment
            }
            else {
                $data.env = @($Environment)
            }
        
        }
        if ($NewEnv) {
            $env = @()
            $exitData = '.'
            while ($exitData -ne '') {
                $client = @{}

                $client["env"] = Read-Host 'Informe o nome da configuracao de ambiente (Exemplo: dev,prd,hml,teste,etc.)'
                $client["path"] = Read-Host 'Informe o caminho para publicao' 
                $client["type"] = $type

                $useIIS = Confirm-Choice -PromptMessage 'Utiliza site no IIS? '
                if ($useIIS) { $client["iisSite"] = Read-Host "Informe o site do IIS" }
            
                $useScheduleTask = Confirm-Choice -PromptMessage 'Utiliza tarefa agendada do windows? '
                if ($useScheduleTask) { $client["scheduledTask"] = Read-Host "Informe o nome da tarefa" }
            
                $useWS = Confirm-Choice -PromptMessage 'Utiliza servico do windows? '
                if ($useWS) { $client["winsowsService"] = = Read-Host "Informe o nome do servico: " }
            
                $env += $client
                $addNew = Confirm-Choice -PromptMessage 'Deseja adicionar outro ambiente?'
                if (!$addNew) { $exitData = '' }
            }
            $data.env += $env
            
        }

        New-Item -Type 'File' -Path $(Split-Path -Path $pda_path.Path -Parent) -Name '.pda' -Value $($data | ConvertTo-Json) -Force:$true -Confirm:$ConfirmPreference -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference | Out-Null
    }
}
