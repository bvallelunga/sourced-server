module.exports.notfound = (req, res, next)->
	res.status(404).send 'Sorry cant find that!'
	
module.exports.error = (error, req, res, next)->
	console.error err.stack
	res.status(500).send 'Something broke!'