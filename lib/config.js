
class Config {
  constructor(args) {
    this.redisUrl = process.env.RACCOON_REDIS_URL || '127.0.0.1';
    this.redisPort = process.env.RACCOON_REDIS_PORT || 6379;
    this.redisAuth = process.env.RACCOON_REDIS_AUTH || '';
    this.postgresDbName = process.env.POSTGRES_DBNAME || 'mosaic';
    this.postgresHost = process.env.POSTGRES_HOST || 'localhost';
    this.postgresUsername = process.env.POSTGRES_USERNAME || null;
    this.postgresPassword = process.env.POSTGRES_PASSWORD || null;
  }
}

module.exports = exports = new Config();
