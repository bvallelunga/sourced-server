request = require 'request'
cheerio = require 'cheerio'

# Scraper
class Scraper 
	source: ""
	source_display: ""
	
	url: (id)->
		return ""
	
	start: ->
		@companies().then (companies)=>
			Promise.mapSeries companies, (company)=>							
				@fetchJobs(company).then =>
					@updateCompany company
					
	fetchJobs: (company)->					
		company_url = @url company.get "sourceId"

		@loadUrl(company_url).then (body)=>
			$company = cheerio.load body
			
			@scrapeJobs(company_url, company.get("departments"), $company)

		.then (job_urls)=>
			@expireJobs(company, job_urls).then ->
				return job_urls
				
		.each (job_url)=>
			@loadUrl(job_url).then (body)=>		
				$job = cheerio.load body
				@scrapeJob(job_url, $job)
				
			.then (data)=>
				@createJob(company, data)
		
	scrapeJobs: (url, $)->
		return []
				
	scrapeJob: (url, $)->
		return {
			description_html: ""
			description: ""
			name: ""
			city: ""
			commitment: ""
			source_url: "" 
			source_categories: []
		}
		
	updateCompany: (company)->
		company.set "scrapedAt", new Date()
		company.save()
		
	createJob: (company, data)->	
		query = new Parse.Query Parse.Job
		query.equalTo "sourceUrl", data.source_url
		
		query.first().then (job)=>
			if job 
				if job.get "expired"
					job.set "expired", false
					return job.save()
				return
				
			job = new Parse.Job()

			job.set "sourceUrl", data.source_url
			job.set "sourceCategories", data.source_categories
			job.set "company", company
			job.set "name", data.name
			job.set "descriptionHtml", data.description_html
			job.set "description", data.description
			job.set "city", data.city
			job.set "commitment", data.commitment
			job.set "team", data.team
			job.set "pending", true
			job.set "expired", false
			job.set "show", false
			
			job.save().then =>
				console.log "#{company.get "name"}, #{data.name}, #{@source_display}: CREATED"
	
	expireJobs: (company, job_urls)->	
		query = new Parse.Query Parse.Job
		
		query.equalTo "expired", false
		query.equalTo "company", company
		query.notContainedIn "sourceUrl", job_urls
		
		query.each (job)=>		
			job.set "expired", true
			job.save().then =>
				console.log "#{company.get "name"}, #{job.get "name"}, #{@source_display}: EXPIRED"
		
	companies: ->
		query = new Parse.Query Parse.Company
		
		query.equalTo "scrape", true
		query.equalTo "source", @source
		
		query.find()
		
	loadUrl: (url)->	
		return new Promise (resolve, reject)->
			request url, (error, response, body)->
				if !error and response.statusCode == 200
			    resolve body
			  else
			  	reject error

# Exports
module.exports.Scraper = Scraper
module.exports.scrapers = ->
	fs = Promise.promisifyAll require "fs"

	return fs.readdirAsync(__dirname).filter (file) ->
		file != "index.coffee"
	.map (file)->			
		[file.replace(".coffee", ""), require("#{__dirname}/#{file}")]
