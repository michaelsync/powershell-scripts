[CmdletBinding()]
Param
(
        [ValidateNotNullOrEmpty()]
        [Parameter(ValueFromPipeline=$True, ValueFromPipelineByPropertyName = $True, Mandatory=$True)]
        [string]$sqlTableType,
        [Parameter(ValueFromPipeline=$True,ValueFromPipelineByPropertyName = $True,Mandatory=$True)]
        [string]$generatedFile,
		[Parameter(ValueFromPipeline=$True,ValueFromPipelineByPropertyName = $True,Mandatory=$False)]		
        [GeneratorType]$type = [GeneratorType]::All
)

#Issue 
enum GeneratorType{
  DeclarationOnly = 1
  CreateDataTableOnly = 2
  PopulateDataRowsOnly = 3
  All = 4
}

#. ".\GeneratorType.ps1" 

. ".\SqlTableColumn.ps1" 
. ".\SqlTableType.ps1" 

$SQLServer = "." 
$SQLDBName = "TestDb"
$SQLUserName = "testuser" 
$SQLUserPassword = "testuserpwd"


if($PSVersionTable.PSVersion.Major -lt 5){   
   write-host "Please install powershell 5 and try again."
   exit -1 #$host.SetShouldExit(-1)   
}

write-output $sqltabletype
write-output $generatedfile
write-output $type

$tableType  = [SqlTableType]::new($SQLServer, $SQLDBName, $SQLUserName, $SQLUserPassword)
write-host $tableType.GetColumns($sqlTableType)

