// Input
const A = [1, 3, 5, 7];
const N = 6;

// Search Insert Position
let index = A.length;
let exists = false;

for(let i = 0; i < A.length; i++) {
  exists = N === A[i];

  if(N <= A[i]) {
    index = i;
    break;
  }
}

if(!exists) A.push(A.splice(index).unshift(N));

// Output
console.log(index);
