Function New-PDAConfig {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    param(
        # [parameter(HelpMessage = "Template for default configuration")]
        # [ValidateSet("React", "RN", "Node")]
        # [Alias("T")]
        # [string] $Template,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Skips information input")]
        [Alias("Y")]
        [switch] $Yes,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Forces override of an existing config file")]
        [Alias("F")]
        [switch] $Force
    )
    Begin {
        $has_pda_file = get_pda_file $PWD
        if (-not $PSBoundParameters.ContainsKey('Verbose')) {
            $VerbosePreference = $PSCmdlet.SessionState.PSVariable.GetValue('VerbosePreference')
        }
        if (-not $PSBoundParameters.ContainsKey('Confirm')) {
            $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
        }
        if (-not $PSBoundParameters.ContainsKey('WhatIf')) {
            $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
        }
        # Write-Output ('[{0}] Confirm={1} ConfirmPreference={2} WhatIf={3} WhatIfPreference={4}' -f $MyInvocation.MyCommand, $Confirm, $ConfirmPreference, $WhatIf, $WhatIfPreference)
    }
    Process {
        if ($has_pda_file -and !$Force) {
            Write-Output 'Arquivo de configuracao PDA ja existente.'
            return
        }
        
        $settings = @{}
        if ($Yes) {
            $name = $(Split-Path -Path $pwd -Leaf)
            $files = @()
            $exclude = @()
            $env = @()
        }
        else {
            $name = Read-Host 'Informe o nome do projeto'
            $type = ''
            While ($type -eq '') {
                $type = Read-Host "Selecione um template de publicacao:
 1. Node
 2. React
 3. React Native / Electron
 4. DotNet

Informe o numero do template"
            }

            $files = @()
            $exclude = @()
            $env = @()
            $data = Confirm-Choice -PromptMessage 'Deseja adicionar ambientes? Esta configuracao podera ser modificada posteriormente.'
            if ($data) {
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
                    if ($useWS) { $client["windowsService"] = = Read-Host "Informe o nome do servico: " }
                
                    $env += $client
                    $addNew = Confirm-Choice -PromptMessage 'Deseja adicionar outro ambiente?'
                    if (!$addNew) { $exitData = '' }
                }
            }
            $data = Confirm-Choice -PromptMessage 'Deseja adicionar os arquivos a serem inclusos no publish? Esta configuracao podera ser modificada posteriormente.'
            if ($data) {
                $exitData = '.'
                while ($exitData -ne '') {
                    $file = Read-Host 'Informe o caminho do arquivo a ser adicionado.
Para cancelar, basta dar [Enter]'
                    if ($file -eq '') { 
                        $exitData = ''
                    }
                    else {
                    
                        $files += $(Resolve-Path -Path "$PWD\$file").Path 
                        # $files += if ($(Test-Path -Path $(Resolve-Path -Path $file).Path)) { $(Resolve-Path -Path $file).Path } else { $file }
                    }
                }
            }
        }
        

        # {
        #     "name": "teste",
        #     "files": [],
        #     "exclude": [],
        #     "env": [
        #         {
        #             "cliente": "13",
        #             "path": "",
        #             "type":"node | react | net"
        #             "iisSite": "HL.Admin.API",
        #             "scheduledTask": "[Inventario API] Homol",
        #             "WindowsService": "xxx"
        #         }
        #     ]
        # }
    
        $settings | Add-Member -type NoteProperty -name name -Value $name
        $settings | Add-Member -type NoteProperty -name files -Value $files
        $settings | Add-Member -type NoteProperty -name exclude -Value $exclude
        $settings | Add-Member -type NoteProperty -name env -Value $env
    
        if ($PSCmdlet.ShouldProcess("$($(Resolve-Path -Path $PWD).Path)\.pda", "Cria o arquivo .pda com as informacoes do projeto")) {
            New-Item -Type 'File' -Name '.pda' -Value $($settings | ConvertTo-Json) -Force:$true -Confirm:$false -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference | Out-Null
        }
    }
}
