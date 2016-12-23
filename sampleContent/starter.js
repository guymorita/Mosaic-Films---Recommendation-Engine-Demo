module.exports = exports = (function(){  

  const async = require('async'),
  mongoose = require('mongoose'),
  _ = require('underscore'),
  csv = require('csv'),
  raccoon = require('raccoon');

  mongoose.connect(process.env.MOSAIC_MONGO_URL || 'mongodb://localhost/mosaic');

  const userSchema = mongoose.Schema({
    name: String
  });
  const User = mongoose.model('User', userSchema);

  const movieSchema = mongoose.Schema({
    name: String
  });
  const Movie = mongoose.model('Movie', movieSchema);

  const buildLoginObject = function(userName, callback){
    let loginObject = {};
    findOrCreateUser(userName, function(userId){
      User.find({}, function(err, userResults){
        Movie.find({}, function(err, movieResults){
          raccoon.stat.allWatchedFor(userId, function(allWatched){
            raccoon.stat.recommendFor(userId, 30, function(recs){
              loginObject = {
                username: userName,
                userId: userId,
                alreadyWatched: allWatched,
                allUsers: userResults,
                allMovies: movieResults,
                recommendations: recs
              };
              callback(loginObject);
            });
          });
        });
      });
    });
  };

  const findOrCreateUser = function(username, callback){
    User.findOne({name:username}, function(err, userData){
      if (userData === null){
        const newUser = {
          name: username
        };
        const user = new User(newUser);
        user.save(function(){
          User.findOne({name:username}, function(err, newUserData){
            callback(newUserData._id);
          });
        });
      } else {
        callback(userData._id);
      }
    });
  };

  return {
    buildLoginObject
  };
}).call(this);