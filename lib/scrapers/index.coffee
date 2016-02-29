fs = require "fs"

module.exports = (cb)->
	scrapers = {}

	Async.each fs.readdirSync(__dirname), (file, next)->		
		if file != "index.coffee"
			scrapers[file.replace ".coffee", ""] = require "#{__dirname}/#{file}"
		
		next()
	, -> cb scrapers
