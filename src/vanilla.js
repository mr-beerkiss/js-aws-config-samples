const { getSSMParam } = require("./aws-config")

async function resolveConfig() {
  const config = {
    mySSMFooVar: await getSSMParam("MySSMFoo"),
    encryptedSSMVar: await getSSMParam("MySecretSSMBaz", true)
  }

  return config
}

module.exports = resolveConfig
