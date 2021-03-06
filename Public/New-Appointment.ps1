Function New-Appointment {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'medium')]
    param()
    Begin {}
    Process {
        function global:Stop-Appointment([switch] $NonDestructive) {
            if (Test-Path function:_old_virtual_prompt) {
                $function:prompt = $function:_old_virtual_prompt
                Remove-Item function:\_old_virtual_prompt
            }
        
            if ($env:Appointment) {
                [Environment]::SetEnvironmentVariable('Appointment', $null)
            }
        
            if (!$NonDestructive) {
                # Self destruct!
                Remove-Item function:Stop-Appointment -ErrorAction SilentlyContinue
                Remove-Item function:deactivate  -ErrorAction SilentlyContinue
            }
        }
        function global:deactivate([switch] $NonDestructive) {
            if (Test-Path function:_old_virtual_prompt) {
                $function:prompt = $function:_old_virtual_prompt
                Remove-Item function:\_old_virtual_prompt
            }
        
            if ($env:Appointment) {
                [Environment]::SetEnvironmentVariable('Appointment', $null)
            }
        
            if (!$NonDestructive) {
                # Self destruct!
                Remove-Item function:Stop-Appointment -ErrorAction SilentlyContinue
                Remove-Item function:deactivate  -ErrorAction SilentlyContinue
            }
        }
        
        
        function global:_old_virtual_prompt {
            ""
        }
        $function:_old_virtual_prompt = $function:prompt
        
        $env:Appointment = [DateTime]::Now
        function global:prompt {
            # Add a prefix to the current prompt, but don't discard it.
            $previous_prompt_value = & $function:_old_virtual_prompt
            $appointment = if ($(New-Timespan $env:Appointment $([DateTime]::Now)).TotalHours -lt 1) {
                @{
                    Time   = "$($(New-Timespan $env:Appointment $([DateTime]::Now)).TotalMinutes)";
                    Color  = 'blue';
                    Letter = 'm';
                }
            }
            else {
                @{
                    Time   = "$($(New-Timespan $env:Appointment $([DateTime]::Now)).TotalHours)";
                    Color  = 'red';
                    Letter = 'h';
                }
            }
            $new_prompt_value = Write-Host "[$([Math]::Round($appointment.Time,2))$($appointment.Letter)] " -ForegroundColor $appointment.Color -NoNewline
            ($new_prompt_value + $previous_prompt_value)
        }
        
        
    }
    End {}
}