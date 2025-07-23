const Sequelize = require('sequelize');
  config = require('./config');

const sequelize = new Sequelize(config.postgresDbName, config.postgresUsername, config.postgresPassword, {
  host: config.postgresHost,
  dialect: 'postgres',
  logging: false // Disable logging to prevent sensitive data exposure
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
