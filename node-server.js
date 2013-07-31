// config
urlOfDB = 'mongodb://localhost/users';
// url of csv file


var express = require('express'),
    raccoon = require('raccoon').raccoon(urlOfDB),
    path = require('path'),
    app = express();

app.use(express.static(path.join(__dirname, 'public')));

app.get('/importMovies', function(req, res){
  raccoon.models.importCSV(raccoon.models.importLib);
  res.send('SUCCESS: Movies Imported');
});

app.get('/recommend', function(req, res){
  raccoon.recommendationForUser(raccoon.models.useee, req.query[':name'], function(rec){
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
      raccoon.models.newUser(chunk.name, movieList);
      res.send(204);
    });
  });
  // console.log(res);
});

app.listen(3000);
