var express = require('express')
var bodyParser = require('body-parser')
var cookieParser = require('cookie-parser')
var session = require('express-session')
var csrf = require('csurf')
var app = express()
var random = Math.random().toString(36).slice(2)

// Parse Init
Routes = require("./express/routes")
Parse = require('parse/node')
Parse.initialize("w5g15oysZQ2mMuSGpz3nQSiNFN8jrefysGXAOStH", "CHigq2WHrKyWDMENaRigbfCq6MDVy02QYptESvwt", "uRzk2Si2q8iz8EM6OAKcbK7UdLFBm25J1IAs8isM")

// Express Setup
app.set('views', './express/views')
app.set('view engine', 'ejs')
app.enable('trust proxy')
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({
  extended: true
}))
app.use(cookieParser())
app.use(csrf({ cookie: true }))
app.use(session({
  secret: random,
  resave: false,
  saveUninitialized: true,
  cookie: { secure: true }
}))
app.use(function(req, res, next) {	
  // Success Shorcut
  res.success = function(data) {
    data = data || {}
    data.success = true
    res.json(data)
  }

  // Error Shorcut
  res.error = function(error) {
    if(typeof error != "string") {
      error = error.description || error.message || "An error occurred"
    }

    console.error(error)

    res.json({
      success: false,
      message: error
    })
  }

  // Render Shorcut
  res.view = function(template, data) {
    data = data || {}
    data.template = data.template || template
    data.user = data.user || req.user
    res.render(template, data)
  }
  
  if(req.url.indexOf("/images/") === 0 || req.url.indexOf("/css/") === 0) {
    res.setHeader("Cache-Control", "public, max-age=2592000");
    res.setHeader("Expires", new Date(Date.now() + 2592000000).toUTCString());
  }

  // Auth
  res.locals.csrf = req.session._csrf

  // Locals
  res.locals.host = req.session.host || ("http://" + req.host)
  res.locals.url = res.locals.host + req.url
  res.locals.user = req.session.user
  res.locals.random = random
  res.locals.config = {}

  next()
})

// Public
app.use(express.static(__dirname + '/public'))

// Home
app.get("/", Routes.home.index)

// Not Found
app.get("*", Routes.home.notFound)

app.listen(80)
