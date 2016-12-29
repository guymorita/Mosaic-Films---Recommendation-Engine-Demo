

class Config {
  constructor(args) {
    this.redisUrl = process.env.RACCOON_REDIS_URL || '127.0.0.1';
    this.redisPort = process.env.RACCOON_REDIS_PORT || 6379;
    this.redisAuth = process.env.RACCOON_REDIS_AUTH || '';
    this.sequelizeHost = process.env.SEQUELIZE_HOST || 'localhost';
  }
}

module.exports = exports = new Config();
