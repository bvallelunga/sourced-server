module.exports = ->
	Array::first = ->
		this[0]
	
	Array::last = ->
		this[this.length - 1]
	
	Array::empty = ->
		this.length is 0
	
	
	Array::random = ->
		this[Math.floor(Math.random() * this.length)]
		
	String::link = ->
		str = str.replace "http://", ""
		str = str.replace "https://", ""
		
		unless shorten
		 return str
		
		"#{str.slice 0, shorten}#{if str.length >= shorten then '...' else ''}"
	
	String::capitalize = ->
		this.replace /(?:^|\s)\S/g, (a) -> a.toUpperCase()
	
	String::classify = ->
		classified = []
		words = this.split('_')
		for word in words
			classified.push word.capitalize()
		
		classified.join('')
