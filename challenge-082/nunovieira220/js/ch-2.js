// Interleave
const interleave = (A, B, C) => {
  if(A.length + B.length !== C.length) {
    return 0;
  }

  return interleaveChecker(A, B, C);
}

// Interleave checker
const interleaveChecker = (A, B, C) => {
  if(!C) return 1;

  const a = A.charAt(0);
  const b = B.charAt(0);
  const c = C.charAt(0);
  let firstTree = 0;
  let secondTree = 0;

  if(a === c) {
    firstTree = interleaveChecker(A.substring(1), B, C.substring(1));
  }

  if(b === c) {
    secondTree = interleaveChecker(A, B.substring(1), C.substring(1))
  }

  return firstTree + secondTree > 0 | 0;
}

// Input
const A = 'XXY';
const B = 'XXZ';
const C = 'XXXXZY';

// Output
console.log(interleave(A, B, C));

