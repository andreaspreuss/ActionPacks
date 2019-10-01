﻿#Requires -Version 5.0
#Requires -Modules Microsoft.Online.SharePoint.PowerShell

<#
    .SYNOPSIS
        Adds an existing Office 365 user or an Office 365 security group to a SharePoint group
    
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
        https://github.com/scriptrunner/ActionPacks/tree/master/O365/SharePointOnline/Users

    .Parameter LoginName
        Specifies the user name

    .Parameter Group
        Specifies the group to get the users from

    .Parameter Site
        Specifies the URL of the site collection to get the user from

    .Parameter Limit
        Specifies the maximum number of users returned
#>

param(            
    [Parameter(Mandatory = $true, ParameterSetName = 'All')]
    [Parameter(Mandatory = $true, ParameterSetName = 'ByGroup')]
    [Parameter(Mandatory = $true, ParameterSetName = 'ByLoginName')]
    [string]$Site,
    [Parameter(Mandatory = $true, ParameterSetName = 'ByGroup')]
    [string]$Group,
    [Parameter(Mandatory = $true, ParameterSetName = 'ByLoginName')]
    [string]$LoginName,
    [Parameter(ParameterSetName = 'All')]
    [Parameter(ParameterSetName = 'ByGroup')]
    [int]$Limit = 500
)

Import-Module Microsoft.Online.SharePoint.PowerShell

try{
    [hashtable]$cmdArgs = @{'ErrorAction' = 'Stop'
                            'Site' = $Site
                            }      
                            
    if($PSCmdlet.ParameterSetName -eq 'All'){
        $cmdArgs.Add('Limit',$Limit)
    }
    elseif($PSCmdlet.ParameterSetName -eq 'ByGroup'){
        $cmdArgs.Add('Limit',$Limit)
        $cmdArgs.Add('Group',$Group)
    }
    elseif($PSCmdlet.ParameterSetName -eq 'ByLoginName'){
        $cmdArgs.Add('LoginName',$LoginName)
    }
    
    $result = Get-SPOUser @cmdArgs | Select-Object *
      
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