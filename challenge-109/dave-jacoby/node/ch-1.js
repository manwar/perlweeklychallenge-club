"use strict";

let list = Array(20)
  .fill()
  .map((x, i) => i + 1)
  .map((x) => chowla(x));
console.log(list.join(", "));

function chowla(n) {
  return Array(n)
    .fill()
    .map((x, i) => i + 1)
    .filter((x) => x != 1)
    .filter((x) => x != n)
    .filter((x) => n % x == 0)
    .reduce((a, v) => a + v, 0);
}
