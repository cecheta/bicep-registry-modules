metadata name = 'Azure SQL Server failover group'
metadata description = 'This module deploys Azure SQL Server failover group.'

@description('Required. The name of the failover group.')
param name string

@description('Conditional. The Name of SQL Server. Required if the template is used in a standalone deployment.')
param serverName string

@description('Required. List of databases in the failover group.')
param databases string[]

@description('Required. List of the partner server Resource Ids for the failover group.')
param partnerServerResourceIds string[]

@description('Optional. Read-only endpoint of the failover group instance.')
param readOnlyEndpoint readOnlyEndpointType?

@description('Required. Read-write endpoint of the failover group instance.')
param readWriteEndpoint readWriteEndpointType

@description('Required. Databases secondary type on partner server.')
param secondaryType 'Geo' | 'Standby'

resource server 'Microsoft.Sql/servers@2023-08-01' existing = {
  name: serverName
}

@description('Optional. Tags of the resource.')
param tags resourceInput<'Microsoft.Sql/servers/failoverGroups@2023-08-01'>.tags?

// https://stackoverflow.com/questions/78337117/azure-sql-failover-group-fails-on-second-run
// https://github.com/Azure/bicep-types-az/issues/2153

resource failoverGroup 'Microsoft.Sql/servers/failoverGroups@2024-05-01-preview' = {
  name: name
  parent: server
  tags: tags
  properties: {
    databases: [for db in databases: resourceId('Microsoft.Sql/servers/databases', serverName, db)]
    partnerServers: [
      for partnerServerResourceId in partnerServerResourceIds: {
        id: partnerServerResourceId
      }
    ]
    readOnlyEndpoint: !empty(readOnlyEndpoint)
      ? {
          failoverPolicy: readOnlyEndpoint!.failoverPolicy
          targetServer: resourceId(resourceGroup().name, 'Microsoft.Sql/servers', readOnlyEndpoint!.targetServer)
        }
      : null
    readWriteEndpoint: readWriteEndpoint
    secondaryType: secondaryType
  }
}

// =============== //
//     Outputs     //
// =============== //

@description('The name of the deployed failover group.')
output name string = failoverGroup.name

@description('The resource ID of the deployed failover group.')
output resourceId string = failoverGroup.id

@description('The resource group of the deployed failover group.')
output resourceGroupName string = resourceGroup().name

@export()
@description('The type for a read-only endpoint.')
type readOnlyEndpointType = {
  @description('Required. Failover policy of the read-only endpoint for the failover group.')
  failoverPolicy: 'Disabled' | 'Enabled'

  @description('Required. The target partner server where the read-only endpoint points to.')
  targetServer: string
}

@export()
@description('The type for a read-write endpoint.')
type readWriteEndpointType = {
  @description('Required. Failover policy of the read-write endpoint for the failover group. If failoverPolicy is Automatic then failoverWithDataLossGracePeriodMinutes is required.')
  failoverPolicy: 'Automatic' | 'Manual'

  @description('Optional. Grace period before failover with data loss is attempted for the read-write endpoint.')
  failoverWithDataLossGracePeriodMinutes: int?
}
