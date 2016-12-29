
const Sequelize = require('sequelize');
  config = require('./config');

const sequelize = new Sequelize(config.postgresDbName, config.postgresUsername, config.postgresPassword, {
  host: config.postgresHost,
  dialect: 'postgres'
});

var User = sequelize.define('user', {
  name: Sequelize.STRING
});

var Movie = sequelize.define('movie', {
  name: Sequelize.STRING
});

module.exports = exports = {
  sequelize,
  User,
  Movie
};

