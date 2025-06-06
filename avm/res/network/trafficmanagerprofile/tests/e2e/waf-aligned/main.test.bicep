targetScope = 'subscription'

metadata name = 'WAF-aligned'
metadata description = 'This instance deploys the module in alignment with the best-practices of the Azure Well-Architected Framework.'

// ========== //
// Parameters //
// ========== //

@description('Optional. The name of the resource group to deploy for testing purposes.')
@maxLength(90)
param resourceGroupName string = 'dep-${namePrefix}-network.trafficmanagerprofiles-${serviceShort}-rg'

#disable-next-line no-hardcoded-location
var enforcedLocation01 = 'uksouth'

#disable-next-line no-hardcoded-location
var enforcedLocation02 = 'ukwest'

@description('Optional. A short identifier for the kind of deployment. Should be kept short to not run into resource-name length-constraints.')
param serviceShort string = 'ntmpwaf'

@description('Optional. A token to inject into the name of each resource.')
param namePrefix string = '#_namePrefix_#'

// ============ //
// Dependencies //
// ============ //

// General resources
// =================
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: enforcedLocation01
}

module nestedDependencies 'dependencies.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, enforcedLocation01)}-nestedDependencies'
  params: {
    managedIdentityName: 'dep-${namePrefix}-msi-${serviceShort}'
    location: enforcedLocation01
    serverFarmName01: 'dep-${namePrefix}-sf-${serviceShort}01'
    serverFarmName02: 'dep-${namePrefix}-sf-${serviceShort}02'
    webApp01Name: 'dep-${namePrefix}-wa-${serviceShort}01'
    webApp02Name: 'dep-${namePrefix}-wa-${serviceShort}02'
    location01: enforcedLocation01
    location02: enforcedLocation02
  }
}

// Diagnostics
// ===========
module diagnosticDependencies '../../../../../../../utilities/e2e-template-assets/templates/diagnostic.dependencies.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, enforcedLocation01)}-diagnosticDependencies'
  params: {
    storageAccountName: 'dep${namePrefix}diasa${serviceShort}01'
    logAnalyticsWorkspaceName: 'dep-${namePrefix}-law-${serviceShort}'
    eventHubNamespaceEventHubName: 'dep-${namePrefix}-evh-${serviceShort}'
    eventHubNamespaceName: 'dep-${namePrefix}-evhns-${serviceShort}'
    location: enforcedLocation01
  }
}

// ============== //
// Test Execution //
// ============== //
@batchSize(1)
module testDeployment '../../../main.bicep' = [
  for iteration in ['init', 'idem']: {
    scope: resourceGroup
    name: '${uniqueString(deployment().name, enforcedLocation01)}-test-${serviceShort}-${iteration}'
    params: {
      name: '${namePrefix}${serviceShort}001'
      monitorConfig: {
        protocol: 'https'
        port: '443'
        path: '/'
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
      tags: {
        'hidden-title': 'This is visible in the resource name'
        Environment: 'Non-Prod'
        Role: 'DeploymentValidation'
      }
      endpoints: [
        {
          name: 'webApp01Endpoint'
          type: 'Microsoft.Network/trafficManagerProfiles/azureEndpoints'
          properties: {
            targetResourceId: nestedDependencies.outputs.webApp01ResourceId
            weight: 1
            priority: 1
            endpointLocation: enforcedLocation01
            endpointStatus: 'Enabled'
          }
        }
        {
          name: 'webApp02Endpoint'
          type: 'Microsoft.Network/trafficManagerProfiles/azureEndpoints'
          properties: {
            targetResourceId: nestedDependencies.outputs.webApp02ResourceId
            weight: 1
            priority: 2
            endpointLocation: enforcedLocation02
            endpointStatus: 'Enabled'
          }
        }
      ]
    }
  }
]
