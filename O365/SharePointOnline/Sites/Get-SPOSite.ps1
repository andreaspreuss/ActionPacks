﻿#Requires -Version 5.0
#Requires -Modules Microsoft.Online.SharePoint.PowerShell

<#
    .SYNOPSIS
        Returns one or more sites
    
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
        https://github.com/scriptrunner/ActionPacks/tree/master/O365/SharePointOnline/Sites

    .Parameter Identity
        Specifies the URL of the site collection

    .Parameter Limit
        Specifies the maximum number of site collections to return

    .Parameter Detailed
        Use this parameter to get additional property information on a site collection

    .Parameter IncludePersonalSite
        Displays personal sites when value is set to $true

    .Parameter Template
        Displays sites of a specific template

    .Parameter Properties
        List of comma separated properties to expand. Use * for all properties
#>

param(        
    [Parameter(Mandatory=$true,ParameterSetName="Set 2")]
    [bool]$IncludePersonalSite,
    [Parameter(ParameterSetName="Set 1")]
    [string]$Identity,
    [Parameter(ParameterSetName="Set 1")]
    [Parameter(ParameterSetName="Set 2")]
    [switch]$Detailed,
    [Parameter(ParameterSetName="Set 2")]
    [string]$Template,
    [Parameter(ParameterSetName="Set 1")]
    [Parameter(ParameterSetName="Set 2")]
    [int]$Limit = 200,    
    [Parameter(ParameterSetName="Set 1")]
    [Parameter(ParameterSetName="Set 2")]
    [string]$Properties = 'Title,Status,Url,DisableFlows,AllowEditing,LastContentModifiedDate,CommentsOnSitePagesDisabled'
)

Import-Module Microsoft.Online.SharePoint.PowerShell

try{
    if([System.String]::IsNullOrWhiteSpace($Properties)){
        $Properties = '*'
    }
    [hashtable]$cmdArgs = @{'ErrorAction' = 'Stop'
                            'Detailed' = $Detailed
                            }      
    
    If($PSCmdlet.ParameterSetName -eq 'Set 1'){
        if([System.String]::IsNullOrWhiteSpace($Identity) -eq $false){
            $cmdArgs.Add('Identity',$Identity)
        }
    }
    else{       
        $cmdArgs.Add('IncludePersonalSite',$IncludePersonalSite)     
        if([System.String]::IsNullOrWhiteSpace($Template) -eq $false){
            $cmdArgs.Add('Template',$Template)
        } 
    }
    if($Limit -gt 0){
        $cmdArgs.Add('Limit',$Limit)
    }

    $result = Get-SPOSite @cmdArgs | Select-Object $Properties.Split(',')

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