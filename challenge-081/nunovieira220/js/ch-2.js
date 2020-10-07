const fs = require('fs');

// Input
const sums = {};
const freqs = {};
const data = fs.readFileSync(`${__dirname}/input.txt`, { encoding: 'utf8' });
const words = data.replace(/--|\n/g, ' ').split(/ /);

// Get word frenquencies from word list
words.forEach(token => {
  if(token) {
    const word = token.replace(/\.|"|'s|,|\(|\)/g, '');
    sums[word] = sums[word] ? sums[word] + 1 : 1;
  }
});

// Join words by frequency
Object.keys(sums).sort().forEach(word => {
  if(!freqs[sums[word]]) freqs[sums[word]] = [];

  freqs[sums[word]].push(word);
});

// Output
Object.keys(freqs).sort().forEach(freq => console.log(freq + ': ' + freqs[freq].join(', ')));