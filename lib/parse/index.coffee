Parse = require 'parse/node'
fs    = require "fs"

module.exports = ->
	Parse.initialize Config.parse.appID, Config.parse.javascript, Config.parse.master

	# Parse Classes
	Parse.Category = Parse.Object.extend "Category"
	Parse.Company = Parse.Object.extend "Company"
	Parse.Job = Parse.Object.extend "Job"
	Parse.Submission = Parse.Object.extend "Submission"
	
# 	# Activate Hooks
# 	for directory in fs.readdirSync "#{__dirname}"
# 		for file in fs.readdirSync "#{__dirname}/#{directory}"
# 			require("#{__dirname}/#{directory}/#{file}")(Parse)
	
	return Parse
