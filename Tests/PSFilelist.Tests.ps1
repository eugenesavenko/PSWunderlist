#requires -Version 3
#Variables for Pester tests

$ModulePath = Split-Path -Parent -Path (Split-Path -Parent -Path $MyInvocation.MyCommand.Path)
$ModuleName = '.\PSWunderlist'
$ManifestPath   = "$ModulePath\PSWunderlist\$ModuleName.psd1"
$ModulePSM1file   = "$ModulePath\PSWunderlist\$ModuleName.psm1"
if (Get-Module -Name $ModuleName) 
{
  Remove-Module $ModuleName -Force 
}
Import-Module $ManifestPath -Verbose:$false

Describe "Test" {
    It "Test" {
        "Test" | Should Be "Test"
    }
}
