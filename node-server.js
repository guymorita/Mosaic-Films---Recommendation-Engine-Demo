const express = require('express'),
  raccoon = require('raccoon'),
  path = require('path'),
  starter = require('./lib/starter.js'),
  app = express();
const rateLimit = require('express-rate-limit');

app.use(express.static(path.join(__dirname, 'public')));

const loginLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // limit each IP to 100 requests per windowMs
});

app.get('/login', loginLimiter, function(req, res){
  starter.buildLoginObject(req.query[':username'], function(object){
    res.send(object);
  });
});

app.get('/newRating', function(req, res){
  let replyObj = {};

  let raccoonFeeling = req.query.movie.like === 'liked' ? raccoon.liked : raccoon.disliked;

  raccoonFeeling(req.query[':userId'], req.query.movie.id).then(() => {
    raccoon.stat.recommendFor(req.query[':userId'], 15).then((recs) => {
      console.log('recs', recs);
      raccoon.stat.mostSimilarUsers(req.query[':userId']).then((simUsers) => {
        raccoon.stat.bestRatedWithScores(9).then((bestRated) => {
          replyObj = {
            recommendations: recs,
            similarUsers: simUsers,
            bestScores: bestRated
          };
          res.send(replyObj);
        });
      });
    });
  });
});

app.get('/movieLikes', function(req, res){
  let replyObj = {};
  raccoon.stat.likedBy(req.query[':movieId']).then((likes) => {
    raccoon.stat.dislikedBy(req.query[':movieId']).then((dislikes) =>{
      replyObj = {
        likedBy: likes,
        dislikedBy: dislikes
      };
      res.send(replyObj);
    });
  });
});

app.listen(3000, function() {
  console.log('--- Mosaic up and running! ---');
});
