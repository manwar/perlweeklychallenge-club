#!/usr/bin/env node
"use strict";

// let us make an unsorted array
let array = Array(10)
  .fill()
  .map((n, i) => 1 + i)
  .map((value) => ({ value, sort: Math.random() }))
  .sort((a, b) => a.sort - b.sort)
  .map(({ value }) => value);
console.log(array.join(" "));

// here, we're helped by the fact that JS does things at the
// millisecond level, not the second level
for (let i of array) {
  setTimeout(() => {
    process.stdout.write(i + " ");
  }, i);
}
