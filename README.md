# Mosaic Films - recommendationRaccoon Demo App

Mosaic Films is a demo of the recommendationRaccoon engine. It is a full installation of the module that takes advantage of lightning fast recommendations powered by Redis and a simple user interface. It comes complete with sample content and tests.

## Dependencies

* Async
* CSV
* Express
* MongoDB
* Mongoose
* Node
* Raccoon - crucial
* Redis - crucial
* Underscore

## recommendationRaccoon Engine Repo

* <a href="https://github.com/guymorita/recommendationRaccoon" target="_blank">https://github.com/guymorita/recommendationRaccoon</a>

## How to install locally

#### Clone the repo
``` bash
git clone https://github.com/guymorita/Mosaic-Films---Recommendation-Engine-Demo.git
```

#### Install ALL dependencies
``` bash
npm install async csv express mongodb mongoose raccoon redis underscore
```

#### Make sure Raccoon's sampleContent is true
```` js
/node_modules/raccoon/config.js
  // make sure - sampleContent: true
```

#### Boot up server
``` bash
node node-server.js
```

#### Import Movies
* Go to http://localhost:3000/importMovies
* If you're on a different local host, change it out

#### It's ready! Try the home page
* http://localhost:3000/
