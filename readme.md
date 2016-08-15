# Seedbot

This is a simple frontend with a backend to sort torrents. Once set up correctly, the torrent client will POST `127.0.0.1:PORT/torrent` to add ever completed torrent to a list where the user can remotely decide where they go.

## Technologies
This is a template that can be used to create nodejs applications using

* Node v4.2.x
* Express v4.13.x
* CoffeeScript v1.10.x
* Jade v1.11.0
* Stylus v0.52.x
* Connect Assets v2.5.x
* MongoDB / Mongoose 3.8.x

## Requirements

* [NodeJs](http://nodejs.org)
* [Express](http://expressjs.com)
* [CoffeeScript](http://coffeescript.org)
* [Jade](http://jade-lang.com/)
* [Stylus](http://learnboost.github.io/stylus/)
* [connect-assets](http://github.com/TrevorBurnham/connect-assets)

These will install with npm, just do

```
npm install
```

In your project directory.

---

## Installation

To install you will need root access to your machine.

### Setup file permissions

Your downloaded files must be owned by rtorrent - which should be the case.
You target path where you want to symlink to must have 775 permissions and the owner group must contains rtorrent user.

### Install mongo

Install latest mongodb


### Install node and global deps

Run those commands as `rtorrent` (`su rtorrent`)

```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.4/install.sh | bash
source ~/.bashrc
nvm install v6.3.1
node -v # should output 6.3.1
npm i -g cake coffee-script forever
cd ~/
git clone https://github.com/vinz243/seedbot.git
cd seedbot
npm install
cake build
```

# Run

```
forever start server.js
```

### Setup apache

You should not be able to connect to your node server from a remote computer. 
Authentification isn't implemented, it is safer you use apache to proxy using a basic auth:

```apache
Listen 8443
<VirtualHost *:8443>
        ProxyPass / http://127.0.0.1:3000/
        ProxyPassReverse / http://127.0.0.1:3000/
        ProxyPreserveHost On

        SSLEngine on
        SSLCertificateFile /usr/local/apache/conf/ssl.crt
        SSLCertificateKeyFile /usr/local/apache/conf/ssl.key
        CustomLog /var/log/apache2/ssl_request_log \
                "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\" %b"
        <Location />
                AuthType Basic
                AuthName "Authentification required"
                AuthUserFile "/usr/local/apache/conf/seedbot"
                Require valid-user

                Order allow,deny
                Allow from all
        </Location>
</VirtualHost>
```

# About
## License

See LICENSE

## Contribute

pull requests are welcome
