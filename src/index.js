const vanillaConfigResolver = require("./vanilla")

;(async function() {
  try {
    console.log("Vanilla config example...")
    const config1 = await vanillaConfigResolver()
    console.dir(config1, { depth: 5, colors: true })
  } catch (err) {
    console.log(err)
    process.exit(1)
  }
})()
