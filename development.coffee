# Import NPM Modules
config = require './config'
forever = require 'forever-monitor'
services = ["server"]

for service in services
	# Start Child Process
	child = new (forever.Monitor) "#{__dirname}/services/#{services}.coffee",
		command: "coffee"
		uid: config.forever.uid
		max: config.forever.max_failures
		silent: config.forever.silent
		spinSleepTime: 10
		watch: if config.general.production then false else config.forever.watch
		watchDirectory: "#{__dirname}/#{config.forever.watch_directory}"
		watchIgnoreDotFiles: true
		watchIgnorePatterns: config.forever.watch_ignore_patterns.map (value)->
			return "#{__dirname}/#{value}"
		env:
			'NODE_ENV': if config.general.production then "production" else "development"
		outFile: "#{__dirname}/logs/#{service}.out"
		errFile: "#{__dirname}/logs/#{service}.error"
		killTree: true
	
	# Log on Exit
	child.on 'exit', ->
		console.log "#{services}.coffee fully down after " + config.forever.max_failures + " starts."
		console.log "SERVER DOWN."
	
	# Log Exit Code
	child.on 'exit:code', (code)->
		console.log "#{services}.coffee exited with code #{code}"
	
	# Start Forver
	child.start()