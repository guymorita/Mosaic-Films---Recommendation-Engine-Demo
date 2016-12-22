module.exports = exports = (function(){  

  var async = require('async'),
  mongoose = require('mongoose'),
  _ = require('underscore'),
  csv = require('csv'),
  raccoon = require('raccoon');

  var headers;

  mongoose.connect(process.env.MOSAIC_MONGO_URL || 'mongodb://localhost/mosaic');

  var userSchema = mongoose.Schema({
    name: String
  });
  var User = mongoose.model('User', userSchema);

  var movieSchema = mongoose.Schema({
    name: String
  });
  var Movie = mongoose.model('Movie', movieSchema);

  module.exports = {
    User: User,
    Movie: Movie
  };

  var insertMovie = function(movieName){
    var movieData = {
      name: movieName
    };
    var movie = new Movie(movieData);
    movie.save();
  };

  var insertRow = function(row, headers){
    var userData = {
      name: row[0]
    };
    var user = new User(userData);
    user.save(function(){
      for (var j = 1; j < row.length; j++){
        if (row[j] > 0){
          insertUserMovieLists(row[0], headers[j], row[j]);
        }
      }
    });
  };

  var insertUserMovieLists = function(userName, movieName, rating){
    User.findOne({name:userName}, function(err, userData){
      Movie.findOne({name:movieName}, function(err, movieData){
        if (rating > 3){
          raccoon.liked(userData._id, movieData._id, function(){});
        } else if (rating < 3) {
          raccoon.disliked(userData._id, movieData._id, function(){});
        } else {
          if (function(){return Math.floor(Math.random()*1.5)}===1){
            raccoon.liked(userData._id, movieData._id, function(){});
          } else {
            raccoon.disliked(userData._id, movieData._id, function(){});
          }
        }
        // input.userList(userData._id);
        // input.itemList(movieData._id);
      });
    });
  };

  var buildLoginObject = function(userName, callback){
    var loginObject = {};
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

  var findOrCreateUser = function(username, callback){
    User.findOne({name:username}, function(err, userData){
      if (userData === null){
        var newUser = {
          name: username
        };
        var user = new User(newUser);
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
    buildLoginObject: buildLoginObject,
    importCSV:function(callback){
      csv()
      .from.path(__dirname+'/movierecs.csv', { delimiter: ',', escape: '"' })
      .on('record', function(row,index){
        if (index === 0){
          for (var i = 1; i < row.length; i++){
            insertMovie(row[i]);
            headers = row;
          }
        } else {
          insertRow(row, headers);
        }
      })
      .on('end', function(){
      })
      .on('error', function(error){
        console.log(error.message);
      });
    }
  };
}).call(this);