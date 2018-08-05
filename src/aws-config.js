const AWS = require("aws-sdk")
const R = require("ramda")


const ssm = new AWS.SSM({
  region: 'ap-southeast-2'
})

async function getSSMParam(name, decrypt) {
  if (typeof name !== 'string') throw new Error("name must be of type string")
  
  const params = {
    Name: name,
    WithDecryption: decrypt
  }

  try {
    return R.view(R.lensPath(['Parameter', 'Value']), await ssm.getParameter(params).promise())
  } catch (err) {
    console.log(`Error retreiving ${name} from SSM Parameter Store`)
    console.log(err)
    process.exit(1)
  }
}

module.exports = {
  getSSMParam
}
