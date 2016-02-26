# Import NPM Modules
$ = require("jquery");
config = require('./config');
forever = require('forever-monitor');

# Configure Forever (Daemon & File Watcher)
child = new (forever.Monitor) "#{__dirname}/server.coffee",
    command: "coffee"
    uid: config.forever.uid
    max: config.forever.max_failures
    silent: config.forever.silent
    spinSleepTime: 10
    watch: if config.general.production then false else config.forever.watch
    watchDirectory: "#{__dirname}/#{config.forever.watch_directory}"
    watchIgnoreDotFiles: config.forever.watch_ignore_dot
    watchIgnorePatterns: $.map config.forever.watch_ignore_patterns, (value)->
        return "#{__dirname}/#{value}"
    env:
        'NODE_ENV': if config.general.production then "production" else "development"
    outFile: "#{__dirname}/#{config.forever.output_log}"
    errFile: "#{__dirname}/#{config.forever.error_log}"
    killTree: true

# Log on Exit
child.on 'exit', ->
	console.log "server.js fully down after " + config.forever.max_failures + " starts."
	console.log "SERVER DOWN."

# Log Exit Code
child.on 'exit:code', (code)->
	console.log "server.js exited with code #{code}"

# Start Forver
child.start()
