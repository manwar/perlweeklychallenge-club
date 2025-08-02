const ints = [1, 2, 2, 4, 1, 5];
//const ints = [1, 2, 3, 4, 5];


var frequencies = {};
var highest = 0;
var total = 0;

ints.forEach((curInt, i) => {
  frequencies[curInt] = (frequencies[""+curInt] === undefined) ? 1 : frequencies[""+curInt]+1;
  if(frequencies[""+curInt] > highest) highest=frequencies[""+curInt];
});

(new Set(ints)).forEach((curInt, i) => {
  if(frequencies[""+curInt] === highest) total+=frequencies[""+curInt];
});

console.log("Output: " + total);
