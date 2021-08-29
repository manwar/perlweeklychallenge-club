"use strict";

let n = 25;
let list = Array(n)
  .fill()
  .map((x, i) => i + 1)
  .filter((x) => ! x.toString().match(/1/) )
  ;
console.log(list.join(", "));

