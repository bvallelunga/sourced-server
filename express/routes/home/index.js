module.exports.index = function(req, res) {	
	res.view("home/index")
}

module.exports.notFound = function(req, res) {	
	res.redirect("/")
}