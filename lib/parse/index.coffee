Parse = require 'parse/node'

module.exports = ->
	Parse.initialize Config.parse.appID, Config.parse.javascript, Config.parse.master

	# Parse Classes
	Parse.Category = Parse.Object.extend "Category"
	Parse.Company = Parse.Object.extend "Company"
	Parse.Job = Parse.Object.extend "Job"
	Parse.Submission = Parse.Object.extend "Submission"
	
	return Parse
