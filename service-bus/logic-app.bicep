param location string = resourceGroup().location
param laDefinition object

resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: 'derek-logic-app'
  location: location
  properties: {
    definition: laDefinition.definition
    parameters: laDefinition.parameters
  }
}
