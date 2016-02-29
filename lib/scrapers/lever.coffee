Scraper = require("./").Scraper

class LeverScraper extends Scraper
	source: "lever"
	
	scrapeJobs: ($)->
		new Promise()
		
	scrapeJob: ($)->
		new Promise()
		
	scrapeCompany: ($)->
		new Promise()

module.exports = (cb)->
	return new LeverScraper().start()