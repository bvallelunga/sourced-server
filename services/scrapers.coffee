# Global Variables
GLOBAL._      = require "lodash"
GLOBAL.Async   = require "async"
GLOBAL.Config  = require "../config"
GLOBAL.Lib     = require "../lib"
GLOBAL.Parse	 = Lib.parse()
GLOBAL.Promise = require "promisable-bluebird"

Lib.scrapers (scrapers)->
	Async.series scrapers, (error, results)->
		if error
			return console.error error
		
		console.log results