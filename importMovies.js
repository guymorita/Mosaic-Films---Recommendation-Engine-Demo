
const mongoose = require('mongoose'),
csv = require('csv'),
raccoon = require('raccoon');

let headers;

mongoose.connect(process.env.MOSAIC_MONGO_URL || 'mongodb://localhost/mosaic');

const userSchema = mongoose.Schema({
  name: String
});
const User = mongoose.model('User', userSchema);

const movieSchema = mongoose.Schema({
  name: String
});
const Movie = mongoose.model('Movie', movieSchema);

module.exports = {
  User: User,
  Movie: Movie
};

const insertMovie = function(movieName){
  const movieData = {
    name: movieName
  };
  const movie = new Movie(movieData);
  movie.save();
};

const insertRow = function(row, headers){
  const userData = {
    name: row[0]
  };
  const user = new User(userData);
  user.save(function(err){
     if (err) { 
      console.log(err);
    }
    for (let j = 1; j < row.length; j++){
      if (row[j] > 0){
        insertUserMovieLists(row[0], headers[j], row[j]);
      }
    }
  });
};

const insertUserMovieLists = function(userName, movieName, rating){
  User.findOne({name:userName}, function(err, userData){
    Movie.findOne({name:movieName}, function(err, movieData){
      if (rating > 3){
        raccoon.liked(userData._id, movieData._id);
      } else if (rating < 3) {
        raccoon.disliked(userData._id, movieData._id);
      } else {
        if (function(){return Math.floor(Math.random()*1.5)}===1){
          raccoon.liked(userData._id, movieData._id);
        } else {
          raccoon.disliked(userData._id, movieData._id);
        }
      }
    });
  });
};

csv()
.from.path(__dirname+'/sampleContent/movierecs.csv', { delimiter: ',', escape: '"' })
.on('record', function(row,index){
  if (index === 0){
    for (let i = 1; i < row.length; i++){
      insertMovie(row[i]);
      headers = row;
    }
  } else {
    insertRow(row, headers);
  }
})
.on('end', function(){
  console.log('--- Imported All Movies ---');
  setTimeout(function(){
    process.exit();
  }, 5000);
})
.on('error', function(error){
  console.log(error.message);
});
