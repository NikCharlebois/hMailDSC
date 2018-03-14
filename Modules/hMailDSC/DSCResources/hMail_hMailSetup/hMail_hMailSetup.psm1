function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet("Present", "Absent")]
        $Ensure,

        [parameter(Mandatory = $true)]
        [System.String]
        $InstallerPath,

        [parameter(Mandatory = $true)]
        [System.String]
        $InstallLocation
    )

    $result = @{
        Ensure = "Absent"
        InstallerPath = $null
        InstallLocation = $null
    }
    try
    {
        Write-Verbose "Obtaining information about existing hMail instances"
        $currentInstallLocation = Get-hMailInstalledLocation
        
        if($currentInstallLocation)
        {
            Write-Verbose "Found existing installation of hMail at $currentInstallLocation"
            $result = @{
                Ensure = "Present"
                InstallerPath = $InstallerPath
                InstallLocation = $currentInstallLocation
            }
        }
        else {
            Write-Verbose "No existing hMail instance detected"
        }
    }
    catch
    {
        throw "Error determining if hMail was already installed or not."
    }

    return $result
}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet("Present", "Absent")]
        $Ensure,

        [parameter(Mandatory = $true)]
        [System.String]
        $InstallerPath,

        [parameter(Mandatory = $true)]
        [System.String]
        $InstallLocation
    )
    
    if($Ensure.ToLower() -eq "present")
    {
        Write-Verbose "Installing hMail Server"
        $arguments = "/VERYSILENT /SP-"
        $installer = Start-Process -FilePath $InstallerPath `
                                -ArgumentList $arguments -Wait -NoNewWindow -PassThru
    }
    else {
        throw "This module cannot uninstall hMail. Please set Ensure to 'Present'"
    }
}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        [ValidateSet("Present", "Absent")]
        $Ensure,

        [parameter(Mandatory = $true)]
        [System.String]
        $InstallerPath,

        [parameter(Mandatory = $true)]
        [System.String]
        $InstallLocation
    )
    
    Write-Verbose -Message "Testing for presence of hMailServer"
    $PSBoundParameters.Ensure = $Ensure
    $CurrentValues = Get-TargetResource @PSBoundParameters

    return Test-hMailDscParameterState -CurrentValues $CurrentValues `
                                    -DesiredValues $PSBoundParameters `
                                    -ValuesToCheck @(
                                        "Ensure",
                                        "InstallLocation")
}

Export-ModuleMember -Function *-TargetResource
