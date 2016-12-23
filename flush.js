
const mongoose = require('mongoose'),
  redis = require('redis');

client = redis.createClient();

client.flushall(function (err, succeeded) {
  console.log(succeeded); // will be true if successfull

  mongoose.connect(process.env.MOSAIC_MONGO_URL || 'mongodb://localhost/mosaic',function(){
    /* Drop the DB */
    mongoose.connection.db.dropDatabase(function(err){
      process.exit();
    });
  });
});
