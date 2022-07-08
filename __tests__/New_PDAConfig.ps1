Describe 'ShouldProcess' {
    Mock New-Something {}
    It 'Should process by default' {
        Test-ShouldProcess
        Assert-MockCalled New-Something -Scope It -Exactly -Times 1
    }
    It 'Should not process on explicit request for confirmation (-Confirm)' {
        { Test-ShouldProcess -Confirm }
        Assert-MockCalled New-Something -Scope It -Exactly -Times 0
    }
    It 'Should not process on implicit request for confirmation (ConfirmPreference)' {
        {
            $ConfirmPreference = 'Medium'
            Test-ShouldProcess
        }
        Assert-MockCalled New-Something -Scope It -Exactly -Times 0
    }
    It 'Should not process on explicit request for validation (-WhatIf)' {
        { Test-ShouldProcess -WhatIf }
        Assert-MockCalled New-Something -Scope It -Exactly -Times 0
    }
    It 'Should not process on implicit request for validation (WhatIfPreference)' {
        {
            $WhatIfPreference = $true
            Test-ShouldProcess
        }
        Assert-MockCalled New-Something -Scope It -Exactly -Times 0
    }
    It 'Should process on force' {
        $ConfirmPreference = 'Medium'
        Test-ShouldProcess -Force
        Assert-MockCalled New-Something -Scope It -Exactly -Times 1
    }
}