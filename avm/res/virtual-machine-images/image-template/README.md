# Virtual Machine Image Templates `[Microsoft.VirtualMachineImages/imageTemplates]`

This module deploys a Virtual Machine Image Template that can be consumed by Azure Image Builder (AIB).

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
| `Microsoft.VirtualMachineImages/imageTemplates` | [2024-02-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.VirtualMachineImages/2024-02-01/imageTemplates) |

## Usage examples

The following section provides usage examples for the module, which were used to validate and deploy the module successfully. For a full reference, please review the module's test folder in its repository.

>**Note**: Each example lists all the required parameters first, followed by the rest - each in alphabetical order.

>**Note**: To reference the module, please use the following syntax `br/public:avm/res/virtual-machine-images/image-template:<version>`.

- [Using only defaults](#example-1-using-only-defaults)
- [Using large parameter set](#example-2-using-large-parameter-set)
- [WAF-aligned](#example-3-waf-aligned)

### Example 1: _Using only defaults_

This instance deploys the module with the minimum set of required parameters.


<details>

<summary>via Bicep module</summary>

```bicep
module imageTemplate 'br/public:avm/res/virtual-machine-images/image-template:<version>' = {
  name: 'imageTemplateDeployment'
  params: {
    // Required parameters
    distributions: [
      {
        imageName: 'mi-vmiitmin-001'
        type: 'ManagedImage'
      }
    ]
    imageSource: {
      offer: 'Windows-11'
      publisher: 'MicrosoftWindowsDesktop'
      sku: 'win11-23h2-ent'
      type: 'PlatformImage'
      version: 'latest'
    }
    managedIdentities: {
      userAssignedResourceIds: [
        '<managedIdentityResourceId>'
      ]
    }
    name: 'vmiitmin001'
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
    "distributions": {
      "value": [
        {
          "imageName": "mi-vmiitmin-001",
          "type": "ManagedImage"
        }
      ]
    },
    "imageSource": {
      "value": {
        "offer": "Windows-11",
        "publisher": "MicrosoftWindowsDesktop",
        "sku": "win11-23h2-ent",
        "type": "PlatformImage",
        "version": "latest"
      }
    },
    "managedIdentities": {
      "value": {
        "userAssignedResourceIds": [
          "<managedIdentityResourceId>"
        ]
      }
    },
    "name": {
      "value": "vmiitmin001"
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/virtual-machine-images/image-template:<version>'

// Required parameters
param distributions = [
  {
    imageName: 'mi-vmiitmin-001'
    type: 'ManagedImage'
  }
]
param imageSource = {
  offer: 'Windows-11'
  publisher: 'MicrosoftWindowsDesktop'
  sku: 'win11-23h2-ent'
  type: 'PlatformImage'
  version: 'latest'
}
param managedIdentities = {
  userAssignedResourceIds: [
    '<managedIdentityResourceId>'
  ]
}
param name = 'vmiitmin001'
```

</details>
<p>

### Example 2: _Using large parameter set_

This instance deploys the module with most of its features enabled.


<details>

<summary>via Bicep module</summary>

```bicep
module imageTemplate 'br/public:avm/res/virtual-machine-images/image-template:<version>' = {
  name: 'imageTemplateDeployment'
  params: {
    // Required parameters
    distributions: [
      {
        imageName: 'mi-vmiitmax-001'
        type: 'ManagedImage'
      }
      {
        imageName: 'umi-vmiitmax-001'
        type: 'VHD'
      }
      {
        replicationRegions: [
          '<resourceLocation>'
        ]
        sharedImageGalleryImageDefinitionResourceId: '<sharedImageGalleryImageDefinitionResourceId>'
        sharedImageGalleryImageDefinitionTargetVersion: '<sharedImageGalleryImageDefinitionTargetVersion>'
        type: 'SharedImage'
      }
    ]
    imageSource: {
      offer: 'ubuntu-24_04-lts'
      publisher: 'canonical'
      sku: 'server'
      type: 'PlatformImage'
      version: 'latest'
    }
    managedIdentities: {
      userAssignedResourceIds: [
        '<managedIdentityResourceId>'
      ]
    }
    name: 'vmiitmax001'
    // Non-required parameters
    autoRunState: 'Enabled'
    buildTimeoutInMinutes: 60
    customizationSteps: [
      {
        name: 'PowerShell installation'
        scriptUri: '<scriptUri>'
        type: 'Shell'
      }
      {
        destination: 'Initialize-LinuxSoftware.ps1'
        name: 'Initialize-LinuxSoftware'
        sourceUri: '<sourceUri>'
        type: 'File'
      }
      {
        inline: [
          'pwsh \'Initialize-LinuxSoftware.ps1\''
        ]
        name: 'Software installation'
        type: 'Shell'
      }
    ]
    errorHandlingOnCustomizerError: 'cleanup'
    errorHandlingOnValidationError: 'abort'
    location: '<location>'
    lock: {
      kind: 'CanNotDelete'
      name: 'myCustomLockName'
    }
    managedResourceTags: {
      testKey1: 'testValue1'
      testKey2: 'testValue2'
    }
    optimizeVmBoot: 'Enabled'
    osDiskSizeGB: 127
    roleAssignments: [
      {
        name: 'bb257a92-dc06-4831-9b74-ee5442d8ce0f'
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
    stagingResourceGroupResourceId: '<stagingResourceGroupResourceId>'
    tags: {
      Environment: 'Non-Prod'
      'hidden-title': 'This is visible in the resource name'
      Role: 'DeploymentValidation'
    }
    validationProcess: {
      continueDistributeOnFailure: true
      inVMValidations: [
        {
          inline: [
            'echo \'Software validation successful.\''
          ]
          name: 'Validate-Software'
          type: 'Shell'
        }
      ]
      sourceValidationOnly: false
    }
    vmSize: 'Standard_D2s_v3'
    vmUserAssignedIdentities: [
      '<managedIdentityResourceId>'
    ]
    vnetConfig: {
      proxyVmSize: 'Standard_A1_v2'
      subnetResourceId: '<subnetResourceId>'
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
    "distributions": {
      "value": [
        {
          "imageName": "mi-vmiitmax-001",
          "type": "ManagedImage"
        },
        {
          "imageName": "umi-vmiitmax-001",
          "type": "VHD"
        },
        {
          "replicationRegions": [
            "<resourceLocation>"
          ],
          "sharedImageGalleryImageDefinitionResourceId": "<sharedImageGalleryImageDefinitionResourceId>",
          "sharedImageGalleryImageDefinitionTargetVersion": "<sharedImageGalleryImageDefinitionTargetVersion>",
          "type": "SharedImage"
        }
      ]
    },
    "imageSource": {
      "value": {
        "offer": "ubuntu-24_04-lts",
        "publisher": "canonical",
        "sku": "server",
        "type": "PlatformImage",
        "version": "latest"
      }
    },
    "managedIdentities": {
      "value": {
        "userAssignedResourceIds": [
          "<managedIdentityResourceId>"
        ]
      }
    },
    "name": {
      "value": "vmiitmax001"
    },
    // Non-required parameters
    "autoRunState": {
      "value": "Enabled"
    },
    "buildTimeoutInMinutes": {
      "value": 60
    },
    "customizationSteps": {
      "value": [
        {
          "name": "PowerShell installation",
          "scriptUri": "<scriptUri>",
          "type": "Shell"
        },
        {
          "destination": "Initialize-LinuxSoftware.ps1",
          "name": "Initialize-LinuxSoftware",
          "sourceUri": "<sourceUri>",
          "type": "File"
        },
        {
          "inline": [
            "pwsh \"Initialize-LinuxSoftware.ps1\""
          ],
          "name": "Software installation",
          "type": "Shell"
        }
      ]
    },
    "errorHandlingOnCustomizerError": {
      "value": "cleanup"
    },
    "errorHandlingOnValidationError": {
      "value": "abort"
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
    "managedResourceTags": {
      "value": {
        "testKey1": "testValue1",
        "testKey2": "testValue2"
      }
    },
    "optimizeVmBoot": {
      "value": "Enabled"
    },
    "osDiskSizeGB": {
      "value": 127
    },
    "roleAssignments": {
      "value": [
        {
          "name": "bb257a92-dc06-4831-9b74-ee5442d8ce0f",
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
    "stagingResourceGroupResourceId": {
      "value": "<stagingResourceGroupResourceId>"
    },
    "tags": {
      "value": {
        "Environment": "Non-Prod",
        "hidden-title": "This is visible in the resource name",
        "Role": "DeploymentValidation"
      }
    },
    "validationProcess": {
      "value": {
        "continueDistributeOnFailure": true,
        "inVMValidations": [
          {
            "inline": [
              "echo \"Software validation successful.\""
            ],
            "name": "Validate-Software",
            "type": "Shell"
          }
        ],
        "sourceValidationOnly": false
      }
    },
    "vmSize": {
      "value": "Standard_D2s_v3"
    },
    "vmUserAssignedIdentities": {
      "value": [
        "<managedIdentityResourceId>"
      ]
    },
    "vnetConfig": {
      "value": {
        "proxyVmSize": "Standard_A1_v2",
        "subnetResourceId": "<subnetResourceId>"
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
using 'br/public:avm/res/virtual-machine-images/image-template:<version>'

// Required parameters
param distributions = [
  {
    imageName: 'mi-vmiitmax-001'
    type: 'ManagedImage'
  }
  {
    imageName: 'umi-vmiitmax-001'
    type: 'VHD'
  }
  {
    replicationRegions: [
      '<resourceLocation>'
    ]
    sharedImageGalleryImageDefinitionResourceId: '<sharedImageGalleryImageDefinitionResourceId>'
    sharedImageGalleryImageDefinitionTargetVersion: '<sharedImageGalleryImageDefinitionTargetVersion>'
    type: 'SharedImage'
  }
]
param imageSource = {
  offer: 'ubuntu-24_04-lts'
  publisher: 'canonical'
  sku: 'server'
  type: 'PlatformImage'
  version: 'latest'
}
param managedIdentities = {
  userAssignedResourceIds: [
    '<managedIdentityResourceId>'
  ]
}
param name = 'vmiitmax001'
// Non-required parameters
param autoRunState = 'Enabled'
param buildTimeoutInMinutes = 60
param customizationSteps = [
  {
    name: 'PowerShell installation'
    scriptUri: '<scriptUri>'
    type: 'Shell'
  }
  {
    destination: 'Initialize-LinuxSoftware.ps1'
    name: 'Initialize-LinuxSoftware'
    sourceUri: '<sourceUri>'
    type: 'File'
  }
  {
    inline: [
      'pwsh \'Initialize-LinuxSoftware.ps1\''
    ]
    name: 'Software installation'
    type: 'Shell'
  }
]
param errorHandlingOnCustomizerError = 'cleanup'
param errorHandlingOnValidationError = 'abort'
param location = '<location>'
param lock = {
  kind: 'CanNotDelete'
  name: 'myCustomLockName'
}
param managedResourceTags = {
  testKey1: 'testValue1'
  testKey2: 'testValue2'
}
param optimizeVmBoot = 'Enabled'
param osDiskSizeGB = 127
param roleAssignments = [
  {
    name: 'bb257a92-dc06-4831-9b74-ee5442d8ce0f'
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
param stagingResourceGroupResourceId = '<stagingResourceGroupResourceId>'
param tags = {
  Environment: 'Non-Prod'
  'hidden-title': 'This is visible in the resource name'
  Role: 'DeploymentValidation'
}
param validationProcess = {
  continueDistributeOnFailure: true
  inVMValidations: [
    {
      inline: [
        'echo \'Software validation successful.\''
      ]
      name: 'Validate-Software'
      type: 'Shell'
    }
  ]
  sourceValidationOnly: false
}
param vmSize = 'Standard_D2s_v3'
param vmUserAssignedIdentities = [
  '<managedIdentityResourceId>'
]
param vnetConfig = {
  proxyVmSize: 'Standard_A1_v2'
  subnetResourceId: '<subnetResourceId>'
}
```

</details>
<p>

### Example 3: _WAF-aligned_

This instance deploys the module in alignment with the best-practices of the Azure Well-Architected Framework.


<details>

<summary>via Bicep module</summary>

```bicep
module imageTemplate 'br/public:avm/res/virtual-machine-images/image-template:<version>' = {
  name: 'imageTemplateDeployment'
  params: {
    // Required parameters
    distributions: [
      {
        sharedImageGalleryImageDefinitionResourceId: '<sharedImageGalleryImageDefinitionResourceId>'
        type: 'SharedImage'
      }
    ]
    imageSource: {
      offer: 'Windows-11'
      publisher: 'MicrosoftWindowsDesktop'
      sku: 'win11-22h2-avd'
      type: 'PlatformImage'
      version: 'latest'
    }
    managedIdentities: {
      userAssignedResourceIds: [
        '<managedIdentityResourceId>'
      ]
    }
    name: 'vmiitwaf001'
    // Non-required parameters
    customizationSteps: [
      {
        restartTimeout: '10m'
        type: 'WindowsRestart'
      }
    ]
    tags: {
      Environment: 'Non-Prod'
      'hidden-title': 'This is visible in the resource name'
      Role: 'DeploymentValidation'
    }
    vnetConfig: {
      containerInstanceSubnetResourceId: '<containerInstanceSubnetResourceId>'
      subnetResourceId: '<subnetResourceId>'
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
    "distributions": {
      "value": [
        {
          "sharedImageGalleryImageDefinitionResourceId": "<sharedImageGalleryImageDefinitionResourceId>",
          "type": "SharedImage"
        }
      ]
    },
    "imageSource": {
      "value": {
        "offer": "Windows-11",
        "publisher": "MicrosoftWindowsDesktop",
        "sku": "win11-22h2-avd",
        "type": "PlatformImage",
        "version": "latest"
      }
    },
    "managedIdentities": {
      "value": {
        "userAssignedResourceIds": [
          "<managedIdentityResourceId>"
        ]
      }
    },
    "name": {
      "value": "vmiitwaf001"
    },
    // Non-required parameters
    "customizationSteps": {
      "value": [
        {
          "restartTimeout": "10m",
          "type": "WindowsRestart"
        }
      ]
    },
    "tags": {
      "value": {
        "Environment": "Non-Prod",
        "hidden-title": "This is visible in the resource name",
        "Role": "DeploymentValidation"
      }
    },
    "vnetConfig": {
      "value": {
        "containerInstanceSubnetResourceId": "<containerInstanceSubnetResourceId>",
        "subnetResourceId": "<subnetResourceId>"
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
using 'br/public:avm/res/virtual-machine-images/image-template:<version>'

// Required parameters
param distributions = [
  {
    sharedImageGalleryImageDefinitionResourceId: '<sharedImageGalleryImageDefinitionResourceId>'
    type: 'SharedImage'
  }
]
param imageSource = {
  offer: 'Windows-11'
  publisher: 'MicrosoftWindowsDesktop'
  sku: 'win11-22h2-avd'
  type: 'PlatformImage'
  version: 'latest'
}
param managedIdentities = {
  userAssignedResourceIds: [
    '<managedIdentityResourceId>'
  ]
}
param name = 'vmiitwaf001'
// Non-required parameters
param customizationSteps = [
  {
    restartTimeout: '10m'
    type: 'WindowsRestart'
  }
]
param tags = {
  Environment: 'Non-Prod'
  'hidden-title': 'This is visible in the resource name'
  Role: 'DeploymentValidation'
}
param vnetConfig = {
  containerInstanceSubnetResourceId: '<containerInstanceSubnetResourceId>'
  subnetResourceId: '<subnetResourceId>'
}
```

</details>
<p>

## Parameters

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`distributions`](#parameter-distributions) | array | The distribution targets where the image output needs to go to. |
| [`imageSource`](#parameter-imagesource) | object | Image source definition in object format. |
| [`managedIdentities`](#parameter-managedidentities) | object | The managed identity definition for this resource. |
| [`name`](#parameter-name) | string | The name prefix of the Image Template to be built by the Azure Image Builder service. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`autoRunState`](#parameter-autorunstate) | string | Indicates whether or not to automatically run the image template build on template creation or update. |
| [`buildTimeoutInMinutes`](#parameter-buildtimeoutinminutes) | int | The image build timeout in minutes. 0 means the default 240 minutes. |
| [`customizationSteps`](#parameter-customizationsteps) | array | Customization steps to be run when building the VM image. |
| [`enableTelemetry`](#parameter-enabletelemetry) | bool | Enable/Disable usage telemetry for module. |
| [`errorHandlingOnCustomizerError`](#parameter-errorhandlingoncustomizererror) | string | If there is a customizer error and this field is set to 'cleanup', the build VM and associated network resources will be cleaned up. This is the default behavior. If there is a customizer error and this field is set to 'abort', the build VM will be preserved. |
| [`errorHandlingOnValidationError`](#parameter-errorhandlingonvalidationerror) | string | If there is a validation error and this field is set to 'cleanup', the build VM and associated network resources will be cleaned up. If there is a validation error and this field is set to 'abort', the build VM will be preserved. This is the default behavior. |
| [`location`](#parameter-location) | string | Location for all resources. |
| [`lock`](#parameter-lock) | object | The lock settings of the service. |
| [`managedResourceTags`](#parameter-managedresourcetags) | object | Tags that will be applied to the resource group and/or resources created by the service. |
| [`optimizeVmBoot`](#parameter-optimizevmboot) | string | The optimize property can be enabled while creating a VM image and allows VM optimization to improve image creation time. |
| [`osDiskSizeGB`](#parameter-osdisksizegb) | int | Specifies the size of OS disk. |
| [`roleAssignments`](#parameter-roleassignments) | array | Array of role assignments to create. |
| [`stagingResourceGroupResourceId`](#parameter-stagingresourcegroupresourceid) | string | Resource ID of the staging resource group in the same subscription and location as the image template that will be used to build the image.</p>If this field is empty, a resource group with a random name will be created.</p>If the resource group specified in this field doesn't exist, it will be created with the same name.</p>If the resource group specified exists, it must be empty and in the same region as the image template.</p>The resource group created will be deleted during template deletion if this field is empty or the resource group specified doesn't exist,</p>but if the resource group specified exists the resources created in the resource group will be deleted during template deletion and the resource group itself will remain. |
| [`tags`](#parameter-tags) | object | Tags of the resource. |
| [`validationProcess`](#parameter-validationprocess) | object | Configuration options and list of validations to be performed on the resulting image. |
| [`vmSize`](#parameter-vmsize) | string | Specifies the size for the VM. |
| [`vmUserAssignedIdentities`](#parameter-vmuserassignedidentities) | array | List of User-Assigned Identities associated to the Build VM for accessing Azure resources such as Key Vaults from your customizer scripts. Be aware, the user assigned identities specified in the 'managedIdentities' parameter must have the 'Managed Identity Operator' role assignment on all the user assigned identities specified in this parameter for Azure Image Builder to be able to associate them to the build VM. |
| [`vnetConfig`](#parameter-vnetconfig) | object | Optional configuration of the virtual network to use to deploy the build VM and validation VM in. Omit if no specific virtual network needs to be used. |

**Generated parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`baseTime`](#parameter-basetime) | string | Do not provide a value! This date is used to generate a unique image template name. |

### Parameter: `distributions`

The distribution targets where the image output needs to go to.

- Required: Yes
- Type: array
- Discriminator: `type`

<h4>The available variants are:</h4>

| Variant | Description |
| :-- | :-- |
| [`SharedImage`](#variant-distributionstype-sharedimage) | The type for a shared image distribution. |
| [`ManagedImage`](#variant-distributionstype-managedimage) | The type for a managed image distribution. |
| [`VHD`](#variant-distributionstype-vhd) | The type for an unmanaged distribution. |

### Variant: `distributions.type-SharedImage`
The type for a shared image distribution.

To use this variant, set the property `type` to `SharedImage`.

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`sharedImageGalleryImageDefinitionResourceId`](#parameter-distributionstype-sharedimagesharedimagegalleryimagedefinitionresourceid) | string | Resource ID of Compute Gallery Image Definition to distribute image to, e.g.: /subscriptions/<subscriptionID>/resourceGroups/<SIG resourcegroup>/providers/Microsoft.Compute/galleries/<SIG name>/images/<image definition>. |
| [`type`](#parameter-distributionstype-sharedimagetype) | string | The type of distribution. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`artifactTags`](#parameter-distributionstype-sharedimageartifacttags) | object | Tags that will be applied to the artifact once it has been created/updated by the distributor. If not provided will set tags based on the provided image source. |
| [`excludeFromLatest`](#parameter-distributionstype-sharedimageexcludefromlatest) | bool | The exclude from latest flag of the image. Defaults to [false]. |
| [`replicationRegions`](#parameter-distributionstype-sharedimagereplicationregions) | array | The replication regions of the image. Defaults to the value of the 'location' parameter. |
| [`runOutputName`](#parameter-distributionstype-sharedimagerunoutputname) | string | The name to be used for the associated RunOutput. If not provided, a name will be calculated. |
| [`sharedImageGalleryImageDefinitionTargetVersion`](#parameter-distributionstype-sharedimagesharedimagegalleryimagedefinitiontargetversion) | string | Version of the Compute Gallery Image. Supports the following Version Syntax: Major.Minor.Build (i.e., '1.1.1' or '10.1.2'). If not provided, a version will be calculated. |
| [`storageAccountType`](#parameter-distributionstype-sharedimagestorageaccounttype) | string | The storage account type of the image. Defaults to [Standard_LRS]. |

### Parameter: `distributions.type-SharedImage.sharedImageGalleryImageDefinitionResourceId`

Resource ID of Compute Gallery Image Definition to distribute image to, e.g.: /subscriptions/<subscriptionID>/resourceGroups/<SIG resourcegroup>/providers/Microsoft.Compute/galleries/<SIG name>/images/<image definition>.

- Required: Yes
- Type: string

### Parameter: `distributions.type-SharedImage.type`

The type of distribution.

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'SharedImage'
  ]
  ```

### Parameter: `distributions.type-SharedImage.artifactTags`

Tags that will be applied to the artifact once it has been created/updated by the distributor. If not provided will set tags based on the provided image source.

- Required: No
- Type: object

### Parameter: `distributions.type-SharedImage.excludeFromLatest`

The exclude from latest flag of the image. Defaults to [false].

- Required: No
- Type: bool

### Parameter: `distributions.type-SharedImage.replicationRegions`

The replication regions of the image. Defaults to the value of the 'location' parameter.

- Required: No
- Type: array

### Parameter: `distributions.type-SharedImage.runOutputName`

The name to be used for the associated RunOutput. If not provided, a name will be calculated.

- Required: No
- Type: string

### Parameter: `distributions.type-SharedImage.sharedImageGalleryImageDefinitionTargetVersion`

Version of the Compute Gallery Image. Supports the following Version Syntax: Major.Minor.Build (i.e., '1.1.1' or '10.1.2'). If not provided, a version will be calculated.

- Required: No
- Type: string

### Parameter: `distributions.type-SharedImage.storageAccountType`

The storage account type of the image. Defaults to [Standard_LRS].

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'Standard_LRS'
    'Standard_ZRS'
  ]
  ```

### Variant: `distributions.type-ManagedImage`
The type for a managed image distribution.

To use this variant, set the property `type` to `ManagedImage`.

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`imageName`](#parameter-distributionstype-managedimageimagename) | string | Name of the managed or unmanaged image that will be created. |
| [`type`](#parameter-distributionstype-managedimagetype) | string | The type of distribution. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`artifactTags`](#parameter-distributionstype-managedimageartifacttags) | object | Tags that will be applied to the artifact once it has been created/updated by the distributor. If not provided will set tags based on the provided image source. |
| [`imageResourceId`](#parameter-distributionstype-managedimageimageresourceid) | string | The resource ID of the managed image. Defaults to a compute image with name 'imageName-baseTime' in the current resource group. |
| [`location`](#parameter-distributionstype-managedimagelocation) | string | Azure location for the image, should match if image already exists. Defaults to the value of the 'location' parameter. |
| [`runOutputName`](#parameter-distributionstype-managedimagerunoutputname) | string | The name to be used for the associated RunOutput. If not provided, a name will be calculated. |

### Parameter: `distributions.type-ManagedImage.imageName`

Name of the managed or unmanaged image that will be created.

- Required: Yes
- Type: string

### Parameter: `distributions.type-ManagedImage.type`

The type of distribution.

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'ManagedImage'
  ]
  ```

### Parameter: `distributions.type-ManagedImage.artifactTags`

Tags that will be applied to the artifact once it has been created/updated by the distributor. If not provided will set tags based on the provided image source.

- Required: No
- Type: object

### Parameter: `distributions.type-ManagedImage.imageResourceId`

The resource ID of the managed image. Defaults to a compute image with name 'imageName-baseTime' in the current resource group.

- Required: No
- Type: string

### Parameter: `distributions.type-ManagedImage.location`

Azure location for the image, should match if image already exists. Defaults to the value of the 'location' parameter.

- Required: No
- Type: string

### Parameter: `distributions.type-ManagedImage.runOutputName`

The name to be used for the associated RunOutput. If not provided, a name will be calculated.

- Required: No
- Type: string

### Variant: `distributions.type-VHD`
The type for an unmanaged distribution.

To use this variant, set the property `type` to `VHD`.

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`imageName`](#parameter-distributionstype-vhdimagename) | string | Name of the managed or unmanaged image that will be created. |
| [`type`](#parameter-distributionstype-vhdtype) | string | The type of distribution. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`artifactTags`](#parameter-distributionstype-vhdartifacttags) | object | Tags that will be applied to the artifact once it has been created/updated by the distributor. If not provided will set tags based on the provided image source. |
| [`runOutputName`](#parameter-distributionstype-vhdrunoutputname) | string | The name to be used for the associated RunOutput. If not provided, a name will be calculated. |

### Parameter: `distributions.type-VHD.imageName`

Name of the managed or unmanaged image that will be created.

- Required: Yes
- Type: string

### Parameter: `distributions.type-VHD.type`

The type of distribution.

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'VHD'
  ]
  ```

### Parameter: `distributions.type-VHD.artifactTags`

Tags that will be applied to the artifact once it has been created/updated by the distributor. If not provided will set tags based on the provided image source.

- Required: No
- Type: object

### Parameter: `distributions.type-VHD.runOutputName`

The name to be used for the associated RunOutput. If not provided, a name will be calculated.

- Required: No
- Type: string

### Parameter: `imageSource`

Image source definition in object format.

- Required: Yes
- Type: object

### Parameter: `managedIdentities`

The managed identity definition for this resource.

- Required: Yes
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`userAssignedResourceIds`](#parameter-managedidentitiesuserassignedresourceids) | array | The resource ID(s) to assign to the resource. Required if a user assigned identity is used for encryption. |

### Parameter: `managedIdentities.userAssignedResourceIds`

The resource ID(s) to assign to the resource. Required if a user assigned identity is used for encryption.

- Required: No
- Type: array

### Parameter: `name`

The name prefix of the Image Template to be built by the Azure Image Builder service.

- Required: Yes
- Type: string

### Parameter: `autoRunState`

Indicates whether or not to automatically run the image template build on template creation or update.

- Required: No
- Type: string
- Default: `'Disabled'`
- Allowed:
  ```Bicep
  [
    'Disabled'
    'Enabled'
  ]
  ```

### Parameter: `buildTimeoutInMinutes`

The image build timeout in minutes. 0 means the default 240 minutes.

- Required: No
- Type: int
- Default: `0`
- MinValue: 0
- MaxValue: 960

### Parameter: `customizationSteps`

Customization steps to be run when building the VM image.

- Required: No
- Type: array

### Parameter: `enableTelemetry`

Enable/Disable usage telemetry for module.

- Required: No
- Type: bool
- Default: `True`

### Parameter: `errorHandlingOnCustomizerError`

If there is a customizer error and this field is set to 'cleanup', the build VM and associated network resources will be cleaned up. This is the default behavior. If there is a customizer error and this field is set to 'abort', the build VM will be preserved.

- Required: No
- Type: string
- Default: `'cleanup'`
- Allowed:
  ```Bicep
  [
    'abort'
    'cleanup'
  ]
  ```

### Parameter: `errorHandlingOnValidationError`

If there is a validation error and this field is set to 'cleanup', the build VM and associated network resources will be cleaned up. If there is a validation error and this field is set to 'abort', the build VM will be preserved. This is the default behavior.

- Required: No
- Type: string
- Default: `'cleanup'`
- Allowed:
  ```Bicep
  [
    'abort'
    'cleanup'
  ]
  ```

### Parameter: `location`

Location for all resources.

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

### Parameter: `managedResourceTags`

Tags that will be applied to the resource group and/or resources created by the service.

- Required: No
- Type: object

### Parameter: `optimizeVmBoot`

The optimize property can be enabled while creating a VM image and allows VM optimization to improve image creation time.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'Disabled'
    'Enabled'
  ]
  ```

### Parameter: `osDiskSizeGB`

Specifies the size of OS disk.

- Required: No
- Type: int
- Default: `128`

### Parameter: `roleAssignments`

Array of role assignments to create.

- Required: No
- Type: array
- Roles configurable by name:
  - `'Contributor'`
  - `'Owner'`
  - `'Reader'`
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

### Parameter: `stagingResourceGroupResourceId`

Resource ID of the staging resource group in the same subscription and location as the image template that will be used to build the image.</p>If this field is empty, a resource group with a random name will be created.</p>If the resource group specified in this field doesn't exist, it will be created with the same name.</p>If the resource group specified exists, it must be empty and in the same region as the image template.</p>The resource group created will be deleted during template deletion if this field is empty or the resource group specified doesn't exist,</p>but if the resource group specified exists the resources created in the resource group will be deleted during template deletion and the resource group itself will remain.

- Required: No
- Type: string

### Parameter: `tags`

Tags of the resource.

- Required: No
- Type: object

### Parameter: `validationProcess`

Configuration options and list of validations to be performed on the resulting image.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`continueDistributeOnFailure`](#parameter-validationprocesscontinuedistributeonfailure) | bool | If validation fails and this field is set to false, output image(s) will not be distributed. This is the default behavior. If validation fails and this field is set to true, output image(s) will still be distributed. Please use this option with caution as it may result in bad images being distributed for use. In either case (true or false), the end to end image run will be reported as having failed in case of a validation failure. [Note: This field has no effect if validation succeeds.]. |
| [`inVMValidations`](#parameter-validationprocessinvmvalidations) | array | A list of validators that will be performed on the image. Azure Image Builder supports File, PowerShell and Shell validators. |
| [`sourceValidationOnly`](#parameter-validationprocesssourcevalidationonly) | bool | If this field is set to true, the image specified in the 'source' section will directly be validated. No separate build will be run to generate and then validate a customized image. Not supported when performing customizations, validations or distributions on the image. |

### Parameter: `validationProcess.continueDistributeOnFailure`

If validation fails and this field is set to false, output image(s) will not be distributed. This is the default behavior. If validation fails and this field is set to true, output image(s) will still be distributed. Please use this option with caution as it may result in bad images being distributed for use. In either case (true or false), the end to end image run will be reported as having failed in case of a validation failure. [Note: This field has no effect if validation succeeds.].

- Required: No
- Type: bool

### Parameter: `validationProcess.inVMValidations`

A list of validators that will be performed on the image. Azure Image Builder supports File, PowerShell and Shell validators.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`type`](#parameter-validationprocessinvmvalidationstype) | string | The type of validation. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`destination`](#parameter-validationprocessinvmvalidationsdestination) | string | Destination of the file. |
| [`inline`](#parameter-validationprocessinvmvalidationsinline) | array | Array of commands to be run, separated by commas. |
| [`name`](#parameter-validationprocessinvmvalidationsname) | string | Friendly Name to provide context on what this validation step does. |
| [`runAsSystem`](#parameter-validationprocessinvmvalidationsrunassystem) | bool | If specified, the PowerShell script will be run with elevated privileges using the Local System user. Can only be true when the runElevated field above is set to true. |
| [`runElevated`](#parameter-validationprocessinvmvalidationsrunelevated) | bool | If specified, the PowerShell script will be run with elevated privileges. |
| [`scriptUri`](#parameter-validationprocessinvmvalidationsscripturi) | string | URI of the PowerShell script to be run for validation. It can be a github link, Azure Storage URI, etc. |
| [`sha256Checksum`](#parameter-validationprocessinvmvalidationssha256checksum) | string | Value of sha256 checksum of the file, you generate this locally, and then Image Builder will checksum and validate. |
| [`sourceUri`](#parameter-validationprocessinvmvalidationssourceuri) | string | The source URI of the file. |
| [`validExitCodes`](#parameter-validationprocessinvmvalidationsvalidexitcodes) | array | Valid codes that can be returned from the script/inline command, this avoids reported failure of the script/inline command. |

### Parameter: `validationProcess.inVMValidations.type`

The type of validation.

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'File'
    'PowerShell'
    'Shell'
  ]
  ```

### Parameter: `validationProcess.inVMValidations.destination`

Destination of the file.

- Required: No
- Type: string

### Parameter: `validationProcess.inVMValidations.inline`

Array of commands to be run, separated by commas.

- Required: No
- Type: array

### Parameter: `validationProcess.inVMValidations.name`

Friendly Name to provide context on what this validation step does.

- Required: No
- Type: string

### Parameter: `validationProcess.inVMValidations.runAsSystem`

If specified, the PowerShell script will be run with elevated privileges using the Local System user. Can only be true when the runElevated field above is set to true.

- Required: No
- Type: bool

### Parameter: `validationProcess.inVMValidations.runElevated`

If specified, the PowerShell script will be run with elevated privileges.

- Required: No
- Type: bool

### Parameter: `validationProcess.inVMValidations.scriptUri`

URI of the PowerShell script to be run for validation. It can be a github link, Azure Storage URI, etc.

- Required: No
- Type: string

### Parameter: `validationProcess.inVMValidations.sha256Checksum`

Value of sha256 checksum of the file, you generate this locally, and then Image Builder will checksum and validate.

- Required: No
- Type: string

### Parameter: `validationProcess.inVMValidations.sourceUri`

The source URI of the file.

- Required: No
- Type: string

### Parameter: `validationProcess.inVMValidations.validExitCodes`

Valid codes that can be returned from the script/inline command, this avoids reported failure of the script/inline command.

- Required: No
- Type: array

### Parameter: `validationProcess.sourceValidationOnly`

If this field is set to true, the image specified in the 'source' section will directly be validated. No separate build will be run to generate and then validate a customized image. Not supported when performing customizations, validations or distributions on the image.

- Required: No
- Type: bool

### Parameter: `vmSize`

Specifies the size for the VM.

- Required: No
- Type: string
- Default: `'Standard_D2s_v3'`

### Parameter: `vmUserAssignedIdentities`

List of User-Assigned Identities associated to the Build VM for accessing Azure resources such as Key Vaults from your customizer scripts. Be aware, the user assigned identities specified in the 'managedIdentities' parameter must have the 'Managed Identity Operator' role assignment on all the user assigned identities specified in this parameter for Azure Image Builder to be able to associate them to the build VM.

- Required: No
- Type: array
- Default: `[]`

### Parameter: `vnetConfig`

Optional configuration of the virtual network to use to deploy the build VM and validation VM in. Omit if no specific virtual network needs to be used.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`containerInstanceSubnetResourceId`](#parameter-vnetconfigcontainerinstancesubnetresourceid) | string | Resource id of a pre-existing subnet on which Azure Container Instance will be deployed for Isolated Builds. This field may be specified only if subnetResourceId is also specified and must be on the same Virtual Network as the subnet specified in subnetResourceId. |
| [`proxyVmSize`](#parameter-vnetconfigproxyvmsize) | string | Size of the proxy virtual machine used to pass traffic to the build VM and validation VM. This must not be specified if containerInstanceSubnetResourceId is specified because no proxy virtual machine is deployed in that case. Omit or specify empty string to use the default (Standard_A1_v2). |
| [`subnetResourceId`](#parameter-vnetconfigsubnetresourceid) | string | Resource id of a pre-existing subnet on which the build VM and validation VM will be deployed. |

### Parameter: `vnetConfig.containerInstanceSubnetResourceId`

Resource id of a pre-existing subnet on which Azure Container Instance will be deployed for Isolated Builds. This field may be specified only if subnetResourceId is also specified and must be on the same Virtual Network as the subnet specified in subnetResourceId.

- Required: No
- Type: string

### Parameter: `vnetConfig.proxyVmSize`

Size of the proxy virtual machine used to pass traffic to the build VM and validation VM. This must not be specified if containerInstanceSubnetResourceId is specified because no proxy virtual machine is deployed in that case. Omit or specify empty string to use the default (Standard_A1_v2).

- Required: No
- Type: string

### Parameter: `vnetConfig.subnetResourceId`

Resource id of a pre-existing subnet on which the build VM and validation VM will be deployed.

- Required: No
- Type: string

### Parameter: `baseTime`

Do not provide a value! This date is used to generate a unique image template name.

- Required: No
- Type: string
- Default: `[utcNow('yyyy-MM-dd-HH-mm-ss')]`

## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `location` | string | The location the resource was deployed into. |
| `name` | string | The full name of the deployed image template. |
| `namePrefix` | string | The prefix of the image template name provided as input. |
| `resourceGroupName` | string | The resource group the image template was deployed into. |
| `resourceId` | string | The resource ID of the image template. |
| `runThisCommand` | string | The command to run in order to trigger the image build. |

## Cross-referenced modules

This section gives you an overview of all local-referenced module files (i.e., other modules that are referenced in this module) and all remote-referenced files (i.e., Bicep modules that are referenced from a Bicep Registry or Template Specs).

| Reference | Type |
| :-- | :-- |
| `br/public:avm/utl/types/avm-common-types:0.5.1` | Remote reference |

## Notes

### Parameter Usage: `imageSource`

Tag names and tag values can be provided as needed. A tag can be left without a value.

#### Platform Image

<details>

<summary>Parameter JSON format</summary>

```json
"source": {
    "type": "PlatformImage",
    "publisher": "MicrosoftWindowsDesktop",
    "offer": "Windows-10",
    "sku": "19h2-evd",
    "version": "latest"
}
```

</details>

<details>

<summary>Bicep format</summary>

```bicep
source: {
    type: 'PlatformImage'
    publisher: 'MicrosoftWindowsDesktop'
    offer: 'Windows-10'
    sku: '19h2-evd'
    version: 'latest'
}
```

</details>
<p>

#### Managed Image

<details>

<summary>Parameter JSON format</summary>

```json
"source": {
    "type": "ManagedImage",
    "imageId": "/subscriptions/<subscriptionId>/resourceGroups/{destinationResourceGroupName}/providers/Microsoft.Compute/images/<imageName>"
}
```

</details>

<details>

<summary>Bicep format</summary>

```bicep
source: {
    type: 'ManagedImage'
    imageId: '/subscriptions/<subscriptionId>/resourceGroups/{destinationResourceGroupName}/providers/Microsoft.Compute/images/<imageName>'
}
```

</details>
<p>

#### Shared Image

<details>

<summary>Parameter JSON format</summary>

```json
"source": {
    "type": "SharedImageVersion",
    "imageVersionID": "/subscriptions/<subscriptionId>/resourceGroups/<resourceGroup>/providers/Microsoft.Compute/galleries/<sharedImageGalleryName>/images/<imageDefinitionName/versions/<imageVersion>"
}
```

</details>

<details>

<summary>Bicep format</summary>

```bicep
source: {
    type: 'SharedImageVersion'
    imageVersionID: '/subscriptions/<subscriptionId>/resourceGroups/<resourceGroup>/providers/Microsoft.Compute/galleries/<sharedImageGalleryName>/images/<imageDefinitionName/versions/<imageVersion>'
}
```

</details>
<p>

## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the [repository](https://aka.ms/avm/telemetry). There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
