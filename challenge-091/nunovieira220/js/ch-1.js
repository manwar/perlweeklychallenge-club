// Input
const N = 2333445;

// Count Number
const S = N.toString();
let res = "";
let last = S.substring(0, 1);
let counter = 1;

for (const C of S.substring(1, S.length)) {
  if(C != last) {
    res += counter+last;
    counter = 0;
    last = C;
  }

  counter++;
}

// Output
console.log(res + counter + last);