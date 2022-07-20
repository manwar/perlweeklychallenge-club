// The Weekly Challenge 174
// Task 1 Disarium Numbers
// Node.js Solution

let disar = 0;     
for (let n=0; n < 9999999; n++) {
  let total = 0;
  for([i, v] of n.toString().split("").entries()) {
    total += v**(i+1);
  }
  if (total === n) {
    console.log(n);
    disar++;
  }
  if (disar===19) {break;}
}


/* 0 to 9
89
135
175
518
598
1306
1676
2427
2646798
*/
