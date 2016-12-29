# Mosaic Films - recommendationRaccoon Demo App

Mosaic Films is a demo of the recommendationRaccoon engine built on top of Node.js. It is a full installation of the module that takes advantage of lightning fast recommendations powered by Redis and a simple user interface. It comes complete with sample content and tests.

Get up and running in less than 5 minutes!

Video Demo of Mosaic:
![Video Walkthrough of Mosaic](mosaic.gif)

## Dependencies

* Async
* CSV
* Express
* Postgres
* Sequelize
* Node
* Raccoon
* Redis
* Underscore

## recommendationRaccoon Engine Repo

* <a href="https://github.com/guymorita/recommendationRaccoon" target="_blank">https://github.com/guymorita/recommendationRaccoon</a>

## How to install locally

#### 1. Clone the repo
``` bash
git clone https://github.com/guymorita/Mosaic-Films---Recommendation-Engine-Demo.git
```

#### 2. Install dependencies
Navigate to folder
``` bash
cd Mosaic-Films---Recommendation-Engine-Demo
```
``` bash
npm install
```

#### 2a. Install a Redis (configure if necessary in lib/config.js)
``` bash
brew install redis
```

#### 2b. Install Postgres (configure if necessary in lib/config.js)
``` bash
brew install postgres
```
Start up postgres server
``` bash
postgres -D /usr/local/var/postgres
```
Create a database
``` bash
createdb mosaic
```

#### 4. Import Sample Data
``` bash
node lib/importMovies.js
```

#### 3. Boot up servers in separate terminal windows
``` bash
redis-server
```
``` bash
postgres -D /usr/local/var/postgres
```
``` bash
node node-server.js
```

#### 5. It's ready! Try the home page
* http://localhost:3000/
