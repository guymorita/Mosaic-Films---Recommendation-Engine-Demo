module.exports = exports = (function(){  

  const async = require('async'),
  client = require('./client'),
  _ = require('underscore'),
  csv = require('csv'),
  raccoon = require('raccoon');

  const Movie = client.Movie,
    User = client.User,
    sequelize = client.sequelize;

  const buildLoginObject = function(userName, callback){
    let loginObject = {};

    sequelize.Promise.all([
      User.findOrCreate({where: {name: userName}}),
      User.findAll(),
      Movie.findAll()
    ]).spread(function(userObj, allUsers, allMovies) {
      const user = userObj[0];
      const userId = user.id;
      raccoon.stat.allWatchedFor(userId).then((allWatched) => {
        raccoon.stat.recommendFor(userId, 30).then((recs) => {
          loginObject = {
            userId,
            allUsers,
            allMovies,
            username: userName,
            alreadyWatched: allWatched,
            recommendations: recs
          };
          callback(loginObject);
        });
      });
    });
  };

  return {
    buildLoginObject
  };
}).call(this);