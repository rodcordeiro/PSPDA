Clear-Host
Import-Module "C:\Support\GitHub\PSPublishModule\PSPublishModule.psm1" -Force

$Configuration = @{
    Information = @{
        ModuleName        = 'PSPDA'

        DirectoryProjects = "$Env:USERPROFILE\projetos\personal\PSPDA"
        #DirectoryModules  = "C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules"
        DirectoryModules  = "$Env:USERPROFILE\Documents\WindowsPowerShell\Modules"

        FunctionsToExport = 'Public'
        AliasesToExport   = 'Public'

        Manifest          = @{
                    RootModule = 'pda.psm1'
                    ModuleVersion = '1.0.0'
                    GUID = '5af698b0-2b23-4522-a600-bbe252f2a5b3'
                    Author = 'Rodrigo Cordeiro <rodrigomendoncca@gmail.com> (http://rodcordeiro.com.br)'
                    CompanyName = 'PDA Soluções'
                    Copyright = '(c) 2022 Rodrigo Cordeiro. Todos os direitos reservados.'
                    Description= 'Simple module to manage systems publish and updates'
                    PowerShellVersion    = '5.1'
                    FunctionsToExport    = @('New-PDAConfig')
                    CmdletsToExport = @()
                    VariablesToExport = '*'
                    AliasesToExport      = @('New-PDAConfig')
                    PrivateData          = @{
                        PSData = @{
                            Tags       = @('CLI','Automation','Publish')
                            ProjectUri = 'https://github.com/rodcordeiro/PSPDA'
                            IconUri    = 'https://raw.githubusercontent.com/rodcordeiro/PSPDA/main/assets/Aplica%C3%A7%C3%A3o%20de%20logo%20com%20nome.png'
                        }
                    }
            }
    Options     = @{
        Merge             = @{
            Sort           = 'None'
            FormatCodePSM1 = @{
                Enabled           = $true
                RemoveComments    = $false
                FormatterSettings = @{
                    IncludeRules = @(
                        'PSPlaceOpenBrace',
                        'PSPlaceCloseBrace',
                        'PSUseConsistentWhitespace',
                        'PSUseConsistentIndentation',
                        'PSAlignAssignmentStatement',
                        'PSUseCorrectCasing'
                    )

                    Rules        = @{
                        PSPlaceOpenBrace           = @{
                            Enable             = $true
                            OnSameLine         = $true
                            NewLineAfter       = $true
                            IgnoreOneLineBlock = $true
                        }

                        PSPlaceCloseBrace          = @{
                            Enable             = $true
                            NewLineAfter       = $false
                            IgnoreOneLineBlock = $true
                            NoEmptyLineBefore  = $false
                        }

                        PSUseConsistentIndentation = @{
                            Enable              = $true
                            Kind                = 'space'
                            PipelineIndentation = 'IncreaseIndentationAfterEveryPipeline'
                            IndentationSize     = 4
                        }

                        PSUseConsistentWhitespace  = @{
                            Enable          = $true
                            CheckInnerBrace = $true
                            CheckOpenBrace  = $true
                            CheckOpenParen  = $true
                            CheckOperator   = $true
                            CheckPipe       = $true
                            CheckSeparator  = $true
                        }

                        PSAlignAssignmentStatement = @{
                            Enable         = $true
                            CheckHashtable = $true
                        }

                        PSUseCorrectCasing         = @{
                            Enable = $true
                        }
                    }
                }
            }
            FormatCodePSD1 = @{
                Enabled        = $true
                RemoveComments = $false
            }
            Integrate      = @{
                ApprovedModules = @()
            }
        }
        Standard          = @{
            FormatCodePSM1 = @{

            }
            FormatCodePSD1 = @{
                Enabled = $true
                #RemoveComments = $true
            }
        }
        ImportModules     = @{
            Self            = $true
            RequiredModules = $false
            Verbose         = $false
        }
        PowerShellGallery = @{
            ApiKey   = 'C:\Support\Important\PowerShellGalleryAPI.txt'
            FromFile = $true
        }
        GitHub            = @{
            ApiKey   = 'C:\Support\Important\GithubAPI.txt'
            FromFile = $true
            UserName = 'EvotecIT'
            #RepositoryName = 'PSWriteHTML'
        }
        Documentation     = @{
            Path       = 'Docs'
            PathReadme = 'Docs\Readme.md'
        }
    }
    Steps       = @{
        BuildModule        = @{  rue
            DeleteBefore     = $false
            Merge            = $true
            MergeMissing     = $true
            SignMerged       = $true
            Releases         = $true
            ReleasesUnpacked = $false
            RefreshPSD1Only  = $false
        }
        BuildDocumentation = $false
        ImportModules      = @{
            Self            = $true
            RequiredModules = $false
            Verbose         = $false
        }
        PublishModule      = @{  
            Prerelease   = ''
            RequireForce = $false
            GitHub       = $true
        }
    }
}
}

New-PrepareModule -Configuration $Configuration