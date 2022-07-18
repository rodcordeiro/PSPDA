---
external help file: pspda.help.xml
Module Name: pspda
online version:
schema: 2.0.0
---

# New-PDAConfig

## SYNOPSIS

Cria o arquivo de configuração .pda

## SYNTAX

```
New-PDAConfig [-Yes] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Cria o arquivo de configuração .pda, preenchendo-o com as configurações padrão ou através das informações inputadas pelo usuário

## EXAMPLES

### Example 1

```powershell
PS C:\> New-PDAConfig
```

Cria um arquivo de configuração de forma interativa

### Example 2

```powershell
PS C:\> New-PDAConfig -y
```

Cria um arquivo de configuração com as configurações padrão

### Example 3

```powershell
PS C:\> New-PDAConfig -Force
```

Cria um arquivo de configuração mesmo que já exista um arquivo

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Nomeado
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Forces override of an existing config file

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: F

Required: False
Position: Nomeado
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Nomeado
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Yes

Skips information input

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: Y

Required: False
Position: Nomeado
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.SwitchParameter

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
