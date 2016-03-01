Scraper = require("./").Scraper

class LeverScraper extends Scraper
	source: "lever"
	source_display: "Lever"
	
	url: (id)->
		return "https://jobs.lever.co/#{id}"
	
	scrapeJobs: (url, $)->
		return $(".posting-apply a").map ->
			return $(@).attr("href")
		.get()
				
	scrapeJob: (url, $)->
		categories = $(".posting-categories div").map ->
			return $(@).text()
		.get()
			
		description = $(".section-wrapper:not(.accent-section) .section.section").eq(0).text()	
		
		description_html = $(".section-wrapper:not(.accent-section) .section.section").map ->
			return $(@).html()
		.get().join("")
		
		return {
			description_html: description_html
			description: description
			name: $(".posting-headline h2").text()
			city: $(".posting-categories .sort-by-time").text()
			commitment: $(".posting-categories .sort-by-commitment").text()
			source_url: url 
			source_categories: categories
		}
		
module.exports = (cb)->
	return new LeverScraper().start()