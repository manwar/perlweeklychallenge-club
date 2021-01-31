// Input
const B = "101101110000";
const S = 4;

// Binary Substrings
const chunk = B.match(new RegExp(`.\{1,${S}\}`,"g"));
let min = 0;

chunk.forEach(a => {
  let max = 0;

  chunk.forEach(p => {
    const result = (parseInt(a, 2) ^ parseInt(p, 2)) ^ (1 << 8) - 1;
    const newMax = result.toString(2).split('0').length - 1;

    if(newMax > max) max = newMax;
  });

  if(max > min) min = max;
});

// Output
console.log(min);
