# Global Variables
GLOBAL.Async   = require "async"
GLOBAL.Promise = require "bluebird"
GLOBAL.Config  = require "../config"
GLOBAL.Lib     = require "../lib"
GLOBAL.Parse	 = Lib.parse()

Lib.scrapers.scrapers().mapSeries (scraper)->
	return scraper[1]()

.catch (error)->
	throw error