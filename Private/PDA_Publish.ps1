
Function PDAPublish {
    param(
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Caminho da pasta temporária onde estão os arquivos a serem publicados")]
        [string] $Path,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Pasta para publicação dos arquivos")]
        [string] $Destination,
        [parameter(ValueFromPipelineByPropertyName, HelpMessage = "Template das ações a serem executadas")]
        [string] $Type
        
    )
    Begin {
        [Console]::OutputEncoding = New-Object System.Text.Utf8Encoding
        if (-not $PSBoundParameters.ContainsKey('Verbose')) {
            $VerbosePreference = $PSCmdlet.SessionState.PSVariable.GetValue('VerbosePreference')
        }
        $ConfirmPreference = $false
        if (-not $PSBoundParameters.ContainsKey('WhatIf')) {
            $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
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

        if ($Type -eq 1) {
            Write-Output "Running deploy of a node app"
            Remove-Item -Path $Destination -Exclude node_modules, yarn.lock, package-lock.json -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference 
            Copy-Item -Path "$Path\*" -Destination $Destination -Recurse -Force -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference 
            Set-Location $Path
            npm install
        }

        if ($Type -eq 2) {
            Write-Output "Running deploy of a React app"
            Remove-Item -Path $Destination -Exclude web.config -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference 
            Copy-Item -Path "$Path\*" -Destination $Destination -Recurse -Force -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference 
        }
        
        if ($Type -eq 3) {
            Write-Output "Running deploy of a RN / Electron app"
            Move-Item -Path "$Path\*" -Destination $Destination  -Force -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference 
        }
        if ($Type -eq 4) {
            Write-Output "Running deploy of a DotNet app"
            Move-Item -Path "$Path\*" -Destination $Destination  -Force -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference 
        }        
    }
    End {
        if ($IISSite) {
            Start-IISSite -Name $IISSite -Confirm:$false -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference 
        }
        if ($ScheduledTask) {
            Start-ScheduledTask -TaskName $ScheduledTask -Confirm:$false -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference 
        }
        if ($WindowsService) {
            Start-Service -Name $WindowsService -Confirm:$false -Force -WhatIf:$WhatIfPreference -Verbose:$VerbosePreference 
        }
    }
    
}

