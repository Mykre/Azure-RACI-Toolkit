param(
  [parameter(Mandatory=$true)]
  [string] $Filepath = "C:\temp\blueprint_reader.csv"
)

# Export All Roles and their definitions 

foreach( $role in (Get-AzRoleDefinition) )
{
  Write-Verbose -Message ("Changing to Role {0}" -f $role.Name) -Verbose

  $properties = [Ordered]@{
    Name = $role.Name
    Description = $role.Description
    Actions =  [string]::Join(';', $role.Actions)
    NotActions = [string]::Join(';', $role.NotActions)
    DataActions = [string]::Join(';', $role.DataActions)
    NotDataActions = [string]::Join(';', $role.NotDataActions)
  }
  $row = New-Object PSObject -Property $properties 
  $row | Export-Csv -Append -Path $Filepath -Force -NoTypeInformation
} 