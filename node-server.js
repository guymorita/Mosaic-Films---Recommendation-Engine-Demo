// config
urlOfDB = 'mongodb://localhost/users';
// url of csv file


var express = require('express'),
    raccoon = require('raccoon').raccoon(urlOfDB),
    path = require('path'),
    app = express();

app.use(express.static(path.join(__dirname, 'public')));

app.get('/login', function(req, res){
  raccoon.models.buildLoginObject(req.query[':username'], function(object){
    res.send(object);
  });
});

app.get('/importMovies', function(req, res){
  raccoon.models.importCSV(raccoon.models.importLib);
  res.send('SUCCESS: Movies Imported');
});

app.get('/recommend', function(req, res){
  console.log('query', req.query[':id']);
  // console.log(req.path);
  // console.log('req query', req.query[':name']);
  // console.log(raccoon.models.useee, req.query[':id']);
  raccoon.stat.likedCount(req.query[':id'], function(rec){
    console.log('rec', rec);
    res.send(rec);
  });
});

app.get('/topSimilarUsers', function(req, res){
  raccoon.topSimilarUsers(raccoon.models.useee, req.query[':name'], function(rec){
    res.send(rec);
  });
});

app.get('/getMovieList', function(req, res){
  res.send(raccoon.models.movee);
});

app.post('/newUser', function(req, res){
  var chunk = '';
  req.on('data', function(data){
    chunk += data;
  });
  req.on('end', function(){
    chunk = JSON.parse(chunk);
    raccoon.models.buildMovieList(chunk, function(movieList){
      raccoon.models.newUser(chunk.name, movieList, function(){
        raccoon.models.importLib(function(){
          res.send(204);
        });
      });
    });
  });
  // console.log(res);
});

app.listen(3000);
