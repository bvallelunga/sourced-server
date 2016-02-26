module.exports = (req, res, next)->	
	res.render "home/index",
		title: false
		js: req.coffee.renderTags "home"
		css: req.less.renderTags "home"
