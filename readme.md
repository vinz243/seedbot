# Express Coffee Template 9 (1.9.0)

This is a Node Express CoffeeScript Stack Template

It comes ready to go with connect-assets that give you the option
to use coffee-script and stylus for the client side.

## Technologies
This is a template that can be used to create nodejs applications using

* Node v4.2.x
* Express v4.13.x
* CoffeeScript v1.10.x
* Jade v1.11.0
* Stylus v0.52.x
* bootstrap-stylus 2.3.1 (not a npm module)
* Nib v1.1.x
* Connect Assets v2.5.x
* MongoDB / Mongoose 3.8.x

## Requirements

* [NodeJs](http://nodejs.org)
* [Express](http://expressjs.com)
* [CoffeeScript](http://coffeescript.org)
* [Jade](http://jade-lang.com/)
* [Stylus](http://learnboost.github.io/stylus/)
* [bootstrap-stylus](https://github.com/Acquisio/bootstrap-stylus)
* [Nib](http://visionmedia.github.io/nib/)
* [connect-assets](http://github.com/TrevorBurnham/connect-assets)
* [Mocha](http://visionmedia.github.com/mocha/)
* [Mongoose](https://github.com/LearnBoost/mongoose)

These will install with npm, just do

```
npm install
```

In your project directory.

---

## Install, Build, Run, Test, and Watch

```
# Install nodejs and npm

git clone http://github.com/twilson63/express-coffee.git [project-name]
cd [project-name]
npm install
```

## Install coffee-script, mocha and docco

``` sh
npm install coffee-script -g
npm install mocha -g
npm install docco -g
```

# Run

```
cake dev
```

# Setup on your seedbox

It requires nodejs v6.4.x (ES6 features) I recommend using nvm.

You can use forever to run the script in background

**Warning:** This app does not implement any form of authentification.
It is recommended you proxy through a Nginx/Apache server with htpasswd file.
Don't forget to make a *secure* password.

# About
## License

See LICENSE

## Contribute

pull requests are welcome
