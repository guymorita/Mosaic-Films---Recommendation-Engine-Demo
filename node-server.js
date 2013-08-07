urlOfDB = 'mongodb://localhost/users';

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

app.get('/newRating', function(req, res){
  var replyObj = {};
  if (req.query.movie.like === 'liked'){
    raccoon.input.liked(req.query[':userId'], req.query.movie.id, function(){
      raccoon.stat.recommendFor(req.query[':userId'], 30, function(recs){
        raccoon.stat.mostSimilarUsers(req.query[':userId'], function(simUsers){
          raccoon.stat.bestRatedWithScores(9, function(bestRated){
            replyObj = {
              recommendations: recs,
              similarUsers: simUsers,
              bestScores: bestRated
            }
            res.send(replyObj);
          });
        });
      });
    });
  } else {
    raccoon.input.disliked(req.query[':userId'], req.query.movie.id, function(){
      raccoon.stat.recommendFor(req.query[':userId'], 30, function(recs){
        raccoon.stat.mostSimilarUsers(req.query[':userId'], function(simUsers){
          raccoon.stat.bestRatedWithScores(9, function(bestRated){
            replyObj = {
              recommendations: recs,
              similarUsers: simUsers,
              bestScores: bestRated
            }
            res.send(replyObj);
          });
        });
      });
    });
  }
});

app.get('/importMovies', function(req, res){
  raccoon.models.importCSV(raccoon.models.importLib);
  res.send('SUCCESS: Movies Imported');
});

app.listen(3000);
