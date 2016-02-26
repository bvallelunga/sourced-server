module.exports.restrict = (req, res, next)->
	unless req.session.user
		res.redirect "/login?next=#{encodeURIComponent(req.url)}"
	else
		next()

module.exports.logout = (req, res, next)->
	req.session.destroy()
	res.redirect "/"
