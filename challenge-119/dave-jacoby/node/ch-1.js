"use strict";

for (let i in Array(21).fill("")) {
  let v = flopped(i);
  console.log(["", i, v].join("\t"));
}

console.log(["", 86, flopped(86)].join("\t"));
console.log(["", 101, flopped(101)].join("\t"));
console.log(["", 18, flopped(18)].join("\t"));
console.log(["", 33, flopped(33)].join("\t"));

function flopped(n) {
  let b = parseInt(n).toString(2);
  while (b.length < 8) {
    b = "0" + b;
  }
  let front = b.substring(0, 4);
  let back = b.substring(4);
  let r = back + front;
  let x = parseInt(r, 2);
  return x;
}
