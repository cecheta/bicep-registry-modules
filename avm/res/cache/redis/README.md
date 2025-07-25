# Redis Cache `[Microsoft.Cache/redis]`

This module deploys a Redis Cache.

## Navigation

- [Resource Types](#Resource-Types)
- [Usage examples](#Usage-examples)
- [Parameters](#Parameters)
- [Outputs](#Outputs)
- [Cross-referenced modules](#Cross-referenced-modules)
- [Notes](#Notes)
- [Data Collection](#Data-Collection)

## Resource Types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.Authorization/locks` | [2020-05-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2020-05-01/locks) |
| `Microsoft.Authorization/roleAssignments` | [2022-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2022-04-01/roleAssignments) |
| `Microsoft.Cache/redis` | [2024-11-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Cache/2024-11-01/redis) |
| `Microsoft.Cache/redis/accessPolicies` | [2024-11-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Cache/2024-11-01/redis/accessPolicies) |
| `Microsoft.Cache/redis/accessPolicyAssignments` | [2024-11-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Cache/2024-11-01/redis/accessPolicyAssignments) |
| `Microsoft.Cache/redis/firewallRules` | [2024-11-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Cache/2024-11-01/redis/firewallRules) |
| `Microsoft.Cache/redis/linkedServers` | [2024-11-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Cache/2024-11-01/redis/linkedServers) |
| `Microsoft.Insights/diagnosticSettings` | [2021-05-01-preview](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Insights/2021-05-01-preview/diagnosticSettings) |
| `Microsoft.KeyVault/vaults/secrets` | [2024-12-01-preview](https://learn.microsoft.com/en-us/azure/templates/Microsoft.KeyVault/2024-12-01-preview/vaults/secrets) |
| `Microsoft.Network/privateEndpoints` | [2024-05-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2024-05-01/privateEndpoints) |
| `Microsoft.Network/privateEndpoints/privateDnsZoneGroups` | [2024-05-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2024-05-01/privateEndpoints/privateDnsZoneGroups) |

## Usage examples

The following section provides usage examples for the module, which were used to validate and deploy the module successfully. For a full reference, please review the module's test folder in its repository.

>**Note**: Each example lists all the required parameters first, followed by the rest - each in alphabetical order.

>**Note**: To reference the module, please use the following syntax `br/public:avm/res/cache/redis:<version>`.

- [Using clustering configuration](#example-1-using-clustering-configuration)
- [Using only defaults](#example-2-using-only-defaults)
- [Using EntraID authentication](#example-3-using-entraid-authentication)
- [Deploying with a key vault reference to save secrets](#example-4-deploying-with-a-key-vault-reference-to-save-secrets)
- [Using large parameter set](#example-5-using-large-parameter-set)
- [Passive Geo-Replicated Redis Cache](#example-6-passive-geo-replicated-redis-cache)
- [Using data persistence configuration](#example-7-using-data-persistence-configuration)
- [Using custom Redis configuration](#example-8-using-custom-redis-configuration)
- [WAF-aligned](#example-9-waf-aligned)

### Example 1: _Using clustering configuration_

This instance deploys the module with clustering enabled.


<details>

<summary>via Bicep module</summary>

```bicep
module redis 'br/public:avm/res/cache/redis:<version>' = {
  name: 'redisDeployment'
  params: {
    // Required parameters
    name: 'crclst001'
    // Non-required parameters
    capacity: 3
    location: '<location>'
    replicasPerMaster: 1
    replicasPerPrimary: 1
    shardCount: 3
    skuName: 'Premium'
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "crclst001"
    },
    // Non-required parameters
    "capacity": {
      "value": 3
    },
    "location": {
      "value": "<location>"
    },
    "replicasPerMaster": {
      "value": 1
    },
    "replicasPerPrimary": {
      "value": 1
    },
    "shardCount": {
      "value": 3
    },
    "skuName": {
      "value": "Premium"
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/cache/redis:<version>'

// Required parameters
param name = 'crclst001'
// Non-required parameters
param capacity = 3
param location = '<location>'
param replicasPerMaster = 1
param replicasPerPrimary = 1
param shardCount = 3
param skuName = 'Premium'
```

</details>
<p>

### Example 2: _Using only defaults_

This instance deploys the module with the minimum set of required parameters.


<details>

<summary>via Bicep module</summary>

```bicep
module redis 'br/public:avm/res/cache/redis:<version>' = {
  name: 'redisDeployment'
  params: {
    // Required parameters
    name: 'crmin001'
    // Non-required parameters
    location: '<location>'
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "crmin001"
    },
    // Non-required parameters
    "location": {
      "value": "<location>"
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/cache/redis:<version>'

// Required parameters
param name = 'crmin001'
// Non-required parameters
param location = '<location>'
```

</details>
<p>

### Example 3: _Using EntraID authentication_

This instance deploys the module with EntraID authentication.


<details>

<summary>via Bicep module</summary>

```bicep
module redis 'br/public:avm/res/cache/redis:<version>' = {
  name: 'redisDeployment'
  params: {
    // Required parameters
    name: 'crentrid001'
    // Non-required parameters
    accessPolicies: [
      {
        name: 'Prefixed Contributor'
        permissions: '+@read +set ~Az*'
      }
    ]
    accessPolicyAssignments: [
      {
        accessPolicyName: 'Data Contributor'
        objectId: '<objectId>'
        objectIdAlias: '<objectIdAlias>'
      }
    ]
    location: '<location>'
    redisConfiguration: {
      'aad-enabled': 'true'
    }
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "crentrid001"
    },
    // Non-required parameters
    "accessPolicies": {
      "value": [
        {
          "name": "Prefixed Contributor",
          "permissions": "+@read +set ~Az*"
        }
      ]
    },
    "accessPolicyAssignments": {
      "value": [
        {
          "accessPolicyName": "Data Contributor",
          "objectId": "<objectId>",
          "objectIdAlias": "<objectIdAlias>"
        }
      ]
    },
    "location": {
      "value": "<location>"
    },
    "redisConfiguration": {
      "value": {
        "aad-enabled": "true"
      }
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/cache/redis:<version>'

// Required parameters
param name = 'crentrid001'
// Non-required parameters
param accessPolicies = [
  {
    name: 'Prefixed Contributor'
    permissions: '+@read +set ~Az*'
  }
]
param accessPolicyAssignments = [
  {
    accessPolicyName: 'Data Contributor'
    objectId: '<objectId>'
    objectIdAlias: '<objectIdAlias>'
  }
]
param location = '<location>'
param redisConfiguration = {
  'aad-enabled': 'true'
}
```

</details>
<p>

### Example 4: _Deploying with a key vault reference to save secrets_

This instance deploys the module saving all its secrets in a key vault.


<details>

<summary>via Bicep module</summary>

```bicep
module redis 'br/public:avm/res/cache/redis:<version>' = {
  name: 'redisDeployment'
  params: {
    // Required parameters
    name: 'kvref'
    // Non-required parameters
    location: '<location>'
    secretsExportConfiguration: {
      keyVaultResourceId: '<keyVaultResourceId>'
      primaryAccessKeyName: 'custom-primaryAccessKey-name'
      primaryConnectionStringName: 'custom-primaryConnectionString-name'
      primaryStackExchangeRedisConnectionStringName: 'custom-primaryStackExchangeRedisConnectionString-name'
      secondaryAccessKeyName: 'custom-secondaryAccessKey-name'
      secondaryConnectionStringName: 'custom-secondaryConnectionString-name'
      secondaryStackExchangeRedisConnectionStringName: 'custom-secondaryStackExchangeRedisConnectionString-name'
    }
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "kvref"
    },
    // Non-required parameters
    "location": {
      "value": "<location>"
    },
    "secretsExportConfiguration": {
      "value": {
        "keyVaultResourceId": "<keyVaultResourceId>",
        "primaryAccessKeyName": "custom-primaryAccessKey-name",
        "primaryConnectionStringName": "custom-primaryConnectionString-name",
        "primaryStackExchangeRedisConnectionStringName": "custom-primaryStackExchangeRedisConnectionString-name",
        "secondaryAccessKeyName": "custom-secondaryAccessKey-name",
        "secondaryConnectionStringName": "custom-secondaryConnectionString-name",
        "secondaryStackExchangeRedisConnectionStringName": "custom-secondaryStackExchangeRedisConnectionString-name"
      }
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/cache/redis:<version>'

// Required parameters
param name = 'kvref'
// Non-required parameters
param location = '<location>'
param secretsExportConfiguration = {
  keyVaultResourceId: '<keyVaultResourceId>'
  primaryAccessKeyName: 'custom-primaryAccessKey-name'
  primaryConnectionStringName: 'custom-primaryConnectionString-name'
  primaryStackExchangeRedisConnectionStringName: 'custom-primaryStackExchangeRedisConnectionString-name'
  secondaryAccessKeyName: 'custom-secondaryAccessKey-name'
  secondaryConnectionStringName: 'custom-secondaryConnectionString-name'
  secondaryStackExchangeRedisConnectionStringName: 'custom-secondaryStackExchangeRedisConnectionString-name'
}
```

</details>
<p>

### Example 5: _Using large parameter set_

This instance deploys the module with most of its features enabled.


<details>

<summary>via Bicep module</summary>

```bicep
module redis 'br/public:avm/res/cache/redis:<version>' = {
  name: 'redisDeployment'
  params: {
    // Required parameters
    name: 'crmax001'
    // Non-required parameters
    availabilityZones: [
      1
      2
    ]
    capacity: 2
    diagnosticSettings: [
      {
        eventHubAuthorizationRuleResourceId: '<eventHubAuthorizationRuleResourceId>'
        eventHubName: '<eventHubName>'
        metricCategories: [
          {
            category: 'AllMetrics'
          }
        ]
        name: 'customSetting'
        storageAccountResourceId: '<storageAccountResourceId>'
        workspaceResourceId: '<workspaceResourceId>'
      }
    ]
    enableNonSslPort: true
    firewallRules: [
      {
        endIP: '0.0.0.0'
        name: 'AllowAllWindowsAzureIps'
        startIP: '0.0.0.0'
      }
      {
        endIP: '10.10.10.10'
        name: 'testrule1'
        startIP: '10.10.10.1'
      }
      {
        endIP: '100.100.100.10'
        name: 'testrule2'
        startIP: '100.100.100.1'
      }
    ]
    location: '<location>'
    lock: {
      kind: 'CanNotDelete'
      name: 'myCustomLockName'
    }
    managedIdentities: {
      systemAssigned: true
      userAssignedResourceIds: [
        '<managedIdentityResourceId>'
      ]
    }
    minimumTlsVersion: '1.2'
    privateEndpoints: [
      {
        privateDnsZoneGroup: {
          privateDnsZoneGroupConfigs: [
            {
              privateDnsZoneResourceId: '<privateDnsZoneResourceId>'
            }
          ]
        }
        roleAssignments: [
          {
            name: '8d6043f5-8a22-447f-bc31-23d23e09de6c'
            principalId: '<principalId>'
            principalType: 'ServicePrincipal'
            roleDefinitionIdOrName: 'Owner'
          }
          {
            principalId: '<principalId>'
            principalType: 'ServicePrincipal'
            roleDefinitionIdOrName: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
          }
          {
            principalId: '<principalId>'
            principalType: 'ServicePrincipal'
            roleDefinitionIdOrName: '<roleDefinitionIdOrName>'
          }
        ]
        subnetResourceId: '<subnetResourceId>'
        tags: {
          Environment: 'Non-Prod'
          'hidden-title': 'This is visible in the resource name'
          Role: 'DeploymentValidation'
        }
      }
      {
        privateDnsZoneGroup: {
          privateDnsZoneGroupConfigs: [
            {
              privateDnsZoneResourceId: '<privateDnsZoneResourceId>'
            }
          ]
        }
        subnetResourceId: '<subnetResourceId>'
      }
    ]
    redisVersion: '6'
    roleAssignments: [
      {
        name: 'f20e5c94-a697-421e-8768-d576399dbd87'
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Owner'
      }
      {
        name: '<name>'
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
      }
      {
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: '<roleDefinitionIdOrName>'
      }
    ]
    shardCount: 1
    skuName: 'Premium'
    tags: {
      'hidden-title': 'This is visible in the resource name'
      resourceType: 'Redis Cache'
    }
    zonalAllocationPolicy: 'UserDefined'
    zoneRedundant: true
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "crmax001"
    },
    // Non-required parameters
    "availabilityZones": {
      "value": [
        1,
        2
      ]
    },
    "capacity": {
      "value": 2
    },
    "diagnosticSettings": {
      "value": [
        {
          "eventHubAuthorizationRuleResourceId": "<eventHubAuthorizationRuleResourceId>",
          "eventHubName": "<eventHubName>",
          "metricCategories": [
            {
              "category": "AllMetrics"
            }
          ],
          "name": "customSetting",
          "storageAccountResourceId": "<storageAccountResourceId>",
          "workspaceResourceId": "<workspaceResourceId>"
        }
      ]
    },
    "enableNonSslPort": {
      "value": true
    },
    "firewallRules": {
      "value": [
        {
          "endIP": "0.0.0.0",
          "name": "AllowAllWindowsAzureIps",
          "startIP": "0.0.0.0"
        },
        {
          "endIP": "10.10.10.10",
          "name": "testrule1",
          "startIP": "10.10.10.1"
        },
        {
          "endIP": "100.100.100.10",
          "name": "testrule2",
          "startIP": "100.100.100.1"
        }
      ]
    },
    "location": {
      "value": "<location>"
    },
    "lock": {
      "value": {
        "kind": "CanNotDelete",
        "name": "myCustomLockName"
      }
    },
    "managedIdentities": {
      "value": {
        "systemAssigned": true,
        "userAssignedResourceIds": [
          "<managedIdentityResourceId>"
        ]
      }
    },
    "minimumTlsVersion": {
      "value": "1.2"
    },
    "privateEndpoints": {
      "value": [
        {
          "privateDnsZoneGroup": {
            "privateDnsZoneGroupConfigs": [
              {
                "privateDnsZoneResourceId": "<privateDnsZoneResourceId>"
              }
            ]
          },
          "roleAssignments": [
            {
              "name": "8d6043f5-8a22-447f-bc31-23d23e09de6c",
              "principalId": "<principalId>",
              "principalType": "ServicePrincipal",
              "roleDefinitionIdOrName": "Owner"
            },
            {
              "principalId": "<principalId>",
              "principalType": "ServicePrincipal",
              "roleDefinitionIdOrName": "b24988ac-6180-42a0-ab88-20f7382dd24c"
            },
            {
              "principalId": "<principalId>",
              "principalType": "ServicePrincipal",
              "roleDefinitionIdOrName": "<roleDefinitionIdOrName>"
            }
          ],
          "subnetResourceId": "<subnetResourceId>",
          "tags": {
            "Environment": "Non-Prod",
            "hidden-title": "This is visible in the resource name",
            "Role": "DeploymentValidation"
          }
        },
        {
          "privateDnsZoneGroup": {
            "privateDnsZoneGroupConfigs": [
              {
                "privateDnsZoneResourceId": "<privateDnsZoneResourceId>"
              }
            ]
          },
          "subnetResourceId": "<subnetResourceId>"
        }
      ]
    },
    "redisVersion": {
      "value": "6"
    },
    "roleAssignments": {
      "value": [
        {
          "name": "f20e5c94-a697-421e-8768-d576399dbd87",
          "principalId": "<principalId>",
          "principalType": "ServicePrincipal",
          "roleDefinitionIdOrName": "Owner"
        },
        {
          "name": "<name>",
          "principalId": "<principalId>",
          "principalType": "ServicePrincipal",
          "roleDefinitionIdOrName": "b24988ac-6180-42a0-ab88-20f7382dd24c"
        },
        {
          "principalId": "<principalId>",
          "principalType": "ServicePrincipal",
          "roleDefinitionIdOrName": "<roleDefinitionIdOrName>"
        }
      ]
    },
    "shardCount": {
      "value": 1
    },
    "skuName": {
      "value": "Premium"
    },
    "tags": {
      "value": {
        "hidden-title": "This is visible in the resource name",
        "resourceType": "Redis Cache"
      }
    },
    "zonalAllocationPolicy": {
      "value": "UserDefined"
    },
    "zoneRedundant": {
      "value": true
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/cache/redis:<version>'

// Required parameters
param name = 'crmax001'
// Non-required parameters
param availabilityZones = [
  1
  2
]
param capacity = 2
param diagnosticSettings = [
  {
    eventHubAuthorizationRuleResourceId: '<eventHubAuthorizationRuleResourceId>'
    eventHubName: '<eventHubName>'
    metricCategories: [
      {
        category: 'AllMetrics'
      }
    ]
    name: 'customSetting'
    storageAccountResourceId: '<storageAccountResourceId>'
    workspaceResourceId: '<workspaceResourceId>'
  }
]
param enableNonSslPort = true
param firewallRules = [
  {
    endIP: '0.0.0.0'
    name: 'AllowAllWindowsAzureIps'
    startIP: '0.0.0.0'
  }
  {
    endIP: '10.10.10.10'
    name: 'testrule1'
    startIP: '10.10.10.1'
  }
  {
    endIP: '100.100.100.10'
    name: 'testrule2'
    startIP: '100.100.100.1'
  }
]
param location = '<location>'
param lock = {
  kind: 'CanNotDelete'
  name: 'myCustomLockName'
}
param managedIdentities = {
  systemAssigned: true
  userAssignedResourceIds: [
    '<managedIdentityResourceId>'
  ]
}
param minimumTlsVersion = '1.2'
param privateEndpoints = [
  {
    privateDnsZoneGroup: {
      privateDnsZoneGroupConfigs: [
        {
          privateDnsZoneResourceId: '<privateDnsZoneResourceId>'
        }
      ]
    }
    roleAssignments: [
      {
        name: '8d6043f5-8a22-447f-bc31-23d23e09de6c'
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Owner'
      }
      {
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
      }
      {
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: '<roleDefinitionIdOrName>'
      }
    ]
    subnetResourceId: '<subnetResourceId>'
    tags: {
      Environment: 'Non-Prod'
      'hidden-title': 'This is visible in the resource name'
      Role: 'DeploymentValidation'
    }
  }
  {
    privateDnsZoneGroup: {
      privateDnsZoneGroupConfigs: [
        {
          privateDnsZoneResourceId: '<privateDnsZoneResourceId>'
        }
      ]
    }
    subnetResourceId: '<subnetResourceId>'
  }
]
param redisVersion = '6'
param roleAssignments = [
  {
    name: 'f20e5c94-a697-421e-8768-d576399dbd87'
    principalId: '<principalId>'
    principalType: 'ServicePrincipal'
    roleDefinitionIdOrName: 'Owner'
  }
  {
    name: '<name>'
    principalId: '<principalId>'
    principalType: 'ServicePrincipal'
    roleDefinitionIdOrName: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
  }
  {
    principalId: '<principalId>'
    principalType: 'ServicePrincipal'
    roleDefinitionIdOrName: '<roleDefinitionIdOrName>'
  }
]
param shardCount = 1
param skuName = 'Premium'
param tags = {
  'hidden-title': 'This is visible in the resource name'
  resourceType: 'Redis Cache'
}
param zonalAllocationPolicy = 'UserDefined'
param zoneRedundant = true
```

</details>
<p>

### Example 6: _Passive Geo-Replicated Redis Cache_

This instance deploys the module with geo-replication enabled.


<details>

<summary>via Bicep module</summary>

```bicep
module redis 'br/public:avm/res/cache/redis:<version>' = {
  name: 'redisDeployment'
  params: {
    // Required parameters
    name: 'crpgeo001'
    // Non-required parameters
    capacity: 2
    enableNonSslPort: true
    geoReplicationObject: {
      linkedRedisCacheLocation: '<linkedRedisCacheLocation>'
      linkedRedisCacheResourceId: '<linkedRedisCacheResourceId>'
      name: '<name>'
    }
    location: '<location>'
    lock: {
      kind: 'CanNotDelete'
      name: 'myCustomLockName'
    }
    minimumTlsVersion: '1.2'
    redisVersion: '6'
    replicasPerMaster: 1
    replicasPerPrimary: 1
    shardCount: 1
    skuName: 'Premium'
    zoneRedundant: false
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "crpgeo001"
    },
    // Non-required parameters
    "capacity": {
      "value": 2
    },
    "enableNonSslPort": {
      "value": true
    },
    "geoReplicationObject": {
      "value": {
        "linkedRedisCacheLocation": "<linkedRedisCacheLocation>",
        "linkedRedisCacheResourceId": "<linkedRedisCacheResourceId>",
        "name": "<name>"
      }
    },
    "location": {
      "value": "<location>"
    },
    "lock": {
      "value": {
        "kind": "CanNotDelete",
        "name": "myCustomLockName"
      }
    },
    "minimumTlsVersion": {
      "value": "1.2"
    },
    "redisVersion": {
      "value": "6"
    },
    "replicasPerMaster": {
      "value": 1
    },
    "replicasPerPrimary": {
      "value": 1
    },
    "shardCount": {
      "value": 1
    },
    "skuName": {
      "value": "Premium"
    },
    "zoneRedundant": {
      "value": false
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/cache/redis:<version>'

// Required parameters
param name = 'crpgeo001'
// Non-required parameters
param capacity = 2
param enableNonSslPort = true
param geoReplicationObject = {
  linkedRedisCacheLocation: '<linkedRedisCacheLocation>'
  linkedRedisCacheResourceId: '<linkedRedisCacheResourceId>'
  name: '<name>'
}
param location = '<location>'
param lock = {
  kind: 'CanNotDelete'
  name: 'myCustomLockName'
}
param minimumTlsVersion = '1.2'
param redisVersion = '6'
param replicasPerMaster = 1
param replicasPerPrimary = 1
param shardCount = 1
param skuName = 'Premium'
param zoneRedundant = false
```

</details>
<p>

### Example 7: _Using data persistence configuration_

This instance deploys the module with data persistence enabled.


<details>

<summary>via Bicep module</summary>

```bicep
module redis 'br/public:avm/res/cache/redis:<version>' = {
  name: 'redisDeployment'
  params: {
    // Required parameters
    name: 'crper001'
    // Non-required parameters
    location: '<location>'
    redisConfiguration: {
      'rdb-backup-enabled': 'true'
      'rdb-backup-frequency': '60'
      'rdb-backup-max-snapshot-count': '1'
      'rdb-storage-connection-string': '<rdb-storage-connection-string>'
    }
    skuName: 'Premium'
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "crper001"
    },
    // Non-required parameters
    "location": {
      "value": "<location>"
    },
    "redisConfiguration": {
      "value": {
        "rdb-backup-enabled": "true",
        "rdb-backup-frequency": "60",
        "rdb-backup-max-snapshot-count": "1",
        "rdb-storage-connection-string": "<rdb-storage-connection-string>"
      }
    },
    "skuName": {
      "value": "Premium"
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/cache/redis:<version>'

// Required parameters
param name = 'crper001'
// Non-required parameters
param location = '<location>'
param redisConfiguration = {
  'rdb-backup-enabled': 'true'
  'rdb-backup-frequency': '60'
  'rdb-backup-max-snapshot-count': '1'
  'rdb-storage-connection-string': '<rdb-storage-connection-string>'
}
param skuName = 'Premium'
```

</details>
<p>

### Example 8: _Using custom Redis configuration_

This instance deploys the module with custom Redis configuration.


<details>

<summary>via Bicep module</summary>

```bicep
module redis 'br/public:avm/res/cache/redis:<version>' = {
  name: 'redisDeployment'
  params: {
    // Required parameters
    name: 'crcfg001'
    // Non-required parameters
    location: '<location>'
    redisConfiguration: {
      'maxfragmentationmemory-reserved': '50'
      'maxmemory-delta': '50'
      'maxmemory-policy': 'allkeys-lru'
      'maxmemory-reserved': '50'
    }
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "crcfg001"
    },
    // Non-required parameters
    "location": {
      "value": "<location>"
    },
    "redisConfiguration": {
      "value": {
        "maxfragmentationmemory-reserved": "50",
        "maxmemory-delta": "50",
        "maxmemory-policy": "allkeys-lru",
        "maxmemory-reserved": "50"
      }
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/cache/redis:<version>'

// Required parameters
param name = 'crcfg001'
// Non-required parameters
param location = '<location>'
param redisConfiguration = {
  'maxfragmentationmemory-reserved': '50'
  'maxmemory-delta': '50'
  'maxmemory-policy': 'allkeys-lru'
  'maxmemory-reserved': '50'
}
```

</details>
<p>

### Example 9: _WAF-aligned_

This instance deploys the module in alignment with the best-practices of the Azure Well-Architected Framework.


<details>

<summary>via Bicep module</summary>

```bicep
module redis 'br/public:avm/res/cache/redis:<version>' = {
  name: 'redisDeployment'
  params: {
    // Required parameters
    name: 'crwaf001'
    // Non-required parameters
    availabilityZones: [
      1
      2
      3
    ]
    capacity: 2
    diagnosticSettings: [
      {
        eventHubAuthorizationRuleResourceId: '<eventHubAuthorizationRuleResourceId>'
        eventHubName: '<eventHubName>'
        metricCategories: [
          {
            category: 'AllMetrics'
          }
        ]
        name: 'customSetting'
        storageAccountResourceId: '<storageAccountResourceId>'
        workspaceResourceId: '<workspaceResourceId>'
      }
    ]
    location: '<location>'
    lock: {
      kind: 'CanNotDelete'
      name: 'myCustomLockName'
    }
    managedIdentities: {
      systemAssigned: true
    }
    minimumTlsVersion: '1.2'
    privateEndpoints: [
      {
        privateDnsZoneGroup: {
          privateDnsZoneGroupConfigs: [
            {
              privateDnsZoneResourceId: '<privateDnsZoneResourceId>'
            }
          ]
        }
        subnetResourceId: '<subnetResourceId>'
        tags: {
          Environment: 'Non-Prod'
          'hidden-title': 'This is visible in the resource name'
          Role: 'DeploymentValidation'
        }
      }
    ]
    redisVersion: '6'
    replicasPerMaster: 3
    replicasPerPrimary: 3
    shardCount: 1
    skuName: 'Premium'
    tags: {
      'hidden-title': 'This is visible in the resource name'
      resourceType: 'Redis Cache'
    }
    zonalAllocationPolicy: 'UserDefined'
    zoneRedundant: true
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "crwaf001"
    },
    // Non-required parameters
    "availabilityZones": {
      "value": [
        1,
        2,
        3
      ]
    },
    "capacity": {
      "value": 2
    },
    "diagnosticSettings": {
      "value": [
        {
          "eventHubAuthorizationRuleResourceId": "<eventHubAuthorizationRuleResourceId>",
          "eventHubName": "<eventHubName>",
          "metricCategories": [
            {
              "category": "AllMetrics"
            }
          ],
          "name": "customSetting",
          "storageAccountResourceId": "<storageAccountResourceId>",
          "workspaceResourceId": "<workspaceResourceId>"
        }
      ]
    },
    "location": {
      "value": "<location>"
    },
    "lock": {
      "value": {
        "kind": "CanNotDelete",
        "name": "myCustomLockName"
      }
    },
    "managedIdentities": {
      "value": {
        "systemAssigned": true
      }
    },
    "minimumTlsVersion": {
      "value": "1.2"
    },
    "privateEndpoints": {
      "value": [
        {
          "privateDnsZoneGroup": {
            "privateDnsZoneGroupConfigs": [
              {
                "privateDnsZoneResourceId": "<privateDnsZoneResourceId>"
              }
            ]
          },
          "subnetResourceId": "<subnetResourceId>",
          "tags": {
            "Environment": "Non-Prod",
            "hidden-title": "This is visible in the resource name",
            "Role": "DeploymentValidation"
          }
        }
      ]
    },
    "redisVersion": {
      "value": "6"
    },
    "replicasPerMaster": {
      "value": 3
    },
    "replicasPerPrimary": {
      "value": 3
    },
    "shardCount": {
      "value": 1
    },
    "skuName": {
      "value": "Premium"
    },
    "tags": {
      "value": {
        "hidden-title": "This is visible in the resource name",
        "resourceType": "Redis Cache"
      }
    },
    "zonalAllocationPolicy": {
      "value": "UserDefined"
    },
    "zoneRedundant": {
      "value": true
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/cache/redis:<version>'

// Required parameters
param name = 'crwaf001'
// Non-required parameters
param availabilityZones = [
  1
  2
  3
]
param capacity = 2
param diagnosticSettings = [
  {
    eventHubAuthorizationRuleResourceId: '<eventHubAuthorizationRuleResourceId>'
    eventHubName: '<eventHubName>'
    metricCategories: [
      {
        category: 'AllMetrics'
      }
    ]
    name: 'customSetting'
    storageAccountResourceId: '<storageAccountResourceId>'
    workspaceResourceId: '<workspaceResourceId>'
  }
]
param location = '<location>'
param lock = {
  kind: 'CanNotDelete'
  name: 'myCustomLockName'
}
param managedIdentities = {
  systemAssigned: true
}
param minimumTlsVersion = '1.2'
param privateEndpoints = [
  {
    privateDnsZoneGroup: {
      privateDnsZoneGroupConfigs: [
        {
          privateDnsZoneResourceId: '<privateDnsZoneResourceId>'
        }
      ]
    }
    subnetResourceId: '<subnetResourceId>'
    tags: {
      Environment: 'Non-Prod'
      'hidden-title': 'This is visible in the resource name'
      Role: 'DeploymentValidation'
    }
  }
]
param redisVersion = '6'
param replicasPerMaster = 3
param replicasPerPrimary = 3
param shardCount = 1
param skuName = 'Premium'
param tags = {
  'hidden-title': 'This is visible in the resource name'
  resourceType: 'Redis Cache'
}
param zonalAllocationPolicy = 'UserDefined'
param zoneRedundant = true
```

</details>
<p>

## Parameters

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-name) | string | The name of the Redis cache resource. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`accessPolicies`](#parameter-accesspolicies) | array | Array of access policies to create. |
| [`accessPolicyAssignments`](#parameter-accesspolicyassignments) | array | Array of access policy assignments. |
| [`availabilityZones`](#parameter-availabilityzones) | array | If the zoneRedundant parameter is true, replicas will be provisioned in the availability zones specified here. Otherwise, the service will choose where replicas are deployed. |
| [`capacity`](#parameter-capacity) | int | The size of the Redis cache to deploy. Valid values: for C (Basic/Standard) family (0, 1, 2, 3, 4, 5, 6), for P (Premium) family (1, 2, 3, 4). |
| [`diagnosticSettings`](#parameter-diagnosticsettings) | array | The diagnostic settings of the service. |
| [`disableAccessKeyAuthentication`](#parameter-disableaccesskeyauthentication) | bool | Disable authentication via access keys. |
| [`enableNonSslPort`](#parameter-enablenonsslport) | bool | Specifies whether the non-ssl Redis server port (6379) is enabled. |
| [`enableTelemetry`](#parameter-enabletelemetry) | bool | Enable/Disable usage telemetry for module. |
| [`firewallRules`](#parameter-firewallrules) | array | The firewall rules to create in the PostgreSQL flexible server. |
| [`geoReplicationObject`](#parameter-georeplicationobject) | object | The geo-replication settings of the service. Requires a Premium SKU. Geo-replication is not supported on a cache with multiple replicas per primary. Secondary cache VM Size must be same or higher as compared to the primary cache VM Size. Geo-replication between a vnet and non vnet cache (and vice-a-versa) not supported. |
| [`location`](#parameter-location) | string | The location to deploy the Redis cache service. |
| [`lock`](#parameter-lock) | object | The lock settings of the service. |
| [`managedIdentities`](#parameter-managedidentities) | object | The managed identity definition for this resource. |
| [`minimumTlsVersion`](#parameter-minimumtlsversion) | string | Requires clients to use a specified TLS version (or higher) to connect. |
| [`privateEndpoints`](#parameter-privateendpoints) | array | Configuration details for private endpoints. For security reasons, it is recommended to use private endpoints whenever possible. |
| [`publicNetworkAccess`](#parameter-publicnetworkaccess) | string | Whether or not public network access is allowed for this resource. For security reasons it should be disabled. If not specified, it will be disabled by default if private endpoints are set. |
| [`redisConfiguration`](#parameter-redisconfiguration) | object | All Redis Settings. Few possible keys: rdb-backup-enabled,rdb-storage-connection-string,rdb-backup-frequency,maxmemory-delta,maxmemory-policy,notify-keyspace-events,maxmemory-samples,slowlog-log-slower-than,slowlog-max-len,list-max-ziplist-entries,list-max-ziplist-value,hash-max-ziplist-entries,hash-max-ziplist-value,set-max-intset-entries,zset-max-ziplist-entries,zset-max-ziplist-value etc. |
| [`redisVersion`](#parameter-redisversion) | string | Redis version. Only major version will be used in PUT/PATCH request with current valid values: (4, 6). |
| [`replicasPerMaster`](#parameter-replicaspermaster) | int | The number of replicas to be created per primary. |
| [`replicasPerPrimary`](#parameter-replicasperprimary) | int | The number of replicas to be created per primary. Needs to be the same as replicasPerMaster for a Premium Cluster Cache. |
| [`roleAssignments`](#parameter-roleassignments) | array | Array of role assignments to create. |
| [`secretsExportConfiguration`](#parameter-secretsexportconfiguration) | object | Key vault reference and secret settings for the module's secrets export. |
| [`shardCount`](#parameter-shardcount) | int | The number of shards to be created on a Premium Cluster Cache. |
| [`skuName`](#parameter-skuname) | string | The type of Redis cache to deploy. |
| [`staticIP`](#parameter-staticip) | string | Static IP address. Optionally, may be specified when deploying a Redis cache inside an existing Azure Virtual Network; auto assigned by default. |
| [`subnetResourceId`](#parameter-subnetresourceid) | string | The full resource ID of a subnet in a virtual network to deploy the Redis cache in. |
| [`tags`](#parameter-tags) | object | Tags of the resource. |
| [`tenantSettings`](#parameter-tenantsettings) | object | A dictionary of tenant settings. |
| [`zonalAllocationPolicy`](#parameter-zonalallocationpolicy) | string | Specifies how availability zones are allocated to the Redis cache. "Automatic" enables zone redundancy and Azure will automatically select zones. "UserDefined" will select availability zones passed in by you using the "availabilityZones" parameter. "NoZones" will produce a non-zonal cache. Only applicable when zoneRedundant is true. |
| [`zoneRedundant`](#parameter-zoneredundant) | bool | When true, replicas will be provisioned in availability zones specified in the zones parameter. |

### Parameter: `name`

The name of the Redis cache resource.

- Required: Yes
- Type: string

### Parameter: `accessPolicies`

Array of access policies to create.

- Required: No
- Type: array
- Default: `[]`

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-accesspoliciesname) | string | Name of the access policy. |
| [`permissions`](#parameter-accesspoliciespermissions) | string | Permissions associated with the access policy. |

### Parameter: `accessPolicies.name`

Name of the access policy.

- Required: Yes
- Type: string

### Parameter: `accessPolicies.permissions`

Permissions associated with the access policy.

- Required: Yes
- Type: string

### Parameter: `accessPolicyAssignments`

Array of access policy assignments.

- Required: No
- Type: array
- Default: `[]`

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`accessPolicyName`](#parameter-accesspolicyassignmentsaccesspolicyname) | string | Name of the access policy to be assigned. |
| [`objectId`](#parameter-accesspolicyassignmentsobjectid) | string | Object id to which the access policy will be assigned. |
| [`objectIdAlias`](#parameter-accesspolicyassignmentsobjectidalias) | string | Alias for the target object id. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-accesspolicyassignmentsname) | string | The name of the Access Policy Assignment. |

### Parameter: `accessPolicyAssignments.accessPolicyName`

Name of the access policy to be assigned.

- Required: Yes
- Type: string

### Parameter: `accessPolicyAssignments.objectId`

Object id to which the access policy will be assigned.

- Required: Yes
- Type: string

### Parameter: `accessPolicyAssignments.objectIdAlias`

Alias for the target object id.

- Required: Yes
- Type: string

### Parameter: `accessPolicyAssignments.name`

The name of the Access Policy Assignment.

- Required: No
- Type: string

### Parameter: `availabilityZones`

If the zoneRedundant parameter is true, replicas will be provisioned in the availability zones specified here. Otherwise, the service will choose where replicas are deployed.

- Required: No
- Type: array
- Default:
  ```Bicep
  [
    1
    2
    3
  ]
  ```
- Allowed:
  ```Bicep
  [
    1
    2
    3
  ]
  ```

### Parameter: `capacity`

The size of the Redis cache to deploy. Valid values: for C (Basic/Standard) family (0, 1, 2, 3, 4, 5, 6), for P (Premium) family (1, 2, 3, 4).

- Required: No
- Type: int
- Default: `1`
- Allowed:
  ```Bicep
  [
    0
    1
    2
    3
    4
    5
    6
  ]
  ```

### Parameter: `diagnosticSettings`

The diagnostic settings of the service.

- Required: No
- Type: array

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`eventHubAuthorizationRuleResourceId`](#parameter-diagnosticsettingseventhubauthorizationruleresourceid) | string | Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to. |
| [`eventHubName`](#parameter-diagnosticsettingseventhubname) | string | Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub. |
| [`logAnalyticsDestinationType`](#parameter-diagnosticsettingsloganalyticsdestinationtype) | string | A string indicating whether the export to Log Analytics should use the default destination type, i.e. AzureDiagnostics, or use a destination type. |
| [`logCategoriesAndGroups`](#parameter-diagnosticsettingslogcategoriesandgroups) | array | The name of logs that will be streamed. "allLogs" includes all possible logs for the resource. Set to `[]` to disable log collection. |
| [`marketplacePartnerResourceId`](#parameter-diagnosticsettingsmarketplacepartnerresourceid) | string | The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic Logs. |
| [`metricCategories`](#parameter-diagnosticsettingsmetriccategories) | array | The name of metrics that will be streamed. "allMetrics" includes all possible metrics for the resource. Set to `[]` to disable metric collection. |
| [`name`](#parameter-diagnosticsettingsname) | string | The name of the diagnostic setting. |
| [`storageAccountResourceId`](#parameter-diagnosticsettingsstorageaccountresourceid) | string | Resource ID of the diagnostic storage account. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub. |
| [`workspaceResourceId`](#parameter-diagnosticsettingsworkspaceresourceid) | string | Resource ID of the diagnostic log analytics workspace. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub. |

### Parameter: `diagnosticSettings.eventHubAuthorizationRuleResourceId`

Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.eventHubName`

Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.logAnalyticsDestinationType`

A string indicating whether the export to Log Analytics should use the default destination type, i.e. AzureDiagnostics, or use a destination type.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'AzureDiagnostics'
    'Dedicated'
  ]
  ```

### Parameter: `diagnosticSettings.logCategoriesAndGroups`

The name of logs that will be streamed. "allLogs" includes all possible logs for the resource. Set to `[]` to disable log collection.

- Required: No
- Type: array

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`category`](#parameter-diagnosticsettingslogcategoriesandgroupscategory) | string | Name of a Diagnostic Log category for a resource type this setting is applied to. Set the specific logs to collect here. |
| [`categoryGroup`](#parameter-diagnosticsettingslogcategoriesandgroupscategorygroup) | string | Name of a Diagnostic Log category group for a resource type this setting is applied to. Set to `allLogs` to collect all logs. |
| [`enabled`](#parameter-diagnosticsettingslogcategoriesandgroupsenabled) | bool | Enable or disable the category explicitly. Default is `true`. |

### Parameter: `diagnosticSettings.logCategoriesAndGroups.category`

Name of a Diagnostic Log category for a resource type this setting is applied to. Set the specific logs to collect here.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.logCategoriesAndGroups.categoryGroup`

Name of a Diagnostic Log category group for a resource type this setting is applied to. Set to `allLogs` to collect all logs.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.logCategoriesAndGroups.enabled`

Enable or disable the category explicitly. Default is `true`.

- Required: No
- Type: bool

### Parameter: `diagnosticSettings.marketplacePartnerResourceId`

The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic Logs.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.metricCategories`

The name of metrics that will be streamed. "allMetrics" includes all possible metrics for the resource. Set to `[]` to disable metric collection.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`category`](#parameter-diagnosticsettingsmetriccategoriescategory) | string | Name of a Diagnostic Metric category for a resource type this setting is applied to. Set to `AllMetrics` to collect all metrics. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`enabled`](#parameter-diagnosticsettingsmetriccategoriesenabled) | bool | Enable or disable the category explicitly. Default is `true`. |

### Parameter: `diagnosticSettings.metricCategories.category`

Name of a Diagnostic Metric category for a resource type this setting is applied to. Set to `AllMetrics` to collect all metrics.

- Required: Yes
- Type: string

### Parameter: `diagnosticSettings.metricCategories.enabled`

Enable or disable the category explicitly. Default is `true`.

- Required: No
- Type: bool

### Parameter: `diagnosticSettings.name`

The name of the diagnostic setting.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.storageAccountResourceId`

Resource ID of the diagnostic storage account. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.workspaceResourceId`

Resource ID of the diagnostic log analytics workspace. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.

- Required: No
- Type: string

### Parameter: `disableAccessKeyAuthentication`

Disable authentication via access keys.

- Required: No
- Type: bool
- Default: `False`

### Parameter: `enableNonSslPort`

Specifies whether the non-ssl Redis server port (6379) is enabled.

- Required: No
- Type: bool
- Default: `False`

### Parameter: `enableTelemetry`

Enable/Disable usage telemetry for module.

- Required: No
- Type: bool
- Default: `True`

### Parameter: `firewallRules`

The firewall rules to create in the PostgreSQL flexible server.

- Required: No
- Type: array
- Default: `[]`

### Parameter: `geoReplicationObject`

The geo-replication settings of the service. Requires a Premium SKU. Geo-replication is not supported on a cache with multiple replicas per primary. Secondary cache VM Size must be same or higher as compared to the primary cache VM Size. Geo-replication between a vnet and non vnet cache (and vice-a-versa) not supported.

- Required: No
- Type: object
- Default: `{}`

### Parameter: `location`

The location to deploy the Redis cache service.

- Required: No
- Type: string
- Default: `[resourceGroup().location]`

### Parameter: `lock`

The lock settings of the service.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`kind`](#parameter-lockkind) | string | Specify the type of lock. |
| [`name`](#parameter-lockname) | string | Specify the name of lock. |

### Parameter: `lock.kind`

Specify the type of lock.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'CanNotDelete'
    'None'
    'ReadOnly'
  ]
  ```

### Parameter: `lock.name`

Specify the name of lock.

- Required: No
- Type: string

### Parameter: `managedIdentities`

The managed identity definition for this resource.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`systemAssigned`](#parameter-managedidentitiessystemassigned) | bool | Enables system assigned managed identity on the resource. |
| [`userAssignedResourceIds`](#parameter-managedidentitiesuserassignedresourceids) | array | The resource ID(s) to assign to the resource. Required if a user assigned identity is used for encryption. |

### Parameter: `managedIdentities.systemAssigned`

Enables system assigned managed identity on the resource.

- Required: No
- Type: bool

### Parameter: `managedIdentities.userAssignedResourceIds`

The resource ID(s) to assign to the resource. Required if a user assigned identity is used for encryption.

- Required: No
- Type: array

### Parameter: `minimumTlsVersion`

Requires clients to use a specified TLS version (or higher) to connect.

- Required: No
- Type: string
- Default: `'1.2'`
- Allowed:
  ```Bicep
  [
    '1.0'
    '1.1'
    '1.2'
  ]
  ```

### Parameter: `privateEndpoints`

Configuration details for private endpoints. For security reasons, it is recommended to use private endpoints whenever possible.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`subnetResourceId`](#parameter-privateendpointssubnetresourceid) | string | Resource ID of the subnet where the endpoint needs to be created. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`applicationSecurityGroupResourceIds`](#parameter-privateendpointsapplicationsecuritygroupresourceids) | array | Application security groups in which the Private Endpoint IP configuration is included. |
| [`customDnsConfigs`](#parameter-privateendpointscustomdnsconfigs) | array | Custom DNS configurations. |
| [`customNetworkInterfaceName`](#parameter-privateendpointscustomnetworkinterfacename) | string | The custom name of the network interface attached to the Private Endpoint. |
| [`enableTelemetry`](#parameter-privateendpointsenabletelemetry) | bool | Enable/Disable usage telemetry for module. |
| [`ipConfigurations`](#parameter-privateendpointsipconfigurations) | array | A list of IP configurations of the Private Endpoint. This will be used to map to the first-party Service endpoints. |
| [`isManualConnection`](#parameter-privateendpointsismanualconnection) | bool | If Manual Private Link Connection is required. |
| [`location`](#parameter-privateendpointslocation) | string | The location to deploy the Private Endpoint to. |
| [`lock`](#parameter-privateendpointslock) | object | Specify the type of lock. |
| [`manualConnectionRequestMessage`](#parameter-privateendpointsmanualconnectionrequestmessage) | string | A message passed to the owner of the remote resource with the manual connection request. |
| [`name`](#parameter-privateendpointsname) | string | The name of the Private Endpoint. |
| [`privateDnsZoneGroup`](#parameter-privateendpointsprivatednszonegroup) | object | The private DNS Zone Group to configure for the Private Endpoint. |
| [`privateLinkServiceConnectionName`](#parameter-privateendpointsprivatelinkserviceconnectionname) | string | The name of the private link connection to create. |
| [`resourceGroupResourceId`](#parameter-privateendpointsresourcegroupresourceid) | string | The resource ID of the Resource Group the Private Endpoint will be created in. If not specified, the Resource Group of the provided Virtual Network Subnet is used. |
| [`roleAssignments`](#parameter-privateendpointsroleassignments) | array | Array of role assignments to create. |
| [`service`](#parameter-privateendpointsservice) | string | The subresource to deploy the Private Endpoint for. For example "vault" for a Key Vault Private Endpoint. |
| [`tags`](#parameter-privateendpointstags) | object | Tags to be applied on all resources/Resource Groups in this deployment. |

### Parameter: `privateEndpoints.subnetResourceId`

Resource ID of the subnet where the endpoint needs to be created.

- Required: Yes
- Type: string

### Parameter: `privateEndpoints.applicationSecurityGroupResourceIds`

Application security groups in which the Private Endpoint IP configuration is included.

- Required: No
- Type: array

### Parameter: `privateEndpoints.customDnsConfigs`

Custom DNS configurations.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`ipAddresses`](#parameter-privateendpointscustomdnsconfigsipaddresses) | array | A list of private IP addresses of the private endpoint. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`fqdn`](#parameter-privateendpointscustomdnsconfigsfqdn) | string | FQDN that resolves to private endpoint IP address. |

### Parameter: `privateEndpoints.customDnsConfigs.ipAddresses`

A list of private IP addresses of the private endpoint.

- Required: Yes
- Type: array

### Parameter: `privateEndpoints.customDnsConfigs.fqdn`

FQDN that resolves to private endpoint IP address.

- Required: No
- Type: string

### Parameter: `privateEndpoints.customNetworkInterfaceName`

The custom name of the network interface attached to the Private Endpoint.

- Required: No
- Type: string

### Parameter: `privateEndpoints.enableTelemetry`

Enable/Disable usage telemetry for module.

- Required: No
- Type: bool

### Parameter: `privateEndpoints.ipConfigurations`

A list of IP configurations of the Private Endpoint. This will be used to map to the first-party Service endpoints.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-privateendpointsipconfigurationsname) | string | The name of the resource that is unique within a resource group. |
| [`properties`](#parameter-privateendpointsipconfigurationsproperties) | object | Properties of private endpoint IP configurations. |

### Parameter: `privateEndpoints.ipConfigurations.name`

The name of the resource that is unique within a resource group.

- Required: Yes
- Type: string

### Parameter: `privateEndpoints.ipConfigurations.properties`

Properties of private endpoint IP configurations.

- Required: Yes
- Type: object

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`groupId`](#parameter-privateendpointsipconfigurationspropertiesgroupid) | string | The ID of a group obtained from the remote resource that this private endpoint should connect to. |
| [`memberName`](#parameter-privateendpointsipconfigurationspropertiesmembername) | string | The member name of a group obtained from the remote resource that this private endpoint should connect to. |
| [`privateIPAddress`](#parameter-privateendpointsipconfigurationspropertiesprivateipaddress) | string | A private IP address obtained from the private endpoint's subnet. |

### Parameter: `privateEndpoints.ipConfigurations.properties.groupId`

The ID of a group obtained from the remote resource that this private endpoint should connect to.

- Required: Yes
- Type: string

### Parameter: `privateEndpoints.ipConfigurations.properties.memberName`

The member name of a group obtained from the remote resource that this private endpoint should connect to.

- Required: Yes
- Type: string

### Parameter: `privateEndpoints.ipConfigurations.properties.privateIPAddress`

A private IP address obtained from the private endpoint's subnet.

- Required: Yes
- Type: string

### Parameter: `privateEndpoints.isManualConnection`

If Manual Private Link Connection is required.

- Required: No
- Type: bool

### Parameter: `privateEndpoints.location`

The location to deploy the Private Endpoint to.

- Required: No
- Type: string

### Parameter: `privateEndpoints.lock`

Specify the type of lock.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`kind`](#parameter-privateendpointslockkind) | string | Specify the type of lock. |
| [`name`](#parameter-privateendpointslockname) | string | Specify the name of lock. |

### Parameter: `privateEndpoints.lock.kind`

Specify the type of lock.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'CanNotDelete'
    'None'
    'ReadOnly'
  ]
  ```

### Parameter: `privateEndpoints.lock.name`

Specify the name of lock.

- Required: No
- Type: string

### Parameter: `privateEndpoints.manualConnectionRequestMessage`

A message passed to the owner of the remote resource with the manual connection request.

- Required: No
- Type: string

### Parameter: `privateEndpoints.name`

The name of the Private Endpoint.

- Required: No
- Type: string

### Parameter: `privateEndpoints.privateDnsZoneGroup`

The private DNS Zone Group to configure for the Private Endpoint.

- Required: No
- Type: object

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`privateDnsZoneGroupConfigs`](#parameter-privateendpointsprivatednszonegroupprivatednszonegroupconfigs) | array | The private DNS Zone Groups to associate the Private Endpoint. A DNS Zone Group can support up to 5 DNS zones. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-privateendpointsprivatednszonegroupname) | string | The name of the Private DNS Zone Group. |

### Parameter: `privateEndpoints.privateDnsZoneGroup.privateDnsZoneGroupConfigs`

The private DNS Zone Groups to associate the Private Endpoint. A DNS Zone Group can support up to 5 DNS zones.

- Required: Yes
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`privateDnsZoneResourceId`](#parameter-privateendpointsprivatednszonegroupprivatednszonegroupconfigsprivatednszoneresourceid) | string | The resource id of the private DNS zone. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-privateendpointsprivatednszonegroupprivatednszonegroupconfigsname) | string | The name of the private DNS Zone Group config. |

### Parameter: `privateEndpoints.privateDnsZoneGroup.privateDnsZoneGroupConfigs.privateDnsZoneResourceId`

The resource id of the private DNS zone.

- Required: Yes
- Type: string

### Parameter: `privateEndpoints.privateDnsZoneGroup.privateDnsZoneGroupConfigs.name`

The name of the private DNS Zone Group config.

- Required: No
- Type: string

### Parameter: `privateEndpoints.privateDnsZoneGroup.name`

The name of the Private DNS Zone Group.

- Required: No
- Type: string

### Parameter: `privateEndpoints.privateLinkServiceConnectionName`

The name of the private link connection to create.

- Required: No
- Type: string

### Parameter: `privateEndpoints.resourceGroupResourceId`

The resource ID of the Resource Group the Private Endpoint will be created in. If not specified, the Resource Group of the provided Virtual Network Subnet is used.

- Required: No
- Type: string

### Parameter: `privateEndpoints.roleAssignments`

Array of role assignments to create.

- Required: No
- Type: array
- Roles configurable by name:
  - `'Contributor'`
  - `'DNS Resolver Contributor'`
  - `'DNS Zone Contributor'`
  - `'Domain Services Contributor'`
  - `'Domain Services Reader'`
  - `'Network Contributor'`
  - `'Owner'`
  - `'Private DNS Zone Contributor'`
  - `'Reader'`
  - `'Role Based Access Control Administrator'`

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`principalId`](#parameter-privateendpointsroleassignmentsprincipalid) | string | The principal ID of the principal (user/group/identity) to assign the role to. |
| [`roleDefinitionIdOrName`](#parameter-privateendpointsroleassignmentsroledefinitionidorname) | string | The role to assign. You can provide either the display name of the role definition, the role definition GUID, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`condition`](#parameter-privateendpointsroleassignmentscondition) | string | The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container". |
| [`conditionVersion`](#parameter-privateendpointsroleassignmentsconditionversion) | string | Version of the condition. |
| [`delegatedManagedIdentityResourceId`](#parameter-privateendpointsroleassignmentsdelegatedmanagedidentityresourceid) | string | The Resource Id of the delegated managed identity resource. |
| [`description`](#parameter-privateendpointsroleassignmentsdescription) | string | The description of the role assignment. |
| [`name`](#parameter-privateendpointsroleassignmentsname) | string | The name (as GUID) of the role assignment. If not provided, a GUID will be generated. |
| [`principalType`](#parameter-privateendpointsroleassignmentsprincipaltype) | string | The principal type of the assigned principal ID. |

### Parameter: `privateEndpoints.roleAssignments.principalId`

The principal ID of the principal (user/group/identity) to assign the role to.

- Required: Yes
- Type: string

### Parameter: `privateEndpoints.roleAssignments.roleDefinitionIdOrName`

The role to assign. You can provide either the display name of the role definition, the role definition GUID, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.

- Required: Yes
- Type: string

### Parameter: `privateEndpoints.roleAssignments.condition`

The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container".

- Required: No
- Type: string

### Parameter: `privateEndpoints.roleAssignments.conditionVersion`

Version of the condition.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    '2.0'
  ]
  ```

### Parameter: `privateEndpoints.roleAssignments.delegatedManagedIdentityResourceId`

The Resource Id of the delegated managed identity resource.

- Required: No
- Type: string

### Parameter: `privateEndpoints.roleAssignments.description`

The description of the role assignment.

- Required: No
- Type: string

### Parameter: `privateEndpoints.roleAssignments.name`

The name (as GUID) of the role assignment. If not provided, a GUID will be generated.

- Required: No
- Type: string

### Parameter: `privateEndpoints.roleAssignments.principalType`

The principal type of the assigned principal ID.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'Device'
    'ForeignGroup'
    'Group'
    'ServicePrincipal'
    'User'
  ]
  ```

### Parameter: `privateEndpoints.service`

The subresource to deploy the Private Endpoint for. For example "vault" for a Key Vault Private Endpoint.

- Required: No
- Type: string

### Parameter: `privateEndpoints.tags`

Tags to be applied on all resources/Resource Groups in this deployment.

- Required: No
- Type: object

### Parameter: `publicNetworkAccess`

Whether or not public network access is allowed for this resource. For security reasons it should be disabled. If not specified, it will be disabled by default if private endpoints are set.

- Required: No
- Type: string
- Default: `''`
- Allowed:
  ```Bicep
  [
    ''
    'Disabled'
    'Enabled'
  ]
  ```

### Parameter: `redisConfiguration`

All Redis Settings. Few possible keys: rdb-backup-enabled,rdb-storage-connection-string,rdb-backup-frequency,maxmemory-delta,maxmemory-policy,notify-keyspace-events,maxmemory-samples,slowlog-log-slower-than,slowlog-max-len,list-max-ziplist-entries,list-max-ziplist-value,hash-max-ziplist-entries,hash-max-ziplist-value,set-max-intset-entries,zset-max-ziplist-entries,zset-max-ziplist-value etc.

- Required: No
- Type: object
- Default: `{}`

### Parameter: `redisVersion`

Redis version. Only major version will be used in PUT/PATCH request with current valid values: (4, 6).

- Required: No
- Type: string
- Default: `'6'`
- Allowed:
  ```Bicep
  [
    '4'
    '6'
  ]
  ```

### Parameter: `replicasPerMaster`

The number of replicas to be created per primary.

- Required: No
- Type: int
- Default: `3`
- MinValue: 1

### Parameter: `replicasPerPrimary`

The number of replicas to be created per primary. Needs to be the same as replicasPerMaster for a Premium Cluster Cache.

- Required: No
- Type: int
- Default: `3`
- MinValue: 1

### Parameter: `roleAssignments`

Array of role assignments to create.

- Required: No
- Type: array
- Roles configurable by name:
  - `'Contributor'`
  - `'Owner'`
  - `'Reader'`
  - `'Redis Cache Contributor'`
  - `'Role Based Access Control Administrator'`
  - `'User Access Administrator'`

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`principalId`](#parameter-roleassignmentsprincipalid) | string | The principal ID of the principal (user/group/identity) to assign the role to. |
| [`roleDefinitionIdOrName`](#parameter-roleassignmentsroledefinitionidorname) | string | The role to assign. You can provide either the display name of the role definition, the role definition GUID, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`condition`](#parameter-roleassignmentscondition) | string | The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container". |
| [`conditionVersion`](#parameter-roleassignmentsconditionversion) | string | Version of the condition. |
| [`delegatedManagedIdentityResourceId`](#parameter-roleassignmentsdelegatedmanagedidentityresourceid) | string | The Resource Id of the delegated managed identity resource. |
| [`description`](#parameter-roleassignmentsdescription) | string | The description of the role assignment. |
| [`name`](#parameter-roleassignmentsname) | string | The name (as GUID) of the role assignment. If not provided, a GUID will be generated. |
| [`principalType`](#parameter-roleassignmentsprincipaltype) | string | The principal type of the assigned principal ID. |

### Parameter: `roleAssignments.principalId`

The principal ID of the principal (user/group/identity) to assign the role to.

- Required: Yes
- Type: string

### Parameter: `roleAssignments.roleDefinitionIdOrName`

The role to assign. You can provide either the display name of the role definition, the role definition GUID, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.

- Required: Yes
- Type: string

### Parameter: `roleAssignments.condition`

The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container".

- Required: No
- Type: string

### Parameter: `roleAssignments.conditionVersion`

Version of the condition.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    '2.0'
  ]
  ```

### Parameter: `roleAssignments.delegatedManagedIdentityResourceId`

The Resource Id of the delegated managed identity resource.

- Required: No
- Type: string

### Parameter: `roleAssignments.description`

The description of the role assignment.

- Required: No
- Type: string

### Parameter: `roleAssignments.name`

The name (as GUID) of the role assignment. If not provided, a GUID will be generated.

- Required: No
- Type: string

### Parameter: `roleAssignments.principalType`

The principal type of the assigned principal ID.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'Device'
    'ForeignGroup'
    'Group'
    'ServicePrincipal'
    'User'
  ]
  ```

### Parameter: `secretsExportConfiguration`

Key vault reference and secret settings for the module's secrets export.

- Required: No
- Type: object

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`keyVaultResourceId`](#parameter-secretsexportconfigurationkeyvaultresourceid) | string | The resource ID of the key vault where to store the secrets of this module. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`primaryAccessKeyName`](#parameter-secretsexportconfigurationprimaryaccesskeyname) | string | The primaryAccessKey secret name to create. |
| [`primaryConnectionStringName`](#parameter-secretsexportconfigurationprimaryconnectionstringname) | string | The primaryConnectionString secret name to create. |
| [`primaryStackExchangeRedisConnectionStringName`](#parameter-secretsexportconfigurationprimarystackexchangeredisconnectionstringname) | string | The primaryStackExchangeRedisConnectionString secret name to create. |
| [`secondaryAccessKeyName`](#parameter-secretsexportconfigurationsecondaryaccesskeyname) | string | The secondaryAccessKey secret name to create. |
| [`secondaryConnectionStringName`](#parameter-secretsexportconfigurationsecondaryconnectionstringname) | string | The secondaryConnectionString secret name to create. |
| [`secondaryStackExchangeRedisConnectionStringName`](#parameter-secretsexportconfigurationsecondarystackexchangeredisconnectionstringname) | string | The secondaryStackExchangeRedisConnectionString secret name to create. |

### Parameter: `secretsExportConfiguration.keyVaultResourceId`

The resource ID of the key vault where to store the secrets of this module.

- Required: Yes
- Type: string

### Parameter: `secretsExportConfiguration.primaryAccessKeyName`

The primaryAccessKey secret name to create.

- Required: No
- Type: string

### Parameter: `secretsExportConfiguration.primaryConnectionStringName`

The primaryConnectionString secret name to create.

- Required: No
- Type: string

### Parameter: `secretsExportConfiguration.primaryStackExchangeRedisConnectionStringName`

The primaryStackExchangeRedisConnectionString secret name to create.

- Required: No
- Type: string

### Parameter: `secretsExportConfiguration.secondaryAccessKeyName`

The secondaryAccessKey secret name to create.

- Required: No
- Type: string

### Parameter: `secretsExportConfiguration.secondaryConnectionStringName`

The secondaryConnectionString secret name to create.

- Required: No
- Type: string

### Parameter: `secretsExportConfiguration.secondaryStackExchangeRedisConnectionStringName`

The secondaryStackExchangeRedisConnectionString secret name to create.

- Required: No
- Type: string

### Parameter: `shardCount`

The number of shards to be created on a Premium Cluster Cache.

- Required: No
- Type: int
- MinValue: 1

### Parameter: `skuName`

The type of Redis cache to deploy.

- Required: No
- Type: string
- Default: `'Premium'`
- Allowed:
  ```Bicep
  [
    'Basic'
    'Premium'
    'Standard'
  ]
  ```

### Parameter: `staticIP`

Static IP address. Optionally, may be specified when deploying a Redis cache inside an existing Azure Virtual Network; auto assigned by default.

- Required: No
- Type: string
- Default: `''`

### Parameter: `subnetResourceId`

The full resource ID of a subnet in a virtual network to deploy the Redis cache in.

- Required: No
- Type: string
- Default: `''`

### Parameter: `tags`

Tags of the resource.

- Required: No
- Type: object

### Parameter: `tenantSettings`

A dictionary of tenant settings.

- Required: No
- Type: object
- Default: `{}`

### Parameter: `zonalAllocationPolicy`

Specifies how availability zones are allocated to the Redis cache. "Automatic" enables zone redundancy and Azure will automatically select zones. "UserDefined" will select availability zones passed in by you using the "availabilityZones" parameter. "NoZones" will produce a non-zonal cache. Only applicable when zoneRedundant is true.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'Automatic'
    'NoZones'
    'UserDefined'
  ]
  ```

### Parameter: `zoneRedundant`

When true, replicas will be provisioned in availability zones specified in the zones parameter.

- Required: No
- Type: bool
- Default: `True`

## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `exportedSecrets` |  | A hashtable of references to the secrets exported to the provided Key Vault. The key of each reference is each secret's name. |
| `hostName` | string | Redis hostname. |
| `location` | string | The location the resource was deployed into. |
| `name` | string | The name of the Redis Cache. |
| `privateEndpoints` | array | The private endpoints of the Redis Cache. |
| `resourceGroupName` | string | The name of the resource group the Redis Cache was created in. |
| `resourceId` | string | The resource ID of the Redis Cache. |
| `sslPort` | int | Redis SSL port. |
| `subnetResourceId` | string | The full resource ID of a subnet in a virtual network where the Redis Cache was deployed in. |
| `systemAssignedMIPrincipalId` | string | The principal ID of the system assigned identity. |

## Cross-referenced modules

This section gives you an overview of all local-referenced module files (i.e., other modules that are referenced in this module) and all remote-referenced files (i.e., Bicep modules that are referenced from a Bicep Registry or Template Specs).

| Reference | Type |
| :-- | :-- |
| `br/public:avm/res/network/private-endpoint:0.11.0` | Remote reference |
| `br/public:avm/utl/types/avm-common-types:0.5.1` | Remote reference |
| `br/public:avm/utl/types/avm-common-types:0.6.0` | Remote reference |

## Notes

### Parameter Usage: `redisConfiguration`

All Redis Settings. Few possible keys: rdb-backup-enabled,rdb-storage-connection-string,rdb-backup-frequency,maxmemory-delta,maxmemory-policy,notify-keyspace-events,maxmemory-samples,slowlog-log-slower-than,slowlog-max-len,list-max-ziplist-entries,list-max-ziplist-value,hash-max-ziplist-entries,hash-max-ziplist-value,set-max-intset-entries,zset-max-ziplist-entries,zset-max-ziplist-value etc..

Name | Description | Value
---------|----------|---------
aof-storage-connection-string-0 | First storage account connection string | string
aof-storage-connection-string-1 | Second storage account connection string | string
maxfragmentationmemory-reserved | Value in megabytes reserved for fragmentation per shard | string
maxmemory-delta | Value in megabytes reserved for non-cache usage per shard e.g. failover. | string
maxmemory-policy | The eviction strategy used when your data won't fit within its memory limit. | string
maxmemory-reserved | Value in megabytes reserved for non-cache usage per shard e.g. failover. | string
rdb-backup-enabled | Specifies whether the rdb backup is enabled | string
rdb-backup-frequency | Specifies the frequency for creating rdb backup | string
rdb-backup-max-snapshot-count | Specifies the maximum number of snapshots for rdb backup | string
rdb-storage-connection-string | The storage account connection string for storing rdb file | string

For more details visit [Microsoft.Cache redis reference](https://learn.microsoft.com/en-us/azure/templates/microsoft.cache/redis?tabs=bicep)

<details>

<summary>Bicep format</summary>

```bicep
userAssignedIdentities: {
    '/subscriptions/12345678-1234-1234-1234-123456789012/resourcegroups/validation-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/adp-sxx-az-msi-x-001': {}
    '/subscriptions/12345678-1234-1234-1234-123456789012/resourcegroups/validation-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/adp-sxx-az-msi-x-002': {}
}
```

</details>
<p>

## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the [repository](https://aka.ms/avm/telemetry). There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
