# Import NPM Modules
express        = require "express"
slashes        = require "connect-slashes"
ejs            = require "ejs"
bodyParser		 = require 'body-parser'
cookieParser	 = require 'cookie-parser'
session 			 = require 'express-session'
csrf 					 = require 'csurf'
app            = express()
srv            = require("http").createServer(app)
RedisStore     = require("connect-redis") session

# Import Local Modules
routes         = require "../routes"
locals         = require "../routes/locals"
assets         = require "../assets"

# Global Variables
GLOBAL.Async   = require "async"
GLOBAL.Promise = require "bluebird"
GLOBAL.Moment  = require "moment"
GLOBAL.Config  = require "../config"
GLOBAL.Lib     = require "../lib"
GLOBAL.Parse	 = Lib.parse()

# Initialize Lib
Lib.init()

# Express Config
app.set "views", "#{__dirname}/../views"
app.set "view engine", "ejs"
app.set "view options", layout: true
app.set "view cache", true
app.set "x-powered-by", false

# Express Settings
app.enable 'trust proxy'
app.use bodyParser.json()
app.use bodyParser.urlencoded extended: true
app.use cookieParser()
app.use csrf cookie: true
app.use session({
	name: Config.cookies.session.key
	secret: Config.cookies.session.secret
	resave: false
	saveUninitialized: true
	store: new RedisStore()
	cookie: 
		secure: true
})

# Piler Assests
assets.init app, srv
app.use assets.express

# Direct Assests
app.use "/favicon", express.static "#{__dirname}/../assets/favicons"
app.use "/fonts", express.static "#{__dirname}/../assets/fonts"
app.use "/img", express.static "#{__dirname}/../assets/images"

# External Addons
app.use slashes true

# Setup Locals
app.use locals

# Setup Routes
app.use routes.route

# Activate Routes
routes.init app

# Start Listening to Port
srv.listen (if Config.general.production then 80 else Config.general.port)
