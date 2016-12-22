# Mosaic Films - recommendationRaccoon Demo App

Mosaic Films is a demo of the recommendationRaccoon engine built on top of Node.js. It is a full installation of the module that takes advantage of lightning fast recommendations powered by Redis and a simple user interface. It comes complete with sample content and tests.

## Dependencies

* Async
* CSV
* Express
* MongoDB
* Mongoose
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

#### 2a. Install a Redis (if you haven't already)
``` bash
brew install redis
```

#### 2b. Install Mongo (if you haven't already)
``` bash
brew install mongod
```
Create the data directory
``` bash
sudo mkdir -p /data/db
```
Give yourself permissions for the /data/db folder
``` bash
whoami
// your_username
```
``` bash
sudo chown -R <your_username> 755 /data/db
```

#### 3. Boot up servers in separate terminal windows
``` bash
redis-server
```
``` bash
mongod
```
``` bash
node node-server.js
```

#### 4. Import Movies
* Go to http://localhost:3000/importMovies
* Only do this once. Otherwise you'll need to flush the mongo collection because you will have dupes.

#### 5. It's ready! Try the home page
* http://localhost:3000/
