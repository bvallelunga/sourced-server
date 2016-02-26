module.exports = (req, res, next)->
	# Random Number
	if not Config.general.production or not Config.random
		Config.random = Math.floor (Math.random() * 1000000) + 1
	
	# Header Config
	res.header 'Server', Config.general.company
	res.header 'Access-Control-Allow-Credentials', true
	res.header 'Access-Control-Allow-Origin', req.hostname
	res.header 'Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE'
	res.header 'Access-Control-Allow-Headers', 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Accept'
	
	#Locals
	res.locals.csrf = if req.csrfToken then req.csrfToken() else ""
	res.locals.production = Config.general.production
	res.locals.host = req.hostname
	res.locals.title = ""
	res.locals.site_title = Config.general.company
	res.locals.site_delimeter = Config.general.delimeter
	res.locals.description = Config.general.description.join ""
	res.locals.company = Config.general.company
	res.locals.logo = Config.general.logo
	res.locals.config = {}
	res.locals.icons = Config.icons
	res.locals.user = req.session.user
	res.locals.title_first = true
	res.locals.random = "?rand=" + Config.random
	res.locals.search = ""
	res.locals.logos =
		"logo" : "/img/logo.png"
		"graph": "/favicon/196.png"
		"1000" : "/favicon/1000.png"
		"500"  : "/favicon/500.png"
		"196"  : "/favicon/196.png"
		"160"  : "/favicon/160.png"
		"114"  : "/favicon/114.png"
		"72"   : "/favicon/72.png"
		"57"   : "/favicon/57.png"
		"32"   : "/favicon/32.png"

	# Redirect
	if "www" not in req.subdomains
		next()
	else
		res.redirect "#{Config.general.host}#{req.path}"
	
	# Success
	res.success = (data)->
    data = data || {}
    data.success = true
    res.json(data)

  #Error Shorcut
  res.error = (error)->
    if typeof error != "string"
     	error = error.description or error.message or "An error occurred"

    console.error error 

    res.json
      success: false,
      message: error