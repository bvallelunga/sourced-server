module.exports = (Parse)->
	Parse.Cloud.beforeSave Parse.Job, (req, res)->
		object = req.object
		
		if object.dirty "pending" or object.dirty "expired"
			pending = !!object.get "pending"
			expired = !!object.get "expired"
			
			object.set "pending", pending
			object.set "expired", expired
			object.set "show", (!pending and !expired)
		
		res.success()