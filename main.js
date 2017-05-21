var cluster = require('cluster')

if (cluster.isMaster) {
  var cpuCount = require('os').cpus().length
  var environment = process.env['NODE_ENV']
  var debugPort = process.env['DEBUG_PORT']
  var debug = (environment === 'development')
  console.log(environment)
  console.log(debugPort)
  cluster.setupMaster({
    execArgv: process.execArgv.filter(function(s) { return s !== '--inspect' })
  });
  for (var i = 0; i < cpuCount; i++) {
    childDebugPort = debugPort + i
    console.log(childDebugPort)
    if (debug) cluster.settings.execArgv.push('--inspect=' + childDebugPort);
    cluster.fork();
    if (debug) cluster.settings.execArgv.pop();
  }
} else {
  var http = require('http')
  var express = require('express')
  var app = express()
  var faye = require('faye')

  var bayeux = new faye.NodeAdapter({
    mount:    '/faye',
    timeout:  45
  });

  var client = bayeux.getClient()
  client.subscribe('/main', (message) => {
    console.log(message)
  })

  var idx = 1;
  setInterval(function() {
    client.publish('/fromServer', `Hello world! (${idx})`)
    idx++
  }, 3000)

  var server = http.createServer(app)
  bayeux.attach(server)

  app.get('/', function (req, res) {
    res.send('Hello World2!')
    console.log(req)
  })

  app.get('/crash', (req, res) => {
    process.exit(1)
  })

  server.listen(80, function () {
    console.log('Example app listening on port 80!')
  })
}
