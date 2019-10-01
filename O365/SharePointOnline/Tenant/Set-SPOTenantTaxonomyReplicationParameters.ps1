﻿#Requires -Version 5.0
#Requires -Modules Microsoft.Online.SharePoint.PowerShell

<#
    .SYNOPSIS
        Select groups for replication
    
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
        https://github.com/scriptrunner/ActionPacks/tree/master/O365/SharePointOnline/Tenant

    .Parameter ReplicatedGroups
        Name of the groups for replication, comma separated
#>

param( 
    [string]$ReplicatedGroups
)

Import-Module Microsoft.Online.SharePoint.PowerShell

try{
    [hashtable]$cmdArgs = @{'ErrorAction' = 'Stop'}

    if($PSBoundParameters.ContainsKey('ReplicatedGroups')){
        $grps = $ReplicatedGroups.Split(',')
        $cmdArgs.Add('ReplicatedGroups' , $grps)
    }
    else{
        $cmdArgs.Add('ReplicateAllGroups' , $null)
    }

    $result = Set-SPOTenantTaxonomyReplicationParameters @cmdArgs | Select-Object *
      
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