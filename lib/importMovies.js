
const client = require('./client'),
  redisClient = require('./redisCli'),
  csv = require('csv'),
  raccoon = require('raccoon');
  path = require('path'),
  jsonfile = require('jsonfile');

const file = path.join(__dirname, '../sampleContent/movierecs.json');

const Movie = client.Movie,
  User = client.User,
  sequelize = client.sequelize;

redisClient.flushall();

sequelize.sync({force: true}).then(function(){
  const insertMovie = (movieName) => {
    const movie = Movie.build({
      name: movieName
    });
    movie.save().catch(function(error) {
      if (error) { console.log(error); }
    });
  };

  const insertUserMovieLists = function(user, movieName, rating){
    const userId = user.id;
    Movie.findOne({ where: {name: movieName} }).then((movie) => {
      const movieId = movie.id;
      if (rating > 3){
        raccoon.liked(userId, movieId);
      } else if (rating === '') {
        // do nothing
      } else {
        raccoon.disliked(userId, movieId);
      }        
    }).catch(function(err) {
      console.log('err', err);
    });
  };

  const movieRecs = jsonfile.readFileSync(file);
  const movieNames = movieRecs[0];

  for (let movie in movieNames) {
    if (movie !== 'username') {
      insertMovie(movie);
    }
  }

  for (let i = 0; i < movieRecs.length; i++) {
    const row = movieRecs[i];

    const username = row['username'];

    User.create({name: username}).then(function(user){
      for (let key of Object.keys(row)) {
        if (key === 'username') { continue; }
        const movieName = key;
        const rating = row[key];
        insertUserMovieLists(user, movieName, rating);
      }
    });
  }

  setTimeout(function(){
    process.exit();
  }, 10000);
});


