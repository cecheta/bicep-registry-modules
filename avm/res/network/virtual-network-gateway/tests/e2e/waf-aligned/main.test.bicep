targetScope = 'subscription'

metadata name = 'WAF-aligned'
metadata description = 'This instance deploys the module in alignment with the best-practices of the Azure Well-Architected Framework.'

// ========== //
// Parameters //
// ========== //

@description('Optional. The name of the resource group to deploy for testing purposes.')
@maxLength(90)
param resourceGroupName string = 'dep-${namePrefix}-network.virtualnetworkgateways-${serviceShort}-rg'

@description('Optional. The location to deploy resources to.')
param resourceLocation string = deployment().location

@description('Optional. A short identifier for the kind of deployment. Should be kept short to not run into resource-name length-constraints.')
param serviceShort string = 'nvgmwaf'

@description('Optional. A token to inject into the name of each resource.')
param namePrefix string = '#_namePrefix_#'

// ============ //
// Dependencies //
// ============ //

// General resources
// =================
resource resourceGroup 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroupName
  location: resourceLocation
}

module nestedDependencies 'dependencies.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, resourceLocation)}-nestedDependencies'
  params: {
    location: resourceLocation
    virtualNetworkName: 'dep-${namePrefix}-vnet-${serviceShort}'
    localNetworkGatewayName: 'dep-${namePrefix}-lng-${serviceShort}'
    MaintenanceConfigurationName: 'dep-${namePrefix}-mc-${serviceShort}'
  }
}

// Diagnostics
// ===========
module diagnosticDependencies '../../../../../../../utilities/e2e-template-assets/templates/diagnostic.dependencies.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, resourceLocation)}-diagnosticDependencies'
  params: {
    storageAccountName: 'dep${namePrefix}diasa${serviceShort}01'
    logAnalyticsWorkspaceName: 'dep-${namePrefix}-law-${serviceShort}'
    eventHubNamespaceEventHubName: 'dep-${namePrefix}-evh-${serviceShort}'
    eventHubNamespaceName: 'dep-${namePrefix}-evhns-${serviceShort}'
    location: resourceLocation
  }
}
// ============== //
// Test Execution //
// ============== //

@batchSize(1)
module testDeployment '../../../main.bicep' = [
  for iteration in ['init', 'idem']: {
    scope: resourceGroup
    name: '${uniqueString(deployment().name, resourceLocation)}-test-${serviceShort}-${iteration}'
    params: {
      name: '${namePrefix}${serviceShort}001'
      vpnGatewayGeneration: 'Generation2'
      skuName: 'VpnGw2AZ'
      gatewayType: 'Vpn'
      virtualNetworkResourceId: nestedDependencies.outputs.vnetResourceId
      clusterSettings: {
        clusterMode: 'activeActiveBgp'
        customBgpIpAddresses: ['169.254.21.4', '169.254.21.5']
        secondCustomBgpIpAddresses: ['169.254.22.4', '169.254.22.5']
        asn: 65515
      }
      diagnosticSettings: [
        {
          name: 'customSetting'
          metricCategories: [
            {
              category: 'AllMetrics'
            }
          ]
          eventHubName: diagnosticDependencies.outputs.eventHubNamespaceEventHubName
          eventHubAuthorizationRuleResourceId: diagnosticDependencies.outputs.eventHubAuthorizationRuleId
          storageAccountResourceId: diagnosticDependencies.outputs.storageAccountResourceId
          workspaceResourceId: diagnosticDependencies.outputs.logAnalyticsWorkspaceResourceId
        }
      ]
      domainNameLabel: [
        '${namePrefix}-dm-${serviceShort}'
      ]
      publicIpAvailabilityZones: [
        1
        2
        3
      ]
      vpnType: 'RouteBased'
      tags: {
        'hidden-title': 'This is visible in the resource name'
        Environment: 'Non-Prod'
        Role: 'DeploymentValidation'
      }
      enablePrivateIpAddress: true
      gatewayDefaultSiteLocalNetworkGatewayResourceId: nestedDependencies.outputs.localNetworkGatewayResourceId
      disableIPSecReplayProtection: true
      allowRemoteVnetTraffic: true
      natRules: [
        {
          name: 'nat-rule-1-static-IngressSnat'
          type: 'Static'
          mode: 'IngressSnat'
          internalMappings: [
            {
              addressSpace: '10.100.0.0/24'
              portRange: '100'
            }
          ]
          externalMappings: [
            {
              addressSpace: '192.168.0.0/24'
              portRange: '100'
            }
          ]
        }
        {
          name: 'nat-rule-2-dynamic-EgressSnat'
          type: 'Static'
          mode: 'EgressSnat'
          internalMappings: [
            {
              addressSpace: '172.16.0.0/26'
            }
          ]
          externalMappings: [
            {
              addressSpace: '10.200.0.0/26'
            }
          ]
        }
      ]
      enableBgpRouteTranslationForNat: true
      maintenanceConfiguration: {
        assignmentName: 'myAssignment'
        maintenanceConfigurationResourceId: nestedDependencies.outputs.maintenanceConfigurationResourceId
      }
    }
  }
]

output activeActive bool = testDeployment[0].outputs.activeActive
output asn int? = testDeployment[0].outputs.?asn
output customBgpIpAddresses string? = testDeployment[0].outputs.?customBgpIpAddresses
output defaultBgpIpAddresses string? = testDeployment[0].outputs.?defaultBgpIpAddresses
output ipConfigurations array? = testDeployment[0].outputs.?ipConfigurations
output location string = testDeployment[0].outputs.location
output name string = testDeployment[0].outputs.name
output primaryPublicIpAddress string = testDeployment[0].outputs.primaryPublicIpAddress
output resourceGroupName string = testDeployment[0].outputs.resourceGroupName
output resourceId string = testDeployment[0].outputs.resourceId
output secondaryCustomBgpIpAddress string? = testDeployment[0].outputs.?secondaryCustomBgpIpAddress
output secondaryDefaultBgpIpAddress string? = testDeployment[0].outputs.?secondaryDefaultBgpIpAddress
output secondaryPublicIpAddress string? = testDeployment[0].outputs.?secondaryPublicIpAddress
