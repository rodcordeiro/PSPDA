@{
    AliasesToExport      = @('New-PDAConfig')
    Author               = 'Rodrigo Cordeiro (http://rodcordeiro.com.br)'
    CmdletsToExport      = @()
    CompanyName          = 'PDA Solucoes'
    CompatiblePSEditions = @('Desktop', 'Core')
    Copyright            = '(c) 2017 - 2021 Rodrigo Cordeiro. All rights reserved.'
    Description          = 'Simple module to manage systems publish and update'
    FunctionsToExport    = @('New-PDAConfig')
    GUID                 = '5d7553fc-0d37-4a59-b03f-fe9a2eca72e6'
    ModuleVersion        = '0.0.1'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            Tags       = @('CLI','Automation','Publish')
            ProjectUri = 'https://github.com/EvotecIT/PSDiscord'
            IconUri    = 'https://evotec.xyz/wp-content/uploads/2018/12/Discord-Logo-Color.png'
        }
    }
    RequiredModules      = @(
        # @{
        #     ModuleVersion = '0.0.205'
        #     ModuleName    = 'PSSharedGoods'
        #     Guid          = 'ee272aa8-baaa-4edf-9f45-b6d6f7d844fe'
        # }
        )
    RootModule           = 'pda.psm1'
}