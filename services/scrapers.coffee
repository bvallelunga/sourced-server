# Global Variables
GLOBAL._      = require "lodash"
GLOBAL.Async   = require "async"
GLOBAL.Promise = require "bluebird"
GLOBAL.Config  = require "../config"
GLOBAL.Lib     = require "../lib"
GLOBAL.Parse	 = Lib.parse()

Lib.scrapers.scrapers().mapSeries (scraper)->
	return scraper[1]().then (companies)->
		return [scraper[0], companies]
	
.then (scrapers)->
	for scraper in scrapers
		for company in scraper[1]
			console.log "#{company} (#{scraper[0]}): SUCCESS"

.catch (error)->
	throw error