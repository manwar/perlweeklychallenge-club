#!/usr/bin/env node

// run <script> <nr of cities>

const _ = require('lodash')

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

function mkRMat(n) {
    return [...Array(n).keys()].map(i => {
	return [...Array(n).keys()].map(j => (i==j) ? (0) : (Math.floor(Math.random()*9)+1))
    })
}

function sayMat(m) {
    m.forEach(row => console.log(row))
}

function pathCost(path,mat) {
    return [...Array(path.length).keys()].map(i => mat[path[i]][path[(i+1)%path.length]]).reduce((x,y) => x+y, 0)
}

const nr=parseInt(process.argv[2])
const mat = mkRMat(nr)

console.log("Your matrix:")
sayMat(mat)

const sol=_.minBy(permute([...Array(nr).keys()]).map(perm => [perm, pathCost(perm, mat)]), p => p[1])

console.log(`Optimal cost: ${sol[1]}`)
console.log(`Optimal path: ${sol[0].concat(sol[0][0])}`)
