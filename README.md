# WorkflowManagerDsc

The hMailDSCDsc module provides the ability to install hMail
Server (https://www.hmailserver.com/).


## Contributing

Please check out common DSC Resources [contributing guidelines](https://github.com/PowerShell/DscResource.Kit/blob/master/CONTRIBUTING.md).

## Installation

To manually install the module, download the source code and unzip the contents
of the \Modules\hMailserver directory to the
$env:ProgramFiles\WindowsPowerShell\Modules folder.

To install from the PowerShell gallery using PowerShellGet (in PowerShell 5.0)
run the following command:

    Find-Module -Name hMailDSC -Repository PSGallery | Install-Module

To confirm installation, run the below command and ensure you see the Workflow Manager DSC resoures available:

    Get-DscResource -Module hMailDsc

## Requirements

The minimum PowerShell version required is 4.0, which ships in Windows 8.1 or
Windows Server 2012R2 (or higher versions). The preferred version is PowerShell
5.0 or higher, which ships with Windows 10 or Windows Server 2016.

## Changelog

A full list of changes in each version can be found in the [change log](CHANGELOG.md)
