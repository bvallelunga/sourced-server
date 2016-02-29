scraper = require('scraperjs').StaticScraper

# Scraper
class Scraper 
	source: ""
	
	start: ->
		this.companies().then (companies)->
			Promise.mapSeries companies, (company)=>
				this.fetchJobs(company).each (job)=>
					this.updateJob(job)
					
				.then ->
					company.get("name")
					
	fetchJobs: (company)->
		this.loadUrl(company.get("source_url")).then ($)=>
			this.scrapeCompany($)
				.then(this.updateCompany)
				.then ->
					this.scrapeJobs($)
					
		.each (job)=>
			this.loadUrl(job.url)
				.then this.scrapeJob
				.then this.updateJob	
		
	fetchCompany: (company)->
		new Promise()
		
	scrapeJobs: ($)->
		new Promise()
		
	scrapeJob: ($)->
		new Promise()
		
	scrapeCompany: ($)->
		new Promise()
		
	updateJob: (data)->
		new Promise()
		
	updateCompany: (company)->
		new Promise()
		
	companies: ->
		query = new Parse.Query Parse.Company
		query.equalTo this.source
		return query.find()
		
	loadUrl: (url, cb)->
		scraper.create(url).scrape cb
			
		

# Exports
module.exports.Scraper = Scraper
module.exports.scrapers = ->
	fs = Promise.promisifyAll require "fs"

	return fs.readdirAsync(__dirname).filter (file) ->
		file != "index.coffee"
	.map (file)->			
		[file.replace(".coffee", ""), require("#{__dirname}/#{file}")]
