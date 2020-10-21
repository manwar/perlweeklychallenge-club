// Input
const S = 'The purpose of our lives is to be happy';

// Output
const res = S.replace(/^[^\s]+\s(.*)\s[^\s]+$/, '$1').replace(/ /g, '');

console.log(res.length);