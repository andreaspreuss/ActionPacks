﻿#Requires -Version 5.0
#Requires -Modules Microsoft.Online.SharePoint.PowerShell

<#
    .SYNOPSIS
        Remove a previously created migration job from the specified site collection
    
    .DESCRIPTION  

    .NOTES
        This PowerShell script was developed and optimized for ScriptRunner. The use of the scripts requires ScriptRunner. 
        The customer or user is authorized to copy the script from the repository and use them in ScriptRunner. 
        The terms of use for ScriptRunner do not apply to this script. In particular, AppSphere AG assumes no liability for the function, 
        the use and the consequences of the use of this freely available script.
        PowerShell is a product of Microsoft Corporation. ScriptRunner is a product of AppSphere AG.
        © AppSphere AG

    .COMPONENT
        Requires Module Microsoft.Online.SharePoint.PowerShell
        ScriptRunner Version 4.2.x or higher

    .LINK
        https://github.com/scriptrunner/ActionPacks/tree/master/O365/SharePointOnline/Common

    .Parameter ExecuteCredential
        Credentials of a site collection administrator to use to connect to the site collection

    .Parameter JobId
        Id of a previously created migration job that exists on the target site collection

    .Parameter TargetWebUrl
        The fully qualified URL of the site collection where the job will be deleted if found

    .Parameter NoLogFile
        Indicates to not create a log file
#>

param(     
    [Parameter(Mandatory = $true)]
    [pscredential]$ExecuteCredential,
    [Parameter(Mandatory = $true)]
    [string]$JobId,
    [Parameter(Mandatory = $true)]
    [string]$TargetWebUrl,
    [switch]$NoLogFile
)

Import-Module Microsoft.Online.SharePoint.PowerShell

try{    
    [hashtable]$cmdArgs = @{'ErrorAction' = 'Stop'
                            'Credential' = $ExecuteCredential
                            'JobId' = $JobId
                            'NoLogFile' = $NoLogFile
                            'TargetWebUrl' = $TargetWebUrl
                            }

    $result = Remove-SPOMigrationJob @cmdArgs | Select-Object *
      
    if($SRXEnv) {
        $SRXEnv.ResultMessage = $result
    }
    else {
        Write-Output $result 
    }    
}
catch{
    throw
}
finally{
}