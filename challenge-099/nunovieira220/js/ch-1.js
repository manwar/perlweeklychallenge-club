// Input
const S = 'abcde';
const P = 'a*c?e';

// Pattern Match
const regex = P.replace(/(\?|\*)/g, '.$1');
const res = S.match(new RegExp(`^${regex}$`, "g"));

// Output
console.log(res ? 1 : 0);
