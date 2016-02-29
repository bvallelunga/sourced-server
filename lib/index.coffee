module.exports =
	core     : require './core'
	parse	   : require './parse'
	redis    : require './redis'
	scrapers    : require './scrapers'
	init     : ->
		@core.helpers()
