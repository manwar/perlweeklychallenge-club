#!/usr/bin/env node

// run <script> <space-separated numbers>

/*
Heap's algorithm for generating permutations

Refs:

[0] https://stackoverflow.com/a/37580979/11064961
[1] https://en.m.wikipedia.org/wiki/Heap's_algorithm
*/

function permute(arr) {
  let length = arr.length,
      result = [arr.slice()],
      c = new Array(length).fill(0),
      i = 1, k, p;

  while (i < length) {
    if (c[i] < i) {
      k = i % 2 && c[i];
      p = arr[i];
      arr[i] = arr[k];
      arr[k] = p;
      ++c[i];
      i = 1;
      result.push(arr.slice());
    } else {
      c[i] = 0;
      ++i;
    }
  }
  return result;
}

Array.prototype.sum = function () {
    return this.reduce((acc,val) => acc + val, 0)
}

function checkAllSumsEqNr(nr,ar,bl) {
    if (ar.length <= 3) {
	return (nr == ar.sum()) && bl
    };
    return checkAllSumsEqNr(
	nr,
	ar.slice(2),
	(nr == ar.slice(0,3).sum()) && bl
    )
};

function allSumsEq(ar) {
    if (ar.length <= 2) {
	return true;
    };
    return checkAllSumsEqNr(
	ar.slice(0,2).sum(),
	ar.slice(1),
	true
    )
}; 

function pprnt(ar) {
    const sm = ar.slice(0,2).sum();
    const lettersId = ar.map((v,i) => `${String.fromCharCode(97+i)} = ${ar[i]}`).join(", ");
    return `\nSolution: ${lettersId}\nSum: ${sm}`;
}

const inpt = process.argv.slice(2).map(x => parseInt(x,10));
const sols = permute([...inpt]).filter(allSumsEq);

console.log((sols.length == 0) ? ("No solution.") : (sols.map(pprnt).join("\n")));
