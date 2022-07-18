---
external help file: pspda.help.xml
Module Name: pspda
online version:
schema: 2.0.0
---

# Update-PDAConfig

## SYNOPSIS

Atualiza o arquivo de configuração .pda

## SYNTAX

```
Update-PDAConfig [[-Name] <String>] [[-Files] <Array>] [[-Exclude] <Array>]
 [[-Environment] <PDAEnvironmentConfig>] [-Append] [-NewEnv] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Atualiza o arquivo de configuração .pda

## EXAMPLES

### Example 1

```powershell
PS C:\> Update-PDAConfig -Name <Novo_Nome>
```

Atualiza o nome do projeto

### Example 2

```powershell
PS C:\> Update-PDAConfig -Files src,assets
```

Atualiza os arquivos importados ao gerar o arquivo para deploy

### Example 3

```powershell
PS C:\> Update-PDAConfig -Files src,assets -Append
```

Adiciona novos arquivos a lista de arquivos importados

### Example 4

```powershell
PS C:\> Update-PDAConfig -NewEnv
```

Habilita o menu interativo para inclusão de novos ambientes

## PARAMETERS

### -Append

Define se as informacoes devem ser inseridas de forma complementar ou substituir completamente os dados existetes.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Nomeado
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

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

### -Environment

Adiciona um novo ambiente

```yaml
Type: PDAEnvironmentConfig
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Exclude

Atualiza a lista de arquivos a serem excluidos da build

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Files

Atualiza a lista de arquivos a serem inclusos na build

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name

Atualiza o nome do projeto

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NewEnv

Adiciona uma nova configuracao de ambiente de forma interativa.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Array

### PDAEnvironmentConfig

### System.Management.Automation.SwitchParameter

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
