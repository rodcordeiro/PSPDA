Function New-PDAConfig (
        [parameter(HelpMessage="Template for default configuration")]
        [ValidateSet("React","RN","Node")]
        [Alias("T")]
        [string] $Template,
        [parameter(ValueFromPipelineByPropertyName,HelpMessage="Skips information input")]
        [Alias("Y")]
        [switch] $Confirm,
        [parameter(ValueFromPipelineByPropertyName,HelpMessage="Forces creation of a new config file")]
        [Alias("F")]
        [switch] $Force
    ){
    $has_pda_file = get_pda_file $PWD
    if($has_pda_file -and !$Force){ 
        Write-Host 'Arquivo de configuracao PDA ja existente.'
        return
    }
    
    
    $settings = @{}
    if($confirm){
        $name = $(Split-Path -Path $pwd -Leaf)
        $files = @()
        $exclude = @()
        $env = @()
    } else {
        $name = Read-Host 'Informe o nome do projeto'
        $type = ''
        While($type -eq ''){
            $type = Read-Host "Selecione um template de publicacao:
 1. Node
 2. React
 3. React Native
 4. DotNet
 
 Choose one"
        }

        $files = @()
        $exclude = @()
        $env = @()
        $data = Confirm-Choice -PromptMessage 'Deseja adicionar ambientes? Esta configuracao podera ser modificada posteriormente.'
        if($data){
            $exitData = '.'
            while($exitData -ne ''){
                $client = @{}
                
                $client["cliente"] = Read-Host 'Informe o codigo do cliente'
                $client["path"] = Read-Host 'Informe o caminho para publicao' 
                $client["type"] = $type

                $useIIS = Confirm-Choice -PromptMessage 'Utiliza site no IIS? '
                if($useIIS){ $client["iisSite"] = Read-Host "Informe o site do IIS"}
                
                $useScheduleTask = Confirm-Choice -PromptMessage 'Utiliza tarefa agendada do windows? '
                if($useScheduleTask){ $client["scheduledTask"] = Read-Host "Informe o nome da tarefa"}
                
                $useWS = Confirm-Choice -PromptMessage 'Utiliza servico do windows? '
                if($useWS){ $client["winsowsService"] = = Read-Host "Informe o nome do servico: "}
                
                $env += $client
                $addNew = Confirm-Choice -PromptMessage 'Deseja adicionar outro ambiente?'
                if(!$addNew){$exitData=''}
            }
        }
        $data = Confirm-Choice -PromptMessage 'Deseja adicionar os arquivos para serem ? Esta configuracao podera ser modificada posteriormente.'
        if($data){
            $exitData = ''
            while($exitData -eq  ''){
                
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
    
    
    New-Item -Type 'File' -Name '.pda' -Value $($settings | ConvertTo-Json) -Force | Out-Null
    

}
