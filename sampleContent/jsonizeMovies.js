
const csvjson = require('csvjson'),
  fs = require('fs'),
  path = require('path'),
  jsonfile = require('jsonfile');

const data = fs.readFileSync(path.join(__dirname, './movierecs.csv'), { encoding : 'utf8'});

const options = { delimiter : ','};
const jsonData = csvjson.toObject(data, options);

const file = path.join(__dirname, './movierecs.json');

jsonfile.writeFile(file, jsonData, function(err){
  if (err) { console.log(err); }
});
